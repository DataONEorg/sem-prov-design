function [predrought_effect drought_value recovery_time drought_number]=DroughtTimeScale(thr,len)

%fetch drought variable --drier is more negative
dv=ncread('C:\Christopher\projects\MMIF\SPEI_01.nc','spei');
dv=permute(dv,[2 1 3]);dv=dv(:,:,1:end-12);dv=flipdim(dv,1);
%Note: "Standardized Precipitation-Evapotranspiration Index" is zscore, see
%https://digital.csic.es/handle/10261/72264

%fetch effect variable --better is more positive
ev=ncread('Y:\MsTMIP\tem\BG1\TEM6_BG1_V1.0.1_Monthly_GPP.nc4','GPP');
ev(ev<-998)=NaN;ev=permute(ev,[2 1 3]);ev=ev.*(60*60*24*(365/12)*1000);
%Note: sandbox TEM BG1 GPP

%mask
mask=single(~isnan(nanmean(ev,3))&~isnan(nanmean(dv,3)));
mask(mask==0)=NaN;mask(mask==1)=0; %inverted mask

%prealloc
predrought_effect=mask;drought_value=mask;
recovery_time=mask;drought_number=mask;

%define droughts
arg_default('thr',-1); %default thr- sigma dv event
arg_default('len',3); %default len+ month dv length

%detrend & deseasonalize effect variable
[r c p]=size(ev); %track dimension
ev=reshape(ev(:),r*c,p)'; %reshape to time->row & col->pixel
ev=detrend(ev); %detrend
ev=reshape(ev',[r c p]); %reshape to lat/lon/month
ev=anomMonth(ev); %anomaly time series --full period base

%main engine
pixel=find(mask==0)'; %target pixels
for current_pixel=pixel
    %find pixel
    [I J]=ind2sub([360 720],current_pixel);
    vev=squeeze(ev(I,J,:))';
    vdv=squeeze(dv(I,J,:))';
    if sum(vev==0)==numel(vev) || any(isnan(vdv))
        continue %unsimulated (vector of all zeros) OR NaNs in time series
    end
    %drought events
    vevlen=slidefun('mean',len,vev);vdvlen=slidefun('mean',len,vdv); %len-sized mean window
    dv0=vdvlen<=thr; %presence/absence drought
    event_starts=[0 find(diff(dv0)~=0)]+1;
    event_lengths=[diff(event_starts),length(dv0)-event_starts(end)+1];
    event_value=dv0(event_starts);
    events=event_lengths>=len&event_value==1&event_starts>event_lengths; 
    [event_starts event_lengths]=deal(event_starts(events)',event_lengths(events)');
    %Note: start of drought event(s) --assert len months before event
    %iterate over event
    if ~isempty(event_starts)
        [predrought_effect0 drought_value0 recovery0]=deal([]); %prealloc
        for idx=1:numel(event_starts) 
            predrought_effect0(idx,:)=mean(vev(event_starts(idx)-event_lengths(idx):event_starts(idx)-1)); %predrought effect variable
            drought_value0(idx,:)=mean(vdv(event_starts(idx):event_starts(idx)+event_lengths(idx)-1)); %during-drought drought variable
            recovery_effect=vevlen(event_starts(idx)+event_lengths(idx):end)>predrought_effect0(idx,:); %when does effect meet/exceed predrought?
            recovery_drought=vdvlen(event_starts(idx)+event_lengths(idx):end)>drought_value0(idx,:); %when does drought meet/exceed predrought?
            tmp=find(recovery_effect&recovery_drought,1)./12; %recovery time (yr)
            if isempty(tmp),tmp=NaN;end %set no recovery observed to NaN
            recovery0(idx,:)=tmp; 
        end
        %mean across event(s)
        predrought_effect(I,J)=mean(nanmean(predrought_effect0,2)); 
        drought_value(I,J)=mean(nanmean(drought_value0,2)); 
        recovery_time(I,J)=mean(nanmean(recovery0,2));
        drought_number(I,J)=numel(event_starts);
    else
        continue %no drought events
    end       
end

%pedestrain visualizer
%%
pos=[0.7243 0.5860 0.0140 0.3393]; %where is colorbar?
clr=pmkmp(256,'CubicL'); %which colormap
do_figure('max',14,'lucida sans unicode');
subplot(2,1,1);
tmp=recovery_time;
tmp(tmp==0)=NaN; %mask
msc(tmp);
caxis([0 ceil(prctile(tmp(:),95))]);
colormap(clr)
colorbar off
pause(1)
h=colorbar('peer',gca,'position',pos); 
set(h,'ytick',[0 ceil(prctile(tmp(:),95))])
axes('position',[0.2883    0.5840    0.1350    0.1569]); %inset
[f0 x0]=ecdf(tmp(~isnan(tmp)));
stairs(x0,f0,'k','linewidth',2);
ylim([0 1.01])
set(gca,'linew',2)
set(gca,'XScale','log')
xlabel 'Recovery Time [yr]'
export_fig(['Drought_T' num2str(thr) 'D' num2str(len) '_RecoveryTime.png'],'-m2');

%%
do_figure('max',14,'lucida sans unicode');
subplot(2,1,1);
tmp=drought_value;
tmp(tmp==0)=NaN; %mask
msc(tmp);
caxis([floor(prctile(tmp(:),2.5)) ceil(prctile(tmp(:),97.5))]); 
colormap(clr)
colorbar off
pause(1)
h=colorbar('peer',gca,'position',pos); 
set(h,'ytick',[floor(prctile(tmp(:),2.5)) ceil(prctile(tmp(:),97.5))]);
axes('position',[0.2883    0.5840    0.1350    0.1569]); %inset
[f0 x0]=ecdf(tmp(~isnan(tmp)));
stairs(x0,f0,'k','linewidth',2);
ylim([0 1.01])
set(gca,'linew',2)
xlabel 'Drought Variable'
export_fig(['Drought_T' num2str(thr) 'D' num2str(len) '_DroughtVariable.png'],'-m2');

%%
do_figure('max',14,'lucida sans unicode');
subplot(2,1,1);
tmp=predrought_effect;
tmp(tmp==0)=NaN; %mask
msc(tmp);
caxis([floor(prctile(tmp(:),2.5)) ceil(prctile(tmp(:),97.5))]); 
colormap(b2r(floor(prctile(tmp(:),2.5)),ceil(prctile(tmp(:),97.5))))
colorbar off
pause(1)
h=colorbar('peer',gca,'position',pos); 
set(h,'ytick',[floor(prctile(tmp(:),2.5)) ceil(prctile(tmp(:),97.5))]);
axes('position',[0.2883    0.5840    0.1350    0.1569]); %inset
[f0 x0]=ecdf(tmp(~isnan(tmp)));
stairs(x0,f0,'k','linewidth',2);
ylim([0 1.01])
set(gca,'linew',2)
xlim([floor(prctile(tmp(:),1)) ceil(prctile(tmp(:),99))]);
xlabel 'Predrought Effect Variable'
export_fig(['Drought_T' num2str(thr) 'D' num2str(len) '_PredroughtEffectVariable.png'],'-m2');

%%
do_figure('max',14,'lucida sans unicode');
subplot(2,1,1);
tmp=drought_number;
tmp(tmp==0)=NaN; %mask
msc(tmp);
caxis([0 ceil(prctile(tmp(:),100))]); 
colormap(clr)
colorbar off
pause(1)
h=colorbar('peer',gca,'position',pos); 
set(h,'ytick',[0 ceil(prctile(tmp(:),100))]);
axes('position',[0.2883    0.5840    0.1350    0.1569]); %inset
[f0 x0]=ecdf(tmp(~isnan(tmp)));
stairs(x0,f0,'k','linewidth',2);
ylim([0 1.01])
set(gca,'linew',2)
xlabel(['Drought Number [n=' num2str(nansum(drought_number(:))) ']' ]);
export_fig(['Drought_T' num2str(thr) 'D' num2str(len) '_DroughtNumber.png'],'-m2');

%%
return
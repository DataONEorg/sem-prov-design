
Use case 42

@startuml images/42_uc.png
actor "Investigator" as client
usecase "12. Authentication" as authen
note top of authen
   Authentication may be provided 
   by an external service
   end note

package "DataONE"{
actor "Coordinating Node" as CN
actor "Member Node" as MN
usecase "13. Authorization" as author
usecase "01. Get Object" as get
usecase "16. Log event" as log
usecase "21. Notify subscribers" as subscribe
usecase "02. Search" as query

client -- get
CN -- get
MN -- get
get ..> author: <<includes>>
get ..> authen: <<includes>>
get ..> log: <<includes>>
get ..> subscribe: <<includes>>
get ..> query: <<includes>>
}
@enduml

@startuml images/42_seq.png
	Actor Investigator
   participant "Client Software" as app_client << Application >>
   participant "MN API" as mn_api << Member Node >>
   participant "CN API" as cn_api << Coordinating Node >>
   
   Investigator -> app_client
   
   app_client -> mn_api: get(session, PID)
   mn_api -> mn_api: isAuthorized(session, PID, READ)
     mn_api -> mn_api: read(PID)
     mn_api <- mn_api: bytes
     app_client <- mn_api: bytes
     
     == Query Event == 
       
     app_client -> cn_api: query(session, query)
     note right of app_client
     query for any derived datasets
     end note
     activate cn_api
	   cn_api -> cn_api: search -> objectList
	   note right of cn_api
	     The query response is a list 
	     of PIDs of primary resources 
	     this dataset is derived from
	   end note
	   cn_api -> cn_api: isAuthorized(session, pid, OP_GET)
	   app_client <-- cn_api: objectList
	 deactivate cn_api
   @enduml

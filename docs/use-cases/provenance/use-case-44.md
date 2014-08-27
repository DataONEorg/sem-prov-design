@startuml images/use-case-44.png
actor "Investigtor" as scientist
usecase "12. Authentication" as authn
note top of authn
  Authentication may be provided 
  by an external service
end note

package "DataONE"
    actor "Client Software" as client
    actor "Member Node" as mn
    actor "Coordinating Node" as cn
    usecase "44. Replicate Analyses" as rerun
    usecase "13. Authorization" as authz

scientist -- client
client -- rerun
mn -- rerun
cn -- rerun
rerun ..> authz: <<includes>>
rerun ..> authn: <<includes>>
    
@enduml

@startuml images/sequence-44.png

  !include plantuml.conf
   actor Investigator
   participant "Client Software" as app_client << Application >>
   participant "MN API" as mn_api << Member Node >>
   participant "CN API" as cn_api << Coordinating Node >>

   == Retreive primary dataset == 
   
   Investigator -> app_client
   
   app_client -> mn_api: get(session, PID)
   activate mn_api #D74F57
     mn_api -> mn_api: isAuthorized(session, PID, READ)
     mn_api -> mn_api: read(session,PID)
     mn_api <- mn_api: bytes
   deactivate mn_api
   app_client <-- mn_api: bytes
   
   == Retreive associated model/script == 
     
   app_client -> mn_api: get(session, PID)
   activate mn_api #D74F57
     mn_api -> mn_api: isAuthorized(session, PID, READ)
     mn_api -> mn_api: read(session,PID)
     mn_api <- mn_api: bytes
   deactivate mn_api
   app_client <-- mn_api: bytes
@enduml
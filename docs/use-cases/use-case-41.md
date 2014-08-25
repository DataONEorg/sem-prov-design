Use case 41

@startuml images/41_uc.png
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
usecase "41. Insert Relationship" as insert_rel
usecase "04. Create" as create
usecase "06. MN Synchronize" as mn_sync
client -- insert_rel
CN -- insert_rel
MN -- insert_rel
insert_rel ..> author: <<includes>>
insert_rel ..> authen: <<includes>>
insert_rel ..> create: <<includes>>
insert_rel ..> mn_sync: <<includes>>
}
@enduml 

@startuml images/41_seq.png
   Actor Investigator
   participant "Client Software" as app_client << Application >>
   Investigator -> app_client
   participant "MN API" as mn_api << Member Node >>
   participant "CN API" as cn_api << Coordinating Node >>
   
   app_client -> app_client: insertRelationship(subject_ID, \n object_ID, predicate_namespace, \n predicate_URI)
   
   app_client -> mn_api: create(auth_token, dataPackage)
   note right of app_client 
   Create request is sent 
   for each data object
   end note
   
   mn_api -> mn_api: store()

   cn_api -> mn_api: listObjects()
   
   mn_api --> cn_api: object list
   
   cn_api -> mn_api: get(pid)
   mn_api --> cn_api: object
   
   cn_api -> mn_api: getSystemMetadata(pid)
   mn_api --> cn_api: systemMetadata

   cn_api -> cn_api: store()
   cn_api -> cn_api: index()
   note right of cn_api
   Relationships are
   indexed and searchable
   end note

   @enduml
   
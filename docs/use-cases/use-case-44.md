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
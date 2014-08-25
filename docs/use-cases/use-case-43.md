@startuml images/use-case-43.png
actor "Investigator" as client
usecase "12. Authentication" as authn
note top of authn
  Authentication may be provided 
  by an external service
end note

package "DataONE"
  actor "Coordinating Node" as CN
  actor "Member Node" as MN
  usecase "13. Authorization" as authz
  usecase "43. Discover Derived Products" as discover
  client -- discover
  CN -- discover
  MN -- discover
  discover ..> authz: <<includes>>
  discover ..> authn: <<includes>>
@enduml

@startuml images/sequence-43.png

participant "Client" as app_client <<Application>>
participant "MNRead" as mnread <<Node>>
participant "CNCore" as cncore <<Node>>
@enduml
package Teambuilder


import grails.gorm.transactions.Transactional

@Transactional
class RemoveOrgService {

    def serviceMethod(orgId)
      {
        //deactivate the org, all it's roles, and anyone who has roles from it assigned.
        def removeOrg = TbOrganization.get(orgId)
  //      println 'removeOrg: '+ removeOrg
        removeOrg.removedDate = new Date()
        removeOrg.save(failOnError:true)

        def removeRoles = TbRoles.withCriteria{
          ilike('organization', orgId)
        }
  //      println 'removeRoles: '+removeRoles
  //      println "removeRoles.id: "+ removeRoles.id

        if(removeRoles.size() != 0){
          removeRoles.each{
            it.removedDate = new Date()
            it.save(failOnError:true)
          }


          def removeAssignedRoles = TbAssignedRoles.withCriteria{
            'in'('tbRolesId', removeRoles.surId)
          }

    //      println 'removeAssignedRoles: ' + removeAssignedRoles
          if(removeAssignedRoles.size() != 0){
            removeAssignedRoles.each{
              it.removedDate = new Date()
              it.save(failOnError:true)
            }
          }

        }
        def removeTeamNodes = TbHierarchy.withCriteria{
          ilike('organization', orgId)
        }
        println 'removeTeamNodes: '+removeTeamNodes
        if(removeTeamNodes.size() != 0){
          removeTeamNodes.each{
            it.removedDate = new Date()
            it.save(failOnError:true)
          }
        }

      }

}

package Teambuilder


import grails.gorm.transactions.Transactional

@Transactional
class RemoveRoleService {

    def serviceMethod(roleId)
      {
        //deactivate the role, and remove it from anyone who has it assigned.
        def removeRole = TbRoles.get(roleId.toInteger())
  //      println "removeRole: "+removeRole
        removeRole.removedDate = new Date()
        removeRole.save(failOnError:true)
        def removeAssignedRoles = TbAssignedRoles.withCriteria{
          ilike('tbRolesId', roleId)
        }

  //      println 'removeAssignedRoles: '+removeAssignedRoles

        removeAssignedRoles.each{
          it.removedDate = new Date()
          it.save(failOnError:true)
        }

      }

}

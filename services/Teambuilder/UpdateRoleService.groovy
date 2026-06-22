package Teambuilder


import grails.gorm.transactions.Transactional

@Transactional
class UpdateRoleService {

    def serviceMethod(roleId,roleName,roleDescription)
      {
        def a = TbRoles.withCriteria{
          ilike('surId', roleId)
        }
    //    println "a: "+a

        a.each{
    //      println "it: "+it
          it.roleName = roleName
          it.roleDescription = roleDescription
          it.save(failOnError:true)
        }

      }

}

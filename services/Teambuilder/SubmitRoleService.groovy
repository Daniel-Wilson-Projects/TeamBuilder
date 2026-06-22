package Teambuilder


import grails.gorm.transactions.Transactional

@Transactional
class SubmitRoleService {

    def serviceMethod(organization, roleName, roleDescription, creatorPidm)
      {
    //    println 'SubmitRoleService.serviceMethod Hit'
        def newRole = new TbRoles()
        newRole.organization = organization
        newRole.roleName = roleName
        newRole.roleDescription = roleDescription
        newRole.creatorPidm = creatorPidm
        newRole.createdDate = new Date()
        newRole.activityDate = new Date()
        newRole.save(failOnError:true,flush:true)
    //    println "newRole"+newRole
      }

}

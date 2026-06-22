package Teambuilder


import grails.gorm.transactions.Transactional

@Transactional
class SubmitOrgService {

    def serviceMethod(organization, description, creatorPidm)
      {
    //    println 'SubmitOrgService.serviceMethod Hit'
        def newOrg = new TbOrganization()
        newOrg.organization = organization
        newOrg.description = description
        newOrg.activityDate = new Date()
        newOrg.createdDate = new Date()
        newOrg.creatorPidm = creatorPidm
        newOrg.save(failOnError:true)
    //    println "newOrg"+newOrg
      }

}

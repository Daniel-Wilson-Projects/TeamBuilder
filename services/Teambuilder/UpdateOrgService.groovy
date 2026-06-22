package Teambuilder


import grails.gorm.transactions.Transactional

@Transactional
class UpdateOrgService {

    def serviceMethod(orgId,organization,description)
      {
        def a = TbOrganization.withCriteria{
          ilike('surId', orgId)
        }

    //    println "a: "+a
        a.each{
      //    println it
          it.organization = organization
          it.description = description
          it.save(failOnError:true)
        }

      }

}

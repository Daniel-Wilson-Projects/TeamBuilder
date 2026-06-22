package Teambuilder


import grails.gorm.transactions.Transactional

@Transactional
class SubmitApplicationService {

    def serviceMethod(applicationName, applicationDescription)
      {
    //    println 'SubmitApplicationService.serviceMethod Hit'
        def newApp = new TbGrailsApplications()
        newApp.applicationName = applicationName
        newApp.applicationDescription = applicationDescription
        newApp.activityDate = new Date()
        newApp.save(failOnError:true)
    //    println "newApp"+newApp
      }

}

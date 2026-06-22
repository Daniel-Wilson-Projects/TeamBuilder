package Teambuilder


import grails.gorm.transactions.Transactional

@Transactional
class SubmitApplicationActionService {

    def serviceMethod(appId, applicationActionName, applicationActionDescription)
      {
    //    println 'SubmitApplicationActionService.serviceMethod Hit'
        def newApp = new TbGrailsApplicationsActions()
        newApp.grailsApplicationsId = appId
        newApp.actionName = applicationActionName
        newApp.actionDescription = applicationActionDescription
        newApp.activityDate = new Date()
        newApp.save(failOnError:true)
    //    println "newApp"+newApp
      }

}

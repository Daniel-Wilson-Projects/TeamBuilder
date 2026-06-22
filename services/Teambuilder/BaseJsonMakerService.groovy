package Teambuilder


import oracle.jdbc.driver.OracleTypes

import grails.gorm.transactions.Transactional

@Transactional
class BaseJsonMakerService {

    def serviceMethod(personSelected)
      {


      def a = new GrailsJson()
      a.items = '{"targetObjects": {}}'
      a.pidm = personSelected
      a.activityDate = new Date()
      a.save(flush:true)

      }

}

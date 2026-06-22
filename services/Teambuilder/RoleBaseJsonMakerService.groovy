package Teambuilder


import oracle.jdbc.driver.OracleTypes

import grails.gorm.transactions.Transactional

@Transactional
class RoleBaseJsonMakerService {

    def serviceMethod(roleSelected)
      {


      def a = new GrailsJson()
      a.items = '{"targetObjects": {}}'
      a.roleId = roleSelected
      a.activityDate = new Date()
      a.save(flush:true)

      }

}

package Teambuilder

import java.sql.*
import groovy.sql.Sql
import oracle.jdbc.driver.OracleTypes

import grails.gorm.transactions.Transactional

@Transactional
class RoleJsonArrayService {
def dataSource
    def serviceMethod(finalJsonUpdateString,roleSelected)
      {
    //    println 'JsonArrayService Hit'

    //    println "finalJsonUpdateString"+finalJsonUpdateString
        def updateString = "update grizdata.grails_json set items = json_mergepatch(items, '"+finalJsonUpdateString+"' RETURNING CLOB) where role_id = "+roleSelected

      //works, keeping for reference. using grails template string "Exmpale: ${stuff}" to build a string was breaking the sql query
      //def sqlCopyString = """update grizdata.grails_json set items = json_mergepatch(items, '{"permissions":{"Team Builder":{"organizations":["create","update","read"]}}}') where pidm = 32460"""

    //  println 'updateString'+updateString
      def sql1 = new Sql(dataSource)
      def peopleList = sql1.executeUpdate(updateString)

      }

}

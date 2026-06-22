package Teambuilder

import java.sql.*
import groovy.sql.Sql
import oracle.jdbc.driver.OracleTypes

import grails.gorm.transactions.Transactional

@Transactional
class JsonArrayService {
def dataSource
    def serviceMethod(finalJsonUpdateString,personSelected)
      {
    //    println 'JsonArrayService Hit'

    //    println "finalJsonUpdateString"+finalJsonUpdateString
        def updateString = "update grizdata.grails_json set items = json_mergepatch(items, '"+finalJsonUpdateString+"' RETURNING CLOB) where pidm = "+personSelected

      //works, keeping for reference. using grails template string "Exmpale: ${stuff}" to build a string was breaking the sql query
      //def sqlCopyString = """update grizdata.grails_json set items = json_mergepatch(items, '{"permissions":{"Team Builder":{"organizations":["create","update","read"]}}}') where pidm = 32460"""

    //  println 'updateString'+updateString
      def sql1 = new Sql(dataSource)
      def peopleList = sql1.executeUpdate(updateString)

      }

}

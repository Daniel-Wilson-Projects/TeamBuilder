package Teambuilder


import oracle.jdbc.driver.OracleTypes

import grails.gorm.transactions.Transactional
import java.sql.*
import groovy.sql.Sql
import oracle.jdbc.driver.OracleTypes

import groovy.json.*
import grails.converters.JSON

import groovy.json.JsonOutput
import groovy.json.JsonSlurper

@Transactional
class FetchTBpermissionsService {
def dataSource
    def serviceMethod(personSelected)
      {

        println "params.personSelected"+personSelected
        def sql0 = new Sql(dataSource)
      //	def grailsPermissionsJson = ""

        //I THINK DOING THE TO_CHAR hits the 4000 varchar limit. Alt version mapped as a domain with text column to handle the clob eaier.
        def javascriptPermissionsJson = sql0.rows("""select * from grizdata.grails_json where grails_json.pidm = :personSelected or grails_json.role_id in (select TB_ROLES_ID from TB_ASSIGNED_ROLES where pidm = :personSelected and TB_ASSIGNED_ROLES.REMOVED_DATE is null)""",[personSelected:personSelected])

        println 'javascriptPermissionsJson: '+javascriptPermissionsJson
        println 'javascriptPermissionsJson[0]: '+javascriptPermissionsJson[0]
        println 'javascriptPermissionsJson.getClass(): '+javascriptPermissionsJson.getClass()

        def jsonSlurper = new JsonSlurper()
        def holder = [:]

        if(javascriptPermissionsJson[0] != null){
          println 'if'
          //They have any permissions setup
          for (def i = 0;i> javascriptPermissionsJson.size();i++ ) {
              def a = jsonSlurper.parseText(it.ITEMS.getCharacterStream().getText())
              holder = merge(holder, a)
          }
          println 'if Holder:'+holder

        }else{
          println 'else'
          //they have no TB roles or TB person permissions
          def b = jsonSlurper.parseText('{"targetObjects": {}}')
          holder = b

        }

        return holder
      }

    def merge(Map lhs,Map rhs){
      if(lhs == [:])return rhs
      if(rhs == [:])return lhs
      return rhs.inject(lhs.clone()) { map,entry ->
          if (map[entry.key] instanceof Map && entry.value instanceof Map) {
              map[entry.key] = merge(map[entry.key],entry.value)
              } else {
                map[entry.key] = entry.value
              }
              return map
            }
  }

}

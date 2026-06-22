package Teambuilder

import oracle.jdbc.driver.OracleTypes


import java.sql.*
import groovy.sql.Sql
import oracle.jdbc.driver.OracleTypes

import groovy.json.*
import grails.converters.JSON

import groovy.json.JsonOutput
import groovy.json.JsonSlurper

import grails.gorm.transactions.Transactional

@Transactional
class CombineAndApplyService {
def dataSource
    def serviceMethod(sourceRolesHolder,sourcePeopleHolder,targetRolesHolder,targetPeopleHolder)
      {

        println 'sourceRolesHolder: '+ sourceRolesHolder
        println 'sourcePeopleHolder: '+ sourcePeopleHolder
/*
        def sql0 = new Sql(dataSource)
        javascriptPermissionsJsonHolder = []
        def javascriptPermissionsJson = sql0.rows("""select * from grizdata.grails_json where grails_json.pidm = :personSelected or grails_json.role_id in (select TB_ROLES_ID from TB_ASSIGNED_ROLES where pidm = :personSelected and TB_ASSIGNED_ROLES.REMOVED_DATE is null)""",[personSelected:personSelected])

        println 'javascriptPermissionsJson: '+javascriptPermissionsJson
        println 'javascriptPermissionsJson[0]: '+javascriptPermissionsJson[0]
        println 'javascriptPermissionsJson.getClass(): '+javascriptPermissionsJson.getClass()

        def jsonSlurper = new JsonSlurper()
        def holder = [:]

        if(javascriptPermissionsJson[0] != null){
          //They have any permissions setup

        javascriptPermissionsJson.each{
          println "it"
          def a = jsonSlurper.parseText(it.ITEMS.getCharacterStream().getText())
          println "a:"+a
          holder = merge(holder, a)
        }

          println 'holder: '+holder
          println 'holder.getClass(): '+holder.getClass()
        }else{
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

*/


      }

}

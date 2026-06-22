package Teambuilder


import oracle.jdbc.driver.OracleTypes

import grails.gorm.transactions.Transactional

@Transactional
class TbUpdateNodeService {

    def serviceMethod(selectedNode, selectedPidm)
      {
    //    println "TbUpdateNodeService hit"
    //    println 'selectNode: '+selectedNode
    //    println "selectedPidm: "+selectedPidm
        def toChange = TbHierarchy.get(selectedNode.toInteger())


    //    println 'toChange: '+ toChange
        toChange.pidm = selectedPidm
        toChange.assignedDate = new Date()
        toChange.save(flush:true,failOnError:true)

        return toChange.organization

      }

}

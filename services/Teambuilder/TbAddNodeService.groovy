package Teambuilder


import oracle.jdbc.driver.OracleTypes

import grails.gorm.transactions.Transactional

@Transactional
class TbAddNodeService {

    def serviceMethod(selectedNode, creatorPidm)
      {
        def addingNode = new TbHierarchy()
        addingNode.parentNodeId = selectedNode

        def parentNode = TbHierarchy.get(selectedNode)

        addingNode.organization = parentNode.organization
        addingNode.creatorPidm = creatorPidm
        addingNode.save(failOnError:true)

        return parentNode.organization
      }

}

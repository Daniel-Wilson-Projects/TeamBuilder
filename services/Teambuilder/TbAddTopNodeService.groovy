package Teambuilder


import oracle.jdbc.driver.OracleTypes

import grails.gorm.transactions.Transactional

@Transactional
class TbAddTopNodeService {

    def serviceMethod(selectedOrganization,creatorPidm)
      {
        def addingTopNode = new TbHierarchy()
        addingTopNode.organization = selectedOrganization
        addingTopNode.creatorPidm = creatorPidm
        addingTopNode.save(failOnError:true)

        return addingTopNode.organization
      }

}

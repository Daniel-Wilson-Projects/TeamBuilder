package Teambuilder


import oracle.jdbc.driver.OracleTypes

import grails.gorm.transactions.Transactional

@Transactional
class TbAssignOrRemoveRoleService {

    def serviceMethod(selectedRoleId, selectedPidm, checkmarkStatus)
      {
  //      println "UpdateAssignedRoleService hit"
  //      println 'selectedRoleId: '+selectedRoleId
  //      println "selectedPidm: "+selectedPidm
  //      println "checkmarkStatus: "+checkmarkStatus

        if(checkmarkStatus == 'true'){
  //        println 'create role entry and assigned date'
          def toCreate = new TbAssignedRoles()
          toCreate.tbRolesId = selectedRoleId
          toCreate.pidm = selectedPidm
          toCreate.assignedDate = new Date()
          toCreate.save(failOnError:true)
          return 'Entry Made'
        }

        if(checkmarkStatus == 'false'){
  //        println 'find and set removedate'
          def toRemove = TbAssignedRoles.withCriteria{
            ilike('tbRolesId', selectedRoleId)
            ilike('pidm', selectedPidm)
            isNull('removedDate')
          }

          toRemove.each{
            it.removedDate = new Date()
            it.save(failOnError:true)
          }
          return 'Entry Removed'
        }




      }

}

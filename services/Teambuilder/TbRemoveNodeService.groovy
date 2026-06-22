package Teambuilder


import oracle.jdbc.driver.OracleTypes


import grails.gorm.transactions.Transactional

@Transactional
class TbRemoveNodeService {
def dataSource
    def findAllDecendents(origin){
      def holder = origin
      def decendents = TbHierarchy.withCriteria{
        'in'('parentNodeId', origin.surId)
        not{
          'in'('surId', origin.surId)
        }
      }

      decendents.each{holder.add(it)}
  //    println 'merged list: '+holder
  //    println 'decendents.size(): '+decendents.size()
      if(decendents.size() != 0){
        findAllDecendents(holder)
      }else{
        return holder
      }
    }

    def serviceMethod(selectedNode)
      {
    //    println "TbRemoveNodeService hit"
    //    println 'selectedNode: '+selectedNode

        def toRemove = TbHierarchy.withCriteria{
          ilike('surId',selectedNode.toString())
        }
    //    println 'toRemove: '+toRemove
        def workingOrganization = toRemove.organization
        def decendentList=[]
        //orphans list includes the parent to be stripped of roles
        def orphans = findAllDecendents(toRemove)
    //    println 'orphans: '+orphans

        //strip toRemove of it's roles in the organization for orphans
        def rolesToRemove = TbAssignedRoles.withCriteria{
          'in'('pidm',orphans.pidm)
          isNull('removedDate')
        }
    //    println '1'
    //    rolesToRemove.each{
    //      println it
    //    }
    //    println '2'
        //remove orphans from nodes
        def orphanNodes = TbHierarchy.withCriteria{
          'in'('surId',orphans.surId)
          isNull('removedDate')
        }
    //    println '3'
        orphanNodes.each{
          it.removedDate = new Date()
          it.save(failOnError:true)
        }
    //    println "orphanNodes: "+orphanNodes



        return workingOrganization

      }

}

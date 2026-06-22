package Teambuilder

import grails.gorm.transactions.Transactional

@Transactional
class PermissionsPidmListService {
def dataSource
    def serviceMethod(permissions, creatorPidm)
      {
        //EXAMPLE OF HOW TO ACCESS PERMISSIONS DATA
  //			println 'permissions['+'targetObjects'+']['+'Team Builder'+']['+'organizations'+']['+'population'+']: '+permissions?.getAt('targetObjects')?.('Team Builder')?.('organizations')?.('population')
  //			println '------------------------'
  			permissions?.getAt('targetObjects')?.('Team Builder')?.('organizations')?.('population')?.each{println it.key }

  			def createableCreatorPidms = []
  			def readableCreatorPidms = []
  			def updateableCreatorPidms = []
  			def deleteableCreatorPidms = []

  			//add users own pidm into all populated lists
  			createableCreatorPidms.add(creatorPidm)
  			readableCreatorPidms.add(creatorPidm)
  			updateableCreatorPidms.add(creatorPidm)
  			deleteableCreatorPidms.add(creatorPidm)

  			//looking for specfic permissons for gsp logics and/or data loads.
  			permissions?.getAt('targetObjects')?.('Team Builder')?.('organizations')?.('population')?.each{
  				if(it.value.contains('create')){
  				createableCreatorPidms.add(it.key.toString())
  				}
  				if(it.value.contains('read')){
  				readableCreatorPidms.add(it.key.toString())
  				}
  				if(it.value.contains('update')){
  				updateableCreatorPidms.add(it.key.toString())
  				}
  				if(it.value.contains('delete')){
  				deleteableCreatorPidms.add(it.key.toString())
  				}
  			}

  //			println 'readableCreatorPidms: '+readableCreatorPidms
  //			println "readableCreatorPidms.join(','): "+ readableCreatorPidms.join(',')

        return  [createableCreatorPidms:createableCreatorPidms,readableCreatorPidms:readableCreatorPidms,updateableCreatorPidms:updateableCreatorPidms,deleteableCreatorPidms:deleteableCreatorPidms]
      }

}

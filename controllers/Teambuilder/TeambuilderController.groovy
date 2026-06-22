package Teambuilder
import grails.plugin.springsecurity.annotation.Secured
import common.MsuPersonBio

import java.sql.*
import groovy.sql.Sql
import oracle.jdbc.driver.OracleTypes

import groovy.json.*
import grails.converters.JSON

import groovy.json.JsonOutput
import groovy.json.JsonSlurper
import grizapps2.AppUser


class TeambuilderController {
def dataSource
def FetchTBpermissionsService
def PermissionsPidmListService

	@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
    def organizations() {

			//May need to adopt use of using two pass through pidms, one for ADMIN proxeying (see what a user sees), manager save as proxey.
			//Or could use the same design and make sure a admin role is setup for each application with a full checkmark role lists.

			def creatorPidm = params.creatorPidm
			def a1 = sec.username()
			def b1 = AppUser.findByUsername(a1)
			if(creatorPidm == null){
				creatorPidm = b1.pidm
			}

			//fetch permissions and use that to filter what resources are loaded.
			// in this context looking for the list of people to read/see their organizations
			//TO SEE ALL ORGANIZATIONS ALL PERSONS IN PERMISSIONS JSON WOULD NEEDD TO BE CHECKED.
			def permissions = FetchTBpermissionsService.serviceMethod(b1.pidm)
		//	println 'permissions: '+permissions

			//make a service to get creatorPidms to reuse
			def permissionsPidmList = PermissionsPidmListService.serviceMethod(permissions,creatorPidm)
		//	println 'permissionsPidmList: '+ permissionsPidmList
			def permissionsPidmListReadable = permissionsPidmList.readableCreatorPidms.join(',').toString()

			def sql1 = new Sql(dataSource)
			def orgList = sql1.rows("select * from TB_ORGANIZATION join spriden on spriden.spriden_pidm = TB_ORGANIZATION.CREATOR_PIDM where TB_ORGANIZATION.CREATOR_PIDM in (:permissionsPidmListReadable) and spriden.spriden_change_ind is null and TB_ORGANIZATION.REMOVED_DATE is null",[permissionsPidmListReadable:permissionsPidmListReadable])
	//		println "orgList: "+orgList


		  def permissionsPidmListcreateable = permissionsPidmList.createableCreatorPidms.join(',').toString()

			//build name list for creator pidms to be displayed
			def sql2 = new Sql(dataSource)
	//		println 'preppedQuery2: '+preppedQuery2
			def proxeyList = sql2.rows("select * from spriden where spriden_pidm in (:permissionsPidmListcreateable) and spriden.spriden_change_ind is null",[permissionsPidmListcreateable:permissionsPidmListcreateable])

	//		println 'proxeyList: '+proxeyList
	//		println 'proxeyList.getClass(): '+proxeyList.getClass()
	//		println 'proxeyList.size(): '+ proxeyList.size()
			//call to service to collect thier roles, targetObjects, permissions
    [orgList:orgList,proxeyList:proxeyList,permissionsPidmList:permissionsPidmList]
    }

def SubmitOrgService
		@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
	    def submitOrg() {

				def creatorPidm = params.creatorPidm
				def a1 = sec.username()
				def b1 = AppUser.findByUsername(a1)
				if(creatorPidm == null){
					creatorPidm = b1.pidm
				}
				def activeUserPidm = b1.pidm

				//permisions need to be fetched to reaffirm them on the ajax provided interfaces being sent back.
				def permissions = FetchTBpermissionsService.serviceMethod(activeUserPidm)

				//make a service to get creatorPidms to reuse
				def permissionsPidmList = PermissionsPidmListService.serviceMethod(permissions,creatorPidm)
		//		println 'permissionsPidmList: '+ permissionsPidmList

				submitOrgService.serviceMethod(params.organization, params.description, creatorPidm)

				def preppedQuery = "select * from TB_ORGANIZATION join spriden on spriden.spriden_pidm = TB_ORGANIZATION.CREATOR_PIDM where TB_ORGANIZATION.CREATOR_PIDM in ("+permissionsPidmList.readableCreatorPidms.join(',').toString()+') and spriden.spriden_change_ind is null and TB_ORGANIZATION.REMOVED_DATE is null'
		//		println 'preppedQuery: '+preppedQuery

				def sql1 = new Sql(dataSource)
				def orgList = sql1.rows(preppedQuery)
	//			println "orgList: "+orgList

				//build name list for creator pidms to be displayed
				def sql2 = new Sql(dataSource)
				def preppedQuery2 = "select * from spriden where spriden_pidm in ("+permissionsPidmList.createableCreatorPidms.join(',').toString()+") and spriden.spriden_change_ind is null"
	//			println 'preppedQuery2: '+preppedQuery2
				def proxeyList = sql2.rows(preppedQuery2)

				//call to service to collect thier roles, targetObjects, permissions
	    [orgList:orgList,proxeyList:proxeyList,permissionsPidmList:permissionsPidmList]
	    }

def RemoveOrgService

		@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
				def removeOrg() {

					def creatorPidm = params.creatorPidm
					def a1 = sec.username()
					def b1 = AppUser.findByUsername(a1)
					if(creatorPidm == null){
						creatorPidm = b1.pidm
					}
					def activeUserPidm = b1.pidm

					def a = removeOrgService.serviceMethod(params.orgId)

					//permisions need to be fetched to reaffirm them on the ajax provided interfaces being sent back.
					def permissions = FetchTBpermissionsService.serviceMethod(activeUserPidm)

					//make a service to get creatorPidms to reuse
					def permissionsPidmList = PermissionsPidmListService.serviceMethod(permissions,activeUserPidm)
	//				println 'permissionsPidmList: '+ permissionsPidmList

					def preppedQuery = "select * from TB_ORGANIZATION join spriden on spriden.spriden_pidm = TB_ORGANIZATION.CREATOR_PIDM where TB_ORGANIZATION.CREATOR_PIDM in ("+permissionsPidmList.readableCreatorPidms.join(',').toString()+') and spriden.spriden_change_ind is null and TB_ORGANIZATION.REMOVED_DATE is null'
	//				println 'preppedQuery: '+preppedQuery

					def sql1 = new Sql(dataSource)
					def orgList = sql1.rows(preppedQuery)
	//				println "orgList: "+orgList

					//build name list for creator pidms to be displayed
					def sql2 = new Sql(dataSource)
					def preppedQuery2 = "select * from spriden where spriden_pidm in ("+permissionsPidmList.createableCreatorPidms.join(',').toString()+") and spriden.spriden_change_ind is null"
	//				println 'preppedQuery2: '+preppedQuery2
					def proxeyList = sql2.rows(preppedQuery2)

					//call to service to collect thier roles, targetObjects, permissions
					[orgList:orgList,proxeyList:proxeyList,permissionsPidmList:permissionsPidmList]
				}

		@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
			def viewOrg(){

				def creatorPidm = params.creatorPidm
				def a1 = sec.username()
				def b1 = AppUser.findByUsername(a1)
				if(creatorPidm == null){
					creatorPidm = b1.pidm
				}
				def activeUserPidm = b1.pidm

				//permisions need to be fetched to reaffirm them on the ajax provided interfaces being sent back.
				def permissions = FetchTBpermissionsService.serviceMethod(activeUserPidm)

				//make a service to get creatorPidms to reuse
				def permissionsPidmList = PermissionsPidmListService.serviceMethod(permissions,activeUserPidm)
//				println 'permissionsPidmList: '+ permissionsPidmList

				def viewOrg = TbOrganization.withCriteria{
					ilike('surId', params.orgId)
				}

//				println 'viewOrg: '+ viewOrg

				[viewOrg:viewOrg]
			}
def UpdateOrgService
		@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
			def updateOrg(){

				def a = updateOrgService.serviceMethod(params.orgId,params.organization,params.description)


				render 'Update Submitted'
		 }

		 @Secured(["ROLE_ADMIN","ROLE_TB_USER"])
 			def viewRole(){

			def creatorPidm = params.creatorPidm
			def a1 = sec.username()
			def b1 = AppUser.findByUsername(a1)
			if(creatorPidm == null){
				creatorPidm = b1.pidm
			}
			def activeUserPidm = b1.pidm
			//permisions need to be fetched to reaffirm them on the ajax provided interfaces being sent back.

			def permissions = FetchTBpermissionsService.serviceMethod(activeUserPidm)
			//make a service to get creatorPidms to reuse

			def permissionsPidmList = PermissionsPidmListService.serviceMethod(permissions,activeUserPidm)
//			println 'permissionsPidmList: '+ permissionsPidmList

			def viewRole = TbRoles.withCriteria{
				ilike('surId', params.roleId)
			}

//			println 'viewRole: '+ viewRole
			[viewRole:viewRole]
 			}
def UpdateRoleService
 		@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
 			def updateRole(){
//				println 'params: '+params
					def a = updateRoleService.serviceMethod(params.roleId,params.roleName,params.roleDescription)
 					render 'Update Submitted'
 		 }

		@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
	    def roles() {

				def creatorPidm = params.creatorPidm
				def a1 = sec.username()
				def b1 = AppUser.findByUsername(a1)
				if(creatorPidm == null){
					creatorPidm = b1.pidm
				}

				//adding example permission checks to this action set
				def activeUserPidm = b1.pidm

				//permisions need to be fetched to reaffirm them on the ajax provided interfaces being sent back.
				def permissions = FetchTBpermissionsService.serviceMethod(activeUserPidm)

				//make a service to get creatorPidms to reuse
				def permissionsPidmList = PermissionsPidmListService.serviceMethod(permissions,creatorPidm)
//				println 'permissionsPidmList: '+ permissionsPidmList


				def preppedQuery = "select * from TB_ORGANIZATION join spriden on spriden.spriden_pidm = TB_ORGANIZATION.CREATOR_PIDM where TB_ORGANIZATION.CREATOR_PIDM in ("+permissionsPidmList.readableCreatorPidms.join(',').toString()+') and spriden.spriden_change_ind is null and TB_ORGANIZATION.REMOVED_DATE is null'
//				println 'preppedQuery: '+preppedQuery

				def sql1 = new Sql(dataSource)
				def orgList = sql1.rows(preppedQuery)
//				println "orgList: "+orgList



				//call to service to collect thier roles, targetObjects, permissions
		    [orgList:orgList]
		    }

		@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
		  def fetchRoles() {

				def creatorPidm = params.creatorPidm
				def a1 = sec.username()
				def b1 = AppUser.findByUsername(a1)
				if(creatorPidm == null){
					creatorPidm = b1.pidm
				}

//				println "params.organization:"+params.organization
				def proxey = params.organization.toInteger()
//				println "proxey:"+proxey

				//adding example permission checks to this action set
				def activeUserPidm = b1.pidm

				//permisions need to be fetched to reaffirm them on the ajax provided interfaces being sent back.
				def permissions = FetchTBpermissionsService.serviceMethod(activeUserPidm)

				//make a service to get creatorPidms to reuse
				def permissionsPidmList = PermissionsPidmListService.serviceMethod(permissions,activeUserPidm)
//				println 'permissionsPidmList: '+ permissionsPidmList

				def preppedQuery = "select * from TB_ROLES join spriden on spriden.spriden_pidm = TB_ROLES.CREATOR_PIDM where TB_ROLES.CREATOR_PIDM in ("+permissionsPidmList.readableCreatorPidms.join(',').toString()+') and spriden.spriden_change_ind is null and TB_ROLES.REMOVED_DATE is null and TB_ROLES.ORGANIZATION ='+proxey.toString()
//				println 'preppedQuery: '+preppedQuery


				def sql1 = new Sql(dataSource)
				def rolesList = sql1.rows(preppedQuery)
			//	println "orgList: "+orgList

		//  	def rolesList = TbRoles.findByOrganization(params.organization)
		//		def rolesList = TbRoles.withCriteria(){
    //  			ilike('organization', params.organization)
		//				ilike('creatorPidm', creatorPidm)
    //    }

//				println 'rolesList:'+rolesList


				//call to service to collect thier roles, targetObjects, permissions
				[rolesList:rolesList,permissionsPidmList:permissionsPidmList]
				}
def RemoveRoleService
		@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
	  def removeRole() {
//			println "removeRole params: "+params

			def a = RemoveRoleService.serviceMethod(params.roleId)




			def creatorPidm = params.creatorPidm
			def a1 = sec.username()
			def b1 = AppUser.findByUsername(a1)
			if(creatorPidm == null){
				creatorPidm = b1.pidm
			}

			def proxey = params.organization.toInteger()

			//adding example permission checks to this action set
			def activeUserPidm = b1.pidm

			//permisions need to be fetched to reaffirm them on the ajax provided interfaces being sent back.
			def permissions = FetchTBpermissionsService.serviceMethod(activeUserPidm)

			//make a service to get creatorPidms to reuse
			def permissionsPidmList = PermissionsPidmListService.serviceMethod(permissions,activeUserPidm)
//			println 'permissionsPidmList: '+ permissionsPidmList

			def preppedQuery = "select * from TB_ROLES join spriden on spriden.spriden_pidm = TB_ROLES.CREATOR_PIDM where TB_ROLES.CREATOR_PIDM in ("+permissionsPidmList.readableCreatorPidms.join(',').toString()+') and spriden.spriden_change_ind is null and TB_ROLES.REMOVED_DATE is null and TB_ROLES.ORGANIZATION ='+proxey.toString()
//			println 'preppedQuery: '+preppedQuery

			def sql1 = new Sql(dataSource)
			def rolesList = sql1.rows(preppedQuery)

			[rolesList:rolesList,permissionsPidmList:permissionsPidmList]
		}

def SubmitRoleService
		@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
	    def submitRole() {
				def creatorPidm = params.creatorPidm
				def a1 = sec.username()
				def b1 = AppUser.findByUsername(a1)
				if(creatorPidm == null){
					creatorPidm = b1.pidm
				}

				submitRoleService.serviceMethod(params.organization, params.roleName, params.roleDescription, creatorPidm)

				def proxey = params.organization.toInteger()

				//adding example permission checks to this action set
				def activeUserPidm = b1.pidm

				//permisions need to be fetched to reaffirm them on the ajax provided interfaces being sent back.
				def permissions = FetchTBpermissionsService.serviceMethod(activeUserPidm)

				//make a service to get creatorPidms to reuse
				def permissionsPidmList = PermissionsPidmListService.serviceMethod(permissions,activeUserPidm)
	//			println 'permissionsPidmList: '+ permissionsPidmList

				def preppedQuery = "select * from TB_ROLES join spriden on spriden.spriden_pidm = TB_ROLES.CREATOR_PIDM where TB_ROLES.CREATOR_PIDM in ("+permissionsPidmList.readableCreatorPidms.join(',').toString()+') and spriden.spriden_change_ind is null and TB_ROLES.REMOVED_DATE is null and TB_ROLES.ORGANIZATION ='+proxey.toString()
	//			println 'preppedQuery: '+preppedQuery

				def sql1 = new Sql(dataSource)
				def rolesList = sql1.rows(preppedQuery)

				[rolesList:rolesList,permissionsPidmList:permissionsPidmList]
			 	}

		@Secured(["ROLE_ADMIN"])
		    def applications() {
					//Applications and Application Actions are built for admins only at this point.
					//Both of these actions are setup to not allow s
					def a1 = sec.username()
					def b1 = AppUser.findByUsername(a1)
					def preppedQuery = "select * from TB_GRAILS_APPLICATIONS"
					def sql1 = new Sql(dataSource)
					def applicationsList = sql1.rows(preppedQuery)
			//		println "applicationsList: "+applicationsList
					//call to service to collect thier roles, targetObjects, permissions
		    [applicationsList:applicationsList]
		    }

def submitApplicationService
		@Secured(["ROLE_ADMIN"])
		    def submitApplication() {
					//Applications and Application Actions are built for admins only at this point.
					//Both of these actions are setup to not allow s

					def a = submitApplicationService.serviceMethod(params.applicationName,params.applicationDescription)


					def preppedQuery = "select * from TB_GRAILS_APPLICATIONS"
					def sql1 = new Sql(dataSource)
					def applicationsList = sql1.rows(preppedQuery)
			//		println "applicationsList: "+applicationsList
					//call to service to collect thier roles, targetObjects, permissions
		    [applicationsList:applicationsList]
		    }




					@Secured(["ROLE_ADMIN"])
				    def applicationActions() {

							//Applications and Application Actions are built for admins only at this point.


							def a1 = sec.username()
							def b1 = AppUser.findByUsername(a1)

							def preppedQuery = "select * from TB_GRAILS_APPLICATIONS"

							def sql1 = new Sql(dataSource)
							def applicationsList = sql1.rows(preppedQuery)
					//		println "applicationsList: "+applicationsList

							//call to service to collect thier roles, targetObjects, permissions
				    [applicationsList:applicationsList]
				    }

						@Secured(["ROLE_ADMIN"])
					    def fetchApplicationActions() {


								def sql1 = new Sql(dataSource)
				//				println 'params.appId'
								def applicationsActionsList = sql1.rows("select * from TB_GRAILS_APPLICATIONS_ACTIONS where TB_GRAILS_APPLICATIONS_ACTIONS.GRAILS_APPLICATIONS_ID = :id",[id:params.appId])

				//				println "applicationsActionsList: "+applicationsActionsList

								//call to service to collect thier roles, targetObjects, permissions
					    [applicationsActionsList:applicationsActionsList]
					    }

def submitApplicationActionService
		@Secured(["ROLE_ADMIN"])
		    def submitApplicationAction() {
					//Applications and Application Actions are built for admins only at this point.
					//Both of these actions are setup to not allow s
				//	println 'params'+params
					def a = submitApplicationActionService.serviceMethod(params.appId, params.actionName, params.actionDescription)


					def sql1 = new Sql(dataSource)
			//		println 'params.appId'
					def applicationsActionsList = sql1.rows("select * from TB_GRAILS_APPLICATIONS_ACTIONS where TB_GRAILS_APPLICATIONS_ACTIONS.GRAILS_APPLICATIONS_ID = :id",[id:params.appId])

			//		println "applicationsActionsList: "+applicationsActionsList

				[applicationsActionsList:applicationsActionsList]
		    }


	@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
    def index() {

    [:]
    }

	@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
	  def buildTeam() {
			def orgList = TbOrganization.withCriteria{
				isNull('removedDate')
			}

//			println 'orgList: '+orgList

			def sql1 = new Sql(dataSource)
			def peopleList = sql1.rows("""SELECT * from CC_MSU_STAFF order by last_name, pref_first_name, first_name""")
	/*		def peopleList =

			SELECT distinct spriden_pidm pidm,
			       spriden_id id,
			       spriden_last_name last_name,
			       spriden_first_name first_name,
			       d.gobtpac_external_user user_id,
			       spbpers_pref_First_name pref_first_name
			  FROM sgf_mv_pebempl a join spriden z on a.pebempl_pidm = spriden_pidm  left outer join GOBTPAC d  on pebempl_pidm = d.GOBTPAC_PIDM
			                        join spbpers p on z.spriden_pidm = p.spbpers_pidm
			WHERE spriden_change_ind is null
			   and (a.pebempl_jbln_code in ('WP','MTNGRV')
			   and a.pebempl_empl_status = 'A');
*/
		//call to service to collect thier roles, targetObjects, permissions



		[orgList:orgList, peopleList:peopleList]
	  }

def TbUpdateNodeService
	@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
		def tbUpdateNode(){

//			println "params.selectedNode: "+ params.selectedNode
//			println "params.selectedNode.length(): "+ params.selectedNode.length()
//			println "params.selectedPidm: "+ params.selectedPidm
			def updateStatus = tbUpdateNodeService.serviceMethod(params.selectedNode, params.selectedPidm)
			//call template to refresh the teamContainer
		//	render 'Update Node Hit'
			redirect(action: "loadTeam", params: [selectedOrganization: updateStatus])
		}
def TbRemoveNodeService
	@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
		def tbRemoveNode(){

			//TODO try to add a way to detect orphan records. either delete the whole chain or reparent to grandparent


//			println 'tbRemoveNode hit'
//			println "params.selectedNode: "+ params.selectedNode
			def removeStatus = tbRemoveNodeService.serviceMethod(params.selectedNode)

			//render 'Remove Node Hit'
			redirect(action: "loadTeam", params: [selectedOrganization: removeStatus])
		}
def TbAddNodeService
	@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
		def tbAddNode(){

			def creatorPidm = params.creatorPidm
			def a1 = sec.username()
			def b1 = AppUser.findByUsername(a1)
			if(creatorPidm == null){
				creatorPidm = b1.pidm
			}

//			println "params.selectedNode: "+ params.selectedNode
			def addStatus = tbAddNodeService.serviceMethod(params.selectedNode, creatorPidm)
			//	render 'Add Node Hit'
			redirect(action: "loadTeam", params: [selectedOrganization: addStatus])
		}
def TbAddTopNodeService
	@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
		def tbAddTopNode(){

			def creatorPidm = params.creatorPidm
			def a1 = sec.username()
			def b1 = AppUser.findByUsername(a1)
			if(creatorPidm == null){
				creatorPidm = b1.pidm
			}

//			println "params.selectedOrganization: "+ params.selectedOrganization
			def addTopStatus = tbAddTopNodeService.serviceMethod(params.selectedOrganization,creatorPidm)
			//	render 'Add Node Hit'
			redirect(action: "loadTeam", params: [selectedOrganization: addTopStatus])
		}


	@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
	 	def loadTeam() {
//				println "params.selectedOrganization: "+params.selectedOrganization
			def sql1 = new Sql(dataSource)
		//	def sql2 = new Sql(dataSource)
		//	def sql3 = new Sql(dataSource)


	 		 def hierarchy = sql1.rows("""SELECT * from TB_HIERARCHY left outer join spriden on spriden.spriden_pidm = TB_HIERARCHY.PIDM where ORGANIZATION = :selectedOrganization and spriden_change_ind is null and TB_HIERARCHY.REMOVED_DATE is null""",[selectedOrganization:params.selectedOrganization])
//			 println "hierarchy: "+ hierarchy
//			 println "hierarchy.size(): "+ hierarchy.size()

			 def sql2 = new Sql(dataSource)
			 def personsRolesList = sql2.rows("""SELECT * from TB_ASSIGNED_ROLES join TB_ROLES on TB_ASSIGNED_ROLES.TB_ROLES_ID = TB_ROLES.ID where TB_ROLES.ORGANIZATION = :selectedOrganization and TB_ASSIGNED_ROLES.REMOVED_DATE is null""",[selectedOrganization:params.selectedOrganization])
//			 println "personsRolesList: "+ personsRolesList

	//		def selectedOrganizationDescription = sql3.rows("""SELECT * from TB_ORGANIZATION where ORGANIZATION = :selectedOrganization and REMOVED_DATE is null""",[selectedOrganization:params.selectedOrganization])

			[hierarchy:hierarchy,personsRolesList:personsRolesList]
		}

		@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
		 	def loadTeamRoles() {
//					println "params.selectedOrganization: "+params.selectedOrganization
//					println "params.selectedPidm"+ params.selectedPidm

					def teamRoles = TbRoles.withCriteria{
						ilike('organization',params.selectedOrganization)
					}

					def selectedPersonsRoles = TbAssignedRoles.withCriteria{
						ilike('pidm', params.selectedPidm)
						isNull('removedDate')
					}
//					println 'selectedPersonsRoles: '+selectedPersonsRoles

				[teamRoles:teamRoles, selectedPersonsRoles:selectedPersonsRoles, selectedPidm:params.selectedPidm]
			}
def TbAssignOrRemoveRoleService
			@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
			 	def updateAssignedRole() {
//					println 'params.selectedRole: '+params.selectedRole
//					println 'params.selectedPidm: '+params.selectedPidm
//					println 'params.checkmarkStatus: '+params.checkmarkStatus
					def assignedRoleStatus = tbAssignOrRemoveRoleService.serviceMethod(params.selectedRole, params.selectedPidm, params.checkmarkStatus)

					render assignedRoleStatus
				}



	@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
	  def showTeam() {

			def rolesList = TbRoles.withCriteria(){
					ilike('organization', params.organization)
					order('roleOrder', 'asc')
			}
		//	def teamMembersRoles - connect their role/permissions onto the org chart

		//call to service to collect thier roles, targetObjects, permissions
		[rolesList:rolesList]
	  }


  @Secured(["ROLE_ADMIN","ROLE_TB_USER"])
    def viewTeams() {
      def teams = Teambuilder.getAll()

    [teams:teams]
    }

  @Secured(["ROLE_ADMIN","ROLE_TB_USER"])
    def createTeam() {



    [:]
    }

	@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
	   def personPermissions() {

		 def sql1 = new Sql(dataSource)

		 def peopleList = sql1.rows("""SELECT * from CC_MSU_STAFF order by last_name, pref_first_name, first_name""")

		 def sql2 = new Sql(dataSource)


			 //applicaitonList
			 def applicationsList = TbGrailsApplications.getAll()
	  [peopleList:peopleList, applicationsList:applicationsList]
	  }

		@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
		   def rolePermissions() {

			 def sql1 = new Sql(dataSource)

			 def peopleList = sql1.rows("""SELECT * from CC_MSU_STAFF order by last_name, pref_first_name, first_name""")

			 def sql2 = new Sql(dataSource)
			 def rolesList = sql1.rows("""SELECT a.ROLE_NAME, b.ORGANIZATION, a.ID from TB_ROLES a join TB_ORGANIZATION b on a.ORGANIZATION = b.ID""")
 //		   println 'rolesList: '+ rolesList

			 //applicaitonList
			 def applicationsList = TbGrailsApplications.getAll()
		  [peopleList:peopleList, applicationsList:applicationsList, rolesList:rolesList]
		  }

		def BaseJsonMakerService
	@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
    def fetchActions() {

			//actions
			def applicationsActions = TbGrailsApplicationsActions.withCriteria(){
				'ilike'('grailsApplicationsId',params.application)
			}
			def applicationSelected = TbGrailsApplications.get(params.application)
//			println "applicationSelected.applicationName"+applicationSelected.applicationName

//			println "params.personSelected"+params.personSelected
			def sql0 = new Sql(dataSource)
		//	def grailsPermissionsJson = ""

			//I THINK DOING THE TO_CHAR hits the 4000 varchar limit. Alt version mapped as a domain with text column to handle the clob eaier.
			def javascriptPermissionsJson = sql0.rows("""select items "items" from grizdata.grails_json where grails_json.pidm = :personSelected""",[personSelected:params.personSelected])
//--32460
//			println 'javascriptPermissionsJson: '+javascriptPermissionsJson
//			println 'javascriptPermissionsJson.getClass(): '+javascriptPermissionsJson.getClass()
//			println 'javascriptPermissionsJson.isEmpty(): '+javascriptPermissionsJson.isEmpty()
			//if no permissions Json exists for that user create a basic json file for them.

			def convertedClob
			if(javascriptPermissionsJson.isEmpty()){
				baseJsonMakerService.serviceMethod(params.personSelected)
				convertedClob = '{"targetObjects": {}}'
			}else{
				convertedClob = javascriptPermissionsJson[0]["items"].getCharacterStream().getText()
			}



	//		println "convertedClob"+convertedClob
	//		println 'javascriptPermissionsJson:'+javascriptPermissionsJson

		//	def gormJson = GrailsJson.withCriteria(){
		//		ilike('pidm','32460')
		//	}
		//	println "gormJson.items"+gormJson.items
			def jsonSlurper = new JsonSlurper()
			def groovyPermissionsJson = jsonSlurper.parseText(convertedClob)
//			println 'groovyPermissionsJson'+groovyPermissionsJson
//			println 'groovyPermissionsJson.getClass()'+groovyPermissionsJson.getClass()

	//		def jsonSlurper = new JsonSlurper()
	//		def groovyPermissionsJson = jsonSlurper.parseText(javascriptPermissionsJson[0]["items"].toString())
	//		println 'groovyPermissionsJson'+groovyPermissionsJson
			//users current permissions for those actions.
			///REBUILD USING THE SQL JSON TABLE/COLUMN
		//	def userPermissions = TbPermission.withCriteria(){
		//		'ilike'('application',params.application)
		//	}

			//def groupedUserPermissions = userPermissions.groupBy({ action -> action.applicationPage})
			//println "groupedUserPermissions"+groupedUserPermissions

			//users current targetObjects for this application/actions
		//	def userTargetObjects = TbTargetObjects.withCriteria(){
		//		'ilike'('application',params.application)
		//	}

			def sql1 = new Sql(dataSource)
			def departmentList = sql1.rows("""select * from stvdept where length(stvdept_code) = 4 and stvdept_code <> '0000'""")

			def sql2 = new Sql(dataSource)
			def divisionList = sql2.rows("""select * from stvdivs where length(stvdivs_code) = 4""")

 		  def peopleList = sql1.rows("""SELECT * from CC_MSU_STAFF order by last_name, pref_first_name, first_name""")

		[applicationsActions:applicationsActions,departmentList:departmentList,divisionList:divisionList,peopleList:peopleList, javascriptPermissionsJson:convertedClob,groovyPermissionsJson:groovyPermissionsJson,applicationSelected:applicationSelected.applicationName]
		}

def RoleBaseJsonMakerService
		@Secured(["ROLE_ADMIN","ROLE_TB_USER"])
	    def fetchRoleActions() {

				//actions
				def applicationsActions = TbGrailsApplicationsActions.withCriteria(){
					'ilike'('grailsApplicationsId',params.application)
				}
				def applicationSelected = TbGrailsApplications.get(params.application)
//				println "applicationSelected.applicationName"+applicationSelected.applicationName

//				println "params.roleSelected"+params.roleSelected
				def sql0 = new Sql(dataSource)
						def javascriptPermissionsJson = sql0.rows("""select items "items" from grizdata.grails_json where grails_json.role_id = :roleSelected""",[roleSelected:params.roleSelected])
	//--32460
//				println 'javascriptPermissionsJson: '+javascriptPermissionsJson
//				println 'javascriptPermissionsJson.getClass(): '+javascriptPermissionsJson.getClass()
//				println 'javascriptPermissionsJson.isEmpty(): '+javascriptPermissionsJson.isEmpty()
				//if no permissions Json exists for that user create a basic json file for them.

				def convertedClob
				if(javascriptPermissionsJson.isEmpty()){
					roleBaseJsonMakerService.serviceMethod(params.roleSelected)
					convertedClob = '{"targetObjects": {}}'
				}else{
					convertedClob = javascriptPermissionsJson[0]["items"].getCharacterStream().getText()
				}

				def jsonSlurper = new JsonSlurper()
				def groovyPermissionsJson = jsonSlurper.parseText(convertedClob)


				def sql1 = new Sql(dataSource)
				def departmentList = sql1.rows("""select * from stvdept where length(stvdept_code) = 4 and stvdept_code <> '0000'""")

				def sql2 = new Sql(dataSource)
				def divisionList = sql2.rows("""select * from stvdivs where length(stvdivs_code) = 4""")

	 		  def peopleList = sql1.rows("""SELECT * from CC_MSU_STAFF order by last_name, pref_first_name, first_name""")

			[applicationsActions:applicationsActions,departmentList:departmentList,divisionList:divisionList,peopleList:peopleList, javascriptPermissionsJson:convertedClob,groovyPermissionsJson:groovyPermissionsJson,applicationSelected:applicationSelected.applicationName]
			}

def JsonArrayService
@Secured(["ROLE_ADMIN", "ROLE_TB_USER"])
	def updateJsonArray() {
//		println 'before'

//		println "params.finalJsonUpdateString"+params.finalJsonUpdateString
//		println "params.personSelected"+params.personSelected

		jsonArrayService.serviceMethod(params.finalJsonUpdateString,params.personSelected)
//		println 'after'
	render 'bonk'
	}

	def RoleJsonArrayService
	@Secured(["ROLE_ADMIN", "ROLE_TB_USER"])
		def updateRoleJsonArray() {
//			println 'before'

//			println "params.finalJsonUpdateString"+params.finalJsonUpdateString
//			println "params.roleSelected"+params.roleSelected

			roleJsonArrayService.serviceMethod(params.finalJsonUpdateString,params.roleSelected)
//			println 'after'
		render 'bonk'
		}


	//Not used in PROD, was used for development, keeping as examples
			@Secured(["ROLE_ADMIN"])
	      def jsonTest() {

					def sql1 = new Sql(dataSource)
				//	def jsonTest1 = sql1.rows("""select to_char(items) "items" from grizdata.grails_json where json_value(items,'\$.records[*].a_number') = 42""")
				//finding by name
				def jsonTest1 = sql1.rows("""select to_char(items) "items" from grizdata.grails_json where json_value(items,'\$.person.fname') = 'Biff'""")

			//finding by application
		//	def jsonTest1 = sql1.rows("""select to_char(items) "items" from grizdata.grails_json where json_value(items,'\$.permissions[0][*].actionName') = 'organizations'""")
//					println "jsonTest1"+jsonTest1[0]["items"]

					//slurper to make covert the sql string into a groovy json object.
					def jsonSlurper = new JsonSlurper()
					//      def obj = jsonSlurper.parseText ''' {"Integer": 12, "fraction": 12.55, "double": 12e13}'''

					def groovyJson = jsonSlurper.parseText(jsonTest1[0]["items"].toString())
//					println "groovyJson"+groovyJson
//					println "groovyJson.person"+groovyJson.person
					//def test1 = GrailsJson.getAll()
				///	println "test1"+test1
			//		def items =  new JsonBuilder("jsonTest1"+jsonTest1[0])
			//	def items =  new JsonBuilder(jsonTest1[0]).toPrettyString()
			//	println "items"+items
	      [items:jsonTest1[0]["items"].toString(), items2:groovyJson]
	      }
/*
keeping as example code
				@Secured(["ROLE_ADMIN"])
		      def jsonTest1() {

						def gormJson = GrailsJson.withCriteria(){
							ilike('pidm','32460')
						}
//						println "gormJson.items"+gormJson.items
						def jsonSlurper = new JsonSlurper()
						def groovyPermissionsJson = jsonSlurper.parseText(gormJson.items)
//						println 'groovyPermissionsJson'+groovyPermissionsJson

		//				def sql0 = new Sql(dataSource)
					//	def grailsPermissionsJson = ""
		//				def javascriptPermissionsJson = sql0.rows("""select to_char(items) "items" from grizdata.grails_json where grails_json.pidm = :personSelected""",[personSelected:'32460'])
			//--32460
		//				println 'javascriptPermissionsJson:'+javascriptPermissionsJson

		//				def jsonSlurper = new JsonSlurper()
		//				def groovyPermissionsJson = jsonSlurper.parseText(javascriptPermissionsJson[0]["items"].toString())
			//			println 'groovyPermissionsJson'+groovyPermissionsJson

		//				println "groovyPermissionsJson: "+groovyPermissionsJson['targetObjects']['Team Builder']['organizations']['departments']['DNUR']
		//				println "groovyPermissionsJson: "+groovyPermissionsJson['targetObjects']['Team Builder']['organizations']['departments']

				//	[javascriptPermissionsJson:javascriptPermissionsJson[0]["items"].toString(), groovyPermissionsJson:groovyPermissionsJson]
				[groovyPermissionsJson:groovyPermissionsJson]
				}
*/

/*
I decided to to include these features. management of roles and permissions should be don't manuel by a person. When transitions between employees happen or when a users roles need to be flatten and combined to create a 'role' do it manuelly.

	 @Secured(["ROLE_ADMIN"])
		def transformPermissions() {
			def rolesList = TbRoles.getAll()
			def sql = new Sql(dataSource)
			def peopleList = sql.rows("""SELECT * from CC_MSU_STAFF order by last_name, pref_first_name, first_name""")
			[rolesList:rolesList, peopleList:peopleList]
		}

def CombineAndApplyService
		@Secured(["ROLE_ADMIN"])
			def combineAndApply() {
		//		println 'sourceRolesHolder: '+params.sourceRolesHolder
		//		println 'sourcePeopleHolder: '+params.sourcePeopleHolder
		//		println 'targetRolesHolder: '+params.targetRolesHolder
		//		println 'targetPeopleHolder: '+params.targetPeopleHolder

			//unused feature.
				def a = CombineAndApplyService.serviceMethod(sourceRolesHolder,sourcePeopleHolder,targetRolesHolder,targetPeopleHolder)

				render 'Bonk'
			}
*/

}

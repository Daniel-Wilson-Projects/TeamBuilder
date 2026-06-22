package Teambuilder

class TbGrailsApplicationsActions{

  String grailsApplicationsId, actionName, actionDescription

  Date activityDate, removedDate
  static mapping =
  {
  table 'TB_GRAILS_APPLICATIONS_ACTIONS'
  id generator:'sequence', params:[sequence: 'TB_GRAILS_APPLICATIONS_ACTIONS_SEQ'], column : 'ID'
  grailsApplicationsId column: "GRAILS_APPLICATIONS_ID"
  actionName column: "ACTION_NAME"
  actionDescription column: "ACTION_DESCRIPTION"
  activityDate column: "ACTIVITY_DATE"
  removedDate column: "REMOVED_DATE"
	version false
}

static constraints = {
  removedDate nullable:true
}


}

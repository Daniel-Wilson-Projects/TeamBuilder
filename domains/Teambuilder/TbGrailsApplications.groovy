package Teambuilder

class TbGrailsApplications{

  String applicationName, applicationDescription
  Date activityDate, removedDate

  static mapping =
  {
  table 'TB_GRAILS_APPLICATIONS'
  id generator:'sequence', params:[sequence: 'TB_GRAILS_APPLICATIONS_SEQ'], column : 'ID'
  applicationName column: "APPLICATION_NAME"
  applicationDescription column: "APPLICATION_DESCRIPTION"
  activityDate column: "ACTIVITY_DATE"
  removedDate column: "REMOVED_DATE"
	version false
}

static constraints = {
  removedDate nullable:true
}


}

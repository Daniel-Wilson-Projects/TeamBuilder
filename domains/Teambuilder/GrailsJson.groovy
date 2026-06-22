package Teambuilder

class GrailsJson{

  String items,pidm, roleId
  Date activityDate

  static mapping =
  {
  table 'GRAILS_JSON'
  id generator:'sequence', params:[sequence: 'GRAILS_JSON_SEQ'], column : 'ID'
  pidm column: "pidm"
  items column: "ITEMS", type:'text'
  activityDate column: "ACTIVITY_DATE"
  roleId column:"ROLE_ID"
	version false
}

static constraints = {
pidm nullable:true
roleId nullable:true
}


}

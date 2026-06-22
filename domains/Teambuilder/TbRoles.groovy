package Teambuilder

class TbRoles{

  String organization, roleName, roleDescription, creatorPidm, surId
  Date activityDate, createdDate, removedDate

  static mapping =
  {
  table 'TB_ROLES'
  id generator:'sequence', params:[sequence: 'TB_ROLES_SEQ'], column : 'ID'
  surId column: "ID", insertable: false, updateable: false

  organization column:"ORGANIZATION"
  roleName column: "ROLE_NAME"
  roleDescription column: "ROLE_DESCRIPTION"

  activityDate column: "ACTIVITY_DATE"
  creatorPidm column:"CREATOR_PIDM"

  createdDate column: "CREATED_DATE"
  removedDate column: "REMOVED_DATE"
	version false
}

static constraints = {
  createdDate nullable:true
  removedDate nullable:true
  surId nullable:true
}


}

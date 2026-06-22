package Teambuilder

class TbOrganization{

  String organization, description, creatorPidm, surId
  Date activityDate, createdDate, removedDate
  static mapping =
  {
  table 'TB_ORGANIZATION'
  id generator:'sequence', params:[sequence: 'TB_ORGANIZATION_SEQ'], column : 'ID'
  surId column: "ID", insertable: false, updateable: false
  organization column: "ORGANIZATION"
  description column: "DESCRIPTION"
  activityDate column: "ACTIVITY_DATE"
  creatorPidm column: "CREATOR_PIDM"
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

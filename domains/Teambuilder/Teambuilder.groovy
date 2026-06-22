package Teambuilder

class Teambuilder{


  String grantee, granteeTitle, grantor, grantorTitle, organization, organizationDesc, application, grantedObject, grantable, privilege, owner
  Date activityDate

  static mapping =
  {
  table 'TEAMBUILDER'
  id generator:'sequence', params:[sequence: 'TEAMBUILDER_SEQ'], column : 'ID'

  grantee column: "GRANTEE"
  granteeTitle column: "GRANTEE_TITLE"
  grantor column: "GRANTOR"
  grantorTitle column: "GRANTOR_TITLE"
  organization column: "ORGANIZATION"
  organizationDesc column: "ORGANIZATION_DESC"
  application column: "APPLICATION"
  grantedObject column: "GRANTED_OBJECT"
  grantable column: "GRANTABLE"
  privilege column: "PRIVILEGE"
  owner column: "OWNER"
  activityDate column: "ACTIVITY_DATE"
	version false
}

static constraints = {

}


}

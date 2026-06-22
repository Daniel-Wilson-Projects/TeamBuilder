package Teambuilder

class TbPermission{

  String grantee, application, applicationPage, privilege

  static mapping =
  {
  table 'TB_PERMISSION'
  id generator:'sequence', params:[sequence: 'TB_PERMISSION_SEQ'], column : 'ID'

  grantee column:"GRANTEE"
  application column: "APPLICATION"
  applicationPage column: "APPLICATION_PAGE"
  privilege column: "PRIVILEGE"

	version false
}

static constraints = {

}


}

package Teambuilder

class TbTargetObjects{

  String grantee, application, applicationPage, targetObject, objectType
  
  static mapping =
  {
  table 'TB_TARGET_OBJECTS'
  id generator:'sequence', params:[sequence: 'TB_TARGET_OBJECTS_SEQ'], column : 'ID'

  grantee column: "GRANTEE"
  application column: "APPLICATION"
  applicationPage column: "APPLICATION_PAGE"
  targetObject column:"TARGET_OBJECT"
  objectType column:"OBJECT_TYPE"

	version false
}

static constraints = {

}


}

package Teambuilder

class TbAssignedRoles{

  String pidm, tbRolesId, surId
  Date assignedDate, removedDate


  static mapping =
  {
  table 'TB_ASSIGNED_ROLES'
  id generator:'sequence', params:[sequence: 'TB_ROLES_SEQ'], column : 'ID'
  surId column: "ID", insertable: false, updateable: false

  pidm column:"PIDM"
  tbRolesId column: "TB_ROLES_ID"
  assignedDate column: "ASSIGNED_DATE"
  removedDate column: "REMOVED_DATE"

	version false
}

static constraints = {
    assignedDate nullable:true
    removedDate nullable:true
    surId nullable:true
}


}

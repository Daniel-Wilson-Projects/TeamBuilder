package Teambuilder

class TbHierarchy{

  String parentNodeId, pidm, organization, surId, creatorPidm
  Date assignedDate, removedDate
  static mapping =
  {
  table 'TB_HIERARCHY'
  id generator:'sequence', params:[sequence: 'TB_HIERARCHY_SEQ'], column : 'ID'

  parentNodeId column: "PARENT_NODE_ID"
  pidm column: "PIDM"
  organization column: "ORGANIZATION"
  surId column: "ID", insertable: false, updateable: false
  assignedDate column: "ASSIGNED_DATE"
  removedDate column: "REMOVED_DATE"
  creatorPidm column: "CREATOR_PIDM"


	version false
}

static constraints = {
parentNodeId nullable:true
pidm nullable:true
assignedDate nullable:true
removedDate nullable:true
surId nullable:true
}


}

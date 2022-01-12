// To parse this JSON data, do
//
//     final datum = datumFromMap(jsonString);

import 'dart:convert';

Datum datumFromMap(String str) => Datum.fromMap(json.decode(str));

String datumToMap(Datum data) => json.encode(data.toMap());

class Datum {
  Datum({
    this.id,
    this.jobType,
    this.taskTitle,
    this.natureOfTask,
    this.brief,
    this.deliverables,
    this.attachment,
    this.districtId,
    this.departmentId,
    this.statusId,
    this.createdBy,
    this.assignedTo,
    this.from,
    this.to,
    this.fromTime,
    this.toTime,
    this.createdAt,
    this.updatedAt,
    this.createdByUser,
    this.createdByUserId,
    this.do_ID,
    this.assignedToUser,
    this.department,
    this.status,
    this.district,
  });

  int id;
  int jobType;
  String taskTitle;
  String natureOfTask;
  String brief;
  String deliverables;
  List<String> attachment;
  int districtId;
  dynamic departmentId;
  int statusId;
  int createdBy;
  int assignedTo;
  DateTime from;
  DateTime to;
  String fromTime;
  String toTime;
  String createdAt;
  DateTime updatedAt;
  User createdByUser;
  User createdByUserId;
  String do_ID;
  User assignedToUser;
  dynamic department;
  Status status;
  District district;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    jobType: json["job_type"],
    taskTitle: json["task_title"],
    natureOfTask: json["nature_of_task"],
    brief: json["brief"],
    deliverables: json["deliverables"],
    attachment: List<String>.from(json["attachment"].map((x) => x)),
    districtId: json["district_id"],
    departmentId: json["department_id"],
    statusId: json["status_id"],
    createdBy: json["created_by"],
    assignedTo: json["assigned_to"],
    from: DateTime.parse(json["_from"]),
    to: DateTime.parse(json["_to"]),
    fromTime: json["from_time"],
    toTime: json["to_time"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdByUser: User.fromMap(json["created_by_user"]),
    createdByUserId: User.fromMap(json["created_by_user"]),
    do_ID: json["DO_id"],
    assignedToUser: User.fromMap(json["assigned_to_user"]),
    department: json["department"],
    status: Status.fromMap(json["status"]),
    district: District.fromMap(json["district"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "job_type": jobType,
    "task_title": taskTitle,
    "nature_of_task": natureOfTask,
    "brief": brief,
    "deliverables": deliverables,
    "attachment": List<dynamic>.from(attachment.map((x) => x)),
    "district_id": districtId,
    "department_id": departmentId,
    "status_id": statusId,
    "created_by": createdBy,
    "assigned_to": assignedTo,
    "_from": from.toIso8601String(),
    "_to": to.toIso8601String(),
    "from_time": fromTime,
    "to_time": toTime,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
    "created_by_user": createdByUser.toMap(),
    "created_by_user_id": createdByUser.id,
    "DO_id": do_ID,
    "assigned_to_user": assignedToUser.toMap(),
    "department": department,
    "status": status.toMap(),
    "district": district.toMap(),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
  });

  int id;
  String name;
  String email;

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
  };
}

class District {
  District({
    this.id,
    this.district,
  });

  int id;
  String district;

  factory District.fromMap(Map<String, dynamic> json) => District(
    id: json["id"],
    district: json["district"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "district": district,
  };
}

class Status {
  Status({
    this.id,
    this.status,
    this.keyword,
  });

  int id;
  String status;
  String keyword;

  factory Status.fromMap(Map<String, dynamic> json) => Status(
    id: json["id"],
    status: json["status"],
    keyword: json["keyword"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "status": status,
    "keyword": keyword,
  };
}

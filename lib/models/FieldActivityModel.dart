// To parse this JSON data, do
//
//     final fieldActivityModel = fieldActivityModelFromMap(jsonString);

import 'dart:convert';

FieldActivityModel fieldActivityModelFromMap(String str) => FieldActivityModel.fromMap(json.decode(str));

String fieldActivityModelToMap(FieldActivityModel data) => json.encode(data.toMap());

class FieldActivityModel {
  FieldActivityModel({
    this.date,
    this.activityName,
    this.district,
    this.uc,
    this.taluka,
    this.village,
    this.doName,
    this.doID,
    this.countParticipants,
    this.male,
    this.female,
    this.details,
    this.images,
    this.attendanceSheet,
    this.mapLat,
    this.mapLong,
    this.mapLocation,
  });

  String date;
  String activityName;
  String district;
  String uc;
  String taluka;
  String village;
  String doName;
  String doID;
  int countParticipants;
  int male;
  int female;
  String details;
  List<AttachmentsList> images;
  List<AttendanceSheets> attendanceSheet;
  String mapLat;
  String mapLong;
  String mapLocation;

  factory FieldActivityModel.fromMap(Map<String, dynamic> json) => FieldActivityModel(
    date: json["date"],
    activityName: json["activity_name"],
    district: json["district"],
    uc: json["uc"],
    taluka: json["taluka"],
    village: json["village"],
    doName: json["DO_name"],
    doID: json["DO_id"],
    countParticipants: json["count_participants"],
    male: json["male"],
    female: json["female"],
    details: json["details"],
    images: List<AttachmentsList>.from(json["images"].map((x) => AttachmentsList.fromMap(x))),
    attendanceSheet: List<AttendanceSheets>.from(json["attendance_sheet"].map((x) => AttendanceSheets.fromMap(x))),
    mapLat: json["map_lat"],
    mapLong: json["map_long"],
    mapLocation: json["map_location"],
  );

  Map<String, dynamic> toMap() => {
    "date": date,
    "activity_name": activityName,
    "district": district,
    "uc": uc,
    "taluka": taluka,
    "village": village,
    "DO_name": doName,
    "DO_id": doID,
    "count_participants": countParticipants,
    "male": male,
    "female": female,
    "details": details,
    "images": List<dynamic>.from(images.map((x) => x.toMap())),
    "attendance_sheet": List<dynamic>.from(attendanceSheet.map((x) => x.toMap())),
    "map_lat": mapLat,
    "map_long": mapLong,
    "map_location": mapLocation,
  };
}

class AttendanceSheets {
  AttendanceSheets({
    this.image,
    this.extension,
  });

  String image;
  String extension;

  factory AttendanceSheets.fromMap(Map<String, dynamic> json) => AttendanceSheets(
    image: json["image"],
    extension: json["extension"],
  );

  Map<String, dynamic> toMap() => {
    "image": image,
    "extension": extension,
  };
}

class AttachmentsList {
  AttachmentsList({
    this.image,
    this.extension,
  });

  String image;
  String extension;

  factory AttachmentsList.fromMap(Map<String, dynamic> json) => AttachmentsList(
    image: json["image"],
    extension: json["extension"],
  );

  Map<String, dynamic> toMap() => {
    "image": image,
    "extension": extension,
  };
}

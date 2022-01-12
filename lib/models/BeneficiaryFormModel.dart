// To parse this JSON data, do
//
//     final beneficiaryFormModel = beneficiaryFormModelFromMap(jsonString);

import 'dart:convert';

import 'package:ssepnew/models/BtlActivity_model.dart';

BeneficiaryFormModel beneficiaryFormModelFromMap(String str) => BeneficiaryFormModel.fromMap(json.decode(str));

String beneficiaryFormModelToMap(BeneficiaryFormModel data) => json.encode(data.toMap());

class BeneficiaryFormModel {
  BeneficiaryFormModel({
    this.name,
    this.fatherName,
    this.cnic,
    this.mobileNo,
    this.district,
    this.taluka,
    this.village,
    this.activityEvent,
    this.supplierName,
    // this.attachment,
    // this.mapLat,
    // this.mapLong,
    this.mapLocation,
  });

  String name;
  String fatherName;
  String cnic;
  String mobileNo;
  String district;
  String taluka;
  String village;
  String activityEvent;
  String supplierName;
  // List<AttachmentsClass> attachment;
  // String mapLat;
  // String mapLong;
  String mapLocation;

  factory BeneficiaryFormModel.fromMap(Map<String, dynamic> json) => BeneficiaryFormModel(
    name: json["name"],
    fatherName: json["father_name"],
    cnic: json["cnic"],
    mobileNo: json["mobile_no"],
    district: json["district"],
    taluka: json["taluka"],
    village: json["village"],
    activityEvent: json["activity_event"],
    supplierName: json["supplier_name"],
    // attachment: List<AttachmentsClass>.from(json["attachment"].map((x) => AttachmentsClass.fromMap(x))),
    // mapLat: json["map_lat"],
    // mapLong: json["map_long"],
    mapLocation: json["map_location"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "father_name": fatherName,
    "cnic": cnic,
    "mobile_no": mobileNo,
    "district": district,
    "taluka": taluka,
    "village": village,
    "activity_event": activityEvent,
    "supplier_name": supplierName,
    // "attachment": List<dynamic>.from(attachment.map((x) => x.toMap())),
    // "map_lat": mapLat,
    // "map_long": mapLong,
    "map_location": mapLocation,
  };
}
class Attachment {
  Attachment({
    this.image,
    this.extension,
  });

  String image;
  String extension;

  factory Attachment.fromMap(Map<String, dynamic> json) => Attachment(
    image: json["image"],
    extension: json["extension"],
  );

  Map<String, dynamic> toMap() => {
    "image": image,
    "extension": extension,
  };
}

//{
//"attachment": [
//{
//"image": "21",
//"extension": "Male"
//},
//{
//"image": "21",
//"extension": "Male"
//}
//]
//}
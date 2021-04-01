// To parse this JSON data, do
//
//     final btlActivityModel = btlActivityModelFromMap(jsonString);

import 'dart:convert';

BtlActivityModel btlActivityModelFromMap(String str) => BtlActivityModel.fromMap(json.decode(str));

String btlActivityModelToMap(BtlActivityModel data) => json.encode(data.toMap());

class BtlActivityModel {
  BtlActivityModel({
    this.id,
    this.userId,
    this.formNo,
    this.date,
    this.name,
    this.fatherName,
    this.cnic,
    this.mobileNo,
    this.district,
    this.uc,
    this.taluka,
    this.village,
    this.nLandmark,
    this.address,
    this.maleCount,
    this.femaleCount,
    this.childrenCount,
    this.sourceOfInfo,
    this.electricity,
    this.loadsheddingHours,
    this.mocrofinanceload,
    this.mfi,
    this.attachment,
    this.mapLat,
    this.mapLong,
    this.mapLocation,
  });

  int id;
  int userId;
  String formNo;
  String date;
  String name;
  String fatherName;
  String cnic;
  String mobileNo;
  String district;
  String uc;
  String taluka;
  String village;
  String nLandmark;
  String address;
  int maleCount;
  int femaleCount;
  int childrenCount;
  String sourceOfInfo;
  String electricity;
  String loadsheddingHours;
  String mocrofinanceload;
  String mfi;
  String attachment;
  String mapLat;
  String mapLong;
  String mapLocation;

  factory BtlActivityModel.fromMap(Map<String, dynamic> json) => BtlActivityModel(
    id: json["id"],
    userId: json["user_id"],
    formNo: json["form_no"],
    date: json["date"],
    name: json["name"],
    fatherName: json["father_name"],
    cnic: json["cnic"],
    mobileNo: json["mobile_no"],
    district: json["district"],
    uc: json["uc"],
    taluka: json["taluka"],
    village: json["village"],
    nLandmark: json["n_landmark"],
    address: json["address"],
    maleCount: json["male_count"],
    femaleCount: json["female_count"],
    childrenCount: json["children_count"],
    sourceOfInfo: json["source_of_info"],
    electricity: json["electricity"],
    loadsheddingHours: json["loadshedding_hours"],
    mocrofinanceload: json["mocrofinanceload"],
    mfi: json["mfi"],
    attachment: json["attachment"],
    mapLat: json["map_lat"],
    mapLong: json["map_long"],
    mapLocation: json["map_location"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "form_no": formNo,
    "date": date,
    "name": name,
    "father_name": fatherName,
    "cnic": cnic,
    "mobile_no": mobileNo,
    "district": district,
    "uc": uc,
    "taluka": taluka,
    "village": village,
    "n_landmark": nLandmark,
    "address": address,
    "male_count": maleCount,
    "female_count": femaleCount,
    "children_count": childrenCount,
    "source_of_info": sourceOfInfo,
    "electricity": electricity,
    "loadshedding_hours": loadsheddingHours,
    "mocrofinanceload": mocrofinanceload,
    "mfi": mfi,
    "attachment": attachment,
    "map_lat": mapLat,
    "map_long": mapLong,
    "map_location": mapLocation,
  };
}

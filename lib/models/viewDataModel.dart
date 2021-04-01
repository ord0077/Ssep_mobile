// To parse this JSON data, do
//
//     final surveyRecordModel = surveyRecordModelFromMap(jsonString);

import 'dart:convert';

SurveyRecordModel surveyRecordModelFromMap(String str) => SurveyRecordModel.fromMap(json.decode(str));

String surveyRecordModelToMap(SurveyRecordModel data) => json.encode(data.toMap());

class SurveyRecordModel {
  SurveyRecordModel({
    this.id,
    this.name,
    this.address,
    this.pn,
    this.or,
    this.lot,
    this.rooms,
    this.fms,
    this.nprw,
    this.distance,
    this.occupation,
    this.gi,
    this.expenditures,
    this.farmSize,
    this.amount,
    this.priceKwh,
    this.peakHours,
    this.reliability,
    this.fan,
    this.fanHours,
    this.ac,
    this.acHours,
    this.computers,
    this.computerHours,
    this.refrigerator,
    this.refrigeratorHours,
    this.savers,
    this.saverHours,
    this.machine,
    this.machineHours,
    this.tv,
    this.tvHours,
    this.other,
    this.otherHours,
    this.feedback,
    this.districtId,
    this.attachment,
    this.jobId,
    this.userId,
    this.map_lat,
    this.map_long,
    this.map_location,
  });

  int id;
  String name;
  String address;
  String pn;
  String or;
  String lot;
  String rooms;
  List<Fm> fms;
  String nprw;
  String distance;
  String occupation;
  String gi;
  String expenditures;
  String farmSize;
  String amount;
  String priceKwh;
  String peakHours;
  String reliability;
  String fan;
  String fanHours;
  String ac;
  String acHours;
  String computers;
  String computerHours;
  String refrigerator;
  String refrigeratorHours;
  String savers;
  String saverHours;
  String machine;
  String machineHours;
  String tv;
  String tvHours;
  String other;
  String otherHours;
  String feedback;
  int districtId;
  String attachment;
  int jobId;
  int userId;
  String map_lat;
  String map_long;
  String map_location;


  factory SurveyRecordModel.fromMap(Map<String, dynamic> json) => SurveyRecordModel(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    pn: json["pn"],
    or: json["or"],
    lot: json["lot"],
    rooms: json["rooms"],
    fms: List<Fm>.from(json["fms"].map((x) => Fm.fromMap(x))),
    nprw: json["nprw"],
    distance: json["distance"],
    occupation: json["occupation"],
    gi: json["gi"],
    expenditures: json["expenditures"],
    farmSize: json["farm_size"],
    amount: json["amount"],
    priceKwh: json["price_kwh"],
    peakHours: json["peak_hours"],
    reliability: json["reliability"],
    fan: json["fan"],
    fanHours: json["fan_hours"],
    ac: json["ac"],
    acHours: json["ac_hours"],
    computers: json["computers"],
    computerHours: json["computer_hours"],
    refrigerator: json["refrigerator"],
    refrigeratorHours: json["refrigerator_hours"],
    savers: json["savers"],
    saverHours: json["saver_hours"],
    machine: json["machine"],
    machineHours: json["machine_hours"],
    tv: json["tv"],
    tvHours: json["tv_hours"],
    other: json["other"],
    otherHours: json["other_hours"],
    feedback: json["feedback"],
    districtId: json["district_id"],
    attachment: json["attachment"],
    jobId: json["job_id"],
    userId: json["user_id"],
    map_lat: json["map_lat"] == null ? null :json["map_lat"],
    map_long: json["map_long"] == null ? null :json["map_long"],
    map_location: json["map_location"] == null ? null :json["map_location"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "address": address,
    "pn": pn,
    "or": or,
    "lot": lot,
    "rooms": rooms,
    "fms": List<dynamic>.from(fms.map((x) => x.toMap())),
    "nprw": nprw,
    "distance": distance,
    "occupation": occupation,
    "gi": gi,
    "expenditures": expenditures,
    "farm_size": farmSize,
    "amount": amount,
    "price_kwh": priceKwh,
    "peak_hours": peakHours,
    "reliability": reliability,
    "fan": fan,
    "fan_hours": fanHours,
    "ac": ac,
    "ac_hours": acHours,
    "computers": computers,
    "computer_hours": computerHours,
    "refrigerator": refrigerator,
    "refrigerator_hours": refrigeratorHours,
    "savers": savers,
    "saver_hours": saverHours,
    "machine": machine,
    "machine_hours": machineHours,
    "tv": tv,
    "tv_hours": tvHours,
    "other": other,
    "other_hours": otherHours,
    "feedback": feedback,
    "district_id": districtId,
    "attachment": attachment,
    "job_id": jobId,
    "user_id": userId,
    "map_lat": map_lat == null ? null :map_lat,
    "map_long": map_long == null ? null :map_long,
    "map_location": map_location == null ? null :map_location,
  };
}

class Fm {
  Fm({
    this.gender,
    this.age,
  });

  String gender;
  String age;

  factory Fm.fromMap(Map<String, dynamic> json) => Fm(
    gender: json["gender"],
    age: json["age"],
  );

  Map<String, dynamic> toMap() => {
    "gender": gender,
    "age": age,
  };
}

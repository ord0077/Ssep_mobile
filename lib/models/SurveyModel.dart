// To parse this JSON data, do
//
//     final survey = surveyFromMap(jsonString);

import 'dart:convert';
import 'dart:io' as i;

Survey surveyFromMap(String str) => Survey.fromMap(json.decode(str));

String surveyToMap(Survey data) => json.encode(data.toMap());

class Survey {
  Survey({
    this.userId,
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
    this.job_id,
    this.district_id,
    this.attachment,
    this.map_lat,
    this.map_long,
    this.map_location,
  });

  String userId;
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
  String job_id;
  String district_id;
  String attachment;
  String map_lat;
  String map_long;
  String map_location;

  factory Survey.fromMap(Map<String, dynamic> json) => Survey(
    userId: json["user_id"] == null ? null :json["user_id"],
    name: json["name"] == null ? null :json["name"],
    address: json["address"] == null ? null :json["address"],
    pn: json["pn"] == null ? null :json["pn"],
    or: json["or"] == null ? null :json["or"],
    lot: json["lot"] == null ? null :json["lot"],
    rooms: json["rooms"] == null ? null :json["rooms"],
    fms: json["fms"]== null ? null :List<Fm>.from(json["fms"].map((x) => Fm.fromMap(x))),
    nprw: json["nprw"] == null ? null :json["nprw"],
    distance: json["distance"] == null ? null : json["distance"],
    occupation: json["occupation"]== null ? null :json["occupation"],
    gi: json["gi"]== null ? null :json["gi"],
    expenditures: json["expenditures"]== null ? null : json["expenditures"],
    farmSize: json["farm_size"]== null ? null : json["farm_size"],
    amount: json["amount"]== null ? null :json["amount"],
    priceKwh: json["price_kwh"]== null ? null :json["price_kwh"],
    peakHours: json["peak_hours"] == null ? null :json["peak_hours"],
    reliability: json["reliability"]== null ? null :json["reliability"],
    fan: json["fan"]== null ? null : json["fan"],
    fanHours: json["fan_hours"]== null ? null :json["fan_hours"],
    ac: json["ac"]== null ? null :json["ac"],
    acHours: json["ac_hours"]== null ? null :json["ac_hours"],
    computers: json["computers"]== null ? null :json["computers"],
    computerHours: json["computer_hours"]== null ? null :json["computer_hours"],
    refrigerator: json["refrigerator"]== null ? null :json["refrigerator"],
    refrigeratorHours: json["refrigerator_hours"]== null ? null :json["refrigerator_hours"],
    savers: json["savers"]== null ? null : json["savers"],
    saverHours: json["saver_hours"]== null ? null :json["saver_hours"],
    machine: json["machine"]== null ? null : json["machine"],
    machineHours: json["machine_hours"]== null ? null :json["machine_hours"],
    tv: json["tv"]== null ? null :json["tv"],
    tvHours: json["tv_hours"]== null ? null : json["tv_hours"],
    other: json["other"]== null ? null :json["other"],
    otherHours: json["other_hours"] == null ? null :json["other_hours"],
    feedback: json["feedback"]== null ? null : json["feedback"],
    job_id: json["job_id"] == null ? null :json["job_id"],
    district_id: json["district_id"] == null ? null :json["district_id"],
    attachment: json["attachment"].toString() == null ? null :json["attachment"],
      map_lat: json["map_lat"] == null ? null :json["map_lat"],
      map_long: json["map_long"] == null ? null :json["map_long"],
      map_location: json["map_location"] == null ? null :json["map_location"],



  );

  Map<String, dynamic> toMap() => {
    "user_id": userId== null ? null :userId,
    "name": name== null ? null :name,
    "address": address== null ? null :address,
    "pn": pn == null ? null :pn,
    "or": or == null ? null :or,
    "lot": lot == null ? null :lot,
    "rooms": rooms == null ? null :rooms,
    "fms": fms == null ? null :List<dynamic>.from(fms.map((x) => x.toMap())),
    "nprw": nprw == null ? null :nprw,
    "distance": distance == null ? null :distance,
    "occupation": occupation == null ? null :occupation,
    "gi": gi == null ? null :gi,
    "expenditures": expenditures == null ? null :expenditures,
    "farm_size": farmSize == null ? null :farmSize,
    "amount": amount == null ? null :amount,
    "price_kwh": priceKwh == null ? null :priceKwh,
    "peak_hours": peakHours == null ? null :peakHours,
    "reliability": reliability == null ? null :reliability,
    "fan": fan == null ? null :fan,
    "fan_hours": fanHours == null ? null :fanHours,
    "ac": ac == null ? null :ac,
    "ac_hours": acHours == null ? null :acHours,
    "computers": computers == null ? null :computers,
    "computer_hours": computerHours == null ? null :computerHours,
    "refrigerator": refrigerator == null ? null :refrigerator,
    "refrigerator_hours": refrigeratorHours == null ? null :refrigeratorHours,
    "savers": savers == null ? null :savers,
    "saver_hours": saverHours == null ? null :saverHours,
    "machine": machine == null ? null :machine,
    "machine_hours": machineHours == null ? null :machineHours,
    "tv": tv == null ? null :tv,
    "tv_hours": tvHours == null ? null :tvHours,
    "other": other == null ? null :other,
    "other_hours": otherHours == null ? null :otherHours,
    "feedback": feedback == null ? null :feedback,
    "job_id": job_id== null ? null :job_id,
    "district_id": district_id== null ? null :district_id,
    "attachment": attachment == null ? null :attachment,
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
    gender: json["gender"]== null ? null : json["gender"],
    age: json["age"]== null ? null :json["age"],
  );

  Map<String, dynamic> toMap() => {
    "gender": gender == null ? null :gender,
    "age": age == null ? null :  age,
  };
}

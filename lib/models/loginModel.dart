// To parse this JSON data, do
 //
 //     final loginModel = loginModelFromJson(jsonString);

 import 'dart:convert';

 LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

 String loginModelToJson(LoginModel data) => json.encode(data.toJson());

 class LoginModel {
   final String token;
   final User user;

   const LoginModel({
     this.token,
     this.user,
   });

   factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
     token: json["token"],
     user: User.fromJson(json["user"]),
   );

   Map<String, dynamic> toJson() => {
     "token": token,
     "user": user.toJson(),
   };
 }

 class User {
    int id;
       int master;
       String name;
       String cnic;
       String mobileNo;
       int roleId;
       int departmentId;
       String email;
       dynamic emailVerifiedAt;
       int districtId;
       bool isActive;
       String createdAt;
       DateTime updatedAt;
       String userType;

   User({
     this.id,
           this.master,
           this.name,
           this.cnic,
           this.mobileNo,
           this.roleId,
           this.departmentId,
           this.email,
           this.emailVerifiedAt,
           this.districtId,
           this.isActive,
           this.createdAt,
           this.updatedAt,
           this.userType,
   });

   factory User.fromJson(Map<String, dynamic> json) => User(
       id: json["id"],
            master: json["master"],
            name: json["name"],
            cnic: json["cnic"],
            mobileNo: json["mobile_no"],
            roleId: json["role_id"],
            departmentId: json["department_id"],
            email: json["email"],
            emailVerifiedAt: json["email_verified_at"],
            districtId: json["district_id"],
            isActive: json["isActive"],
            createdAt: json["created_at"],
            updatedAt: DateTime.parse(json["updated_at"]),
            userType: json["user_type"],
   );

   Map<String, dynamic> toJson() => {
    "id": id,
            "master": master,
            "name": name,
            "cnic": cnic,
            "mobile_no": mobileNo,
            "role_id": roleId,
            "department_id": departmentId,
            "email": email,
            "email_verified_at": emailVerifiedAt,
            "district_id": districtId,
            "isActive": isActive,
            "created_at": createdAt,
            "updated_at": updatedAt.toIso8601String(),
            "user_type": userType,
   };
 }
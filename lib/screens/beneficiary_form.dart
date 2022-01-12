
import 'dart:convert';
//import 'dart:html';
import 'dart:io';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssepnew/CustomAppBar.dart';
import 'package:ssepnew/consts.dart';
import 'package:ssepnew/models/BeneficiaryFormModel.dart';
import 'package:ssepnew/models/BtlActivity_model.dart';
import 'package:ssepnew/models/SurveyModel.dart';
import 'package:ssepnew/screens/btl_records.dart';
import 'package:ssepnew/screens/purchased.dart';
import 'package:ssepnew/themes.dart';
import 'package:flutter/services.dart';




class BeneficiaryForm extends StatefulWidget {

//  final List<Survey> EconomicDetail;

//  const EconomicScreen({Key key, @required this.EconomicDetail}) : super(key: key);


  @override
  _BeneficiaryForm createState() => _BeneficiaryForm();
}

class _BeneficiaryForm extends State<BeneficiaryForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  String userName = '';
  String Value_name;


  String file;
  final picker = ImagePicker();
  // final picker2 = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _AddBeneficiary = BeneficiaryFormModel();
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  List<AttachmentsClass> files = [] ;
  bool  galaryPressed = false;
  bool  CameraPressed = false;
  List<String> attachnames = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController  fatherController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController cellController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController talukaController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController activityController = TextEditingController();
  TextEditingController supplierController = TextEditingController();
  TextEditingController LocationController = TextEditingController();




  @override
  void dispose() {
    nameController.dispose();
    fatherController.dispose();
        cnicController.dispose();
        cellController.dispose();
        districtController.dispose();
        talukaController.dispose();
        villageController.dispose();
        activityController.dispose();
        supplierController.dispose();
        LocationController.dispose();

    super.dispose();
  }

  FetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    setState(() {
      userName = (prefs.getString('user_name') ?? '');
      Value_name =(prefs.getString('task_title') ?? '');
    });
  }



  @override
  void initState() {
    setState(() {
      FetchData();
      // getLocation();
    });
    super.initState();
  }



  bool _validate = false;


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return WillPopScope (
        onWillPop: () {
      return _moveToSignInScreen(context);
    },
    child: SafeArea(
      child: new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(   height: 140,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                  height: 60.0,
                  padding: const EdgeInsets.only(left: 10.0,top: 10.0,right: 10.0,bottom: 8.0,),



                  child: Row(
                      children: [
                        Container(
                          constraints: BoxConstraints(minWidth: 20, maxWidth: 100),

                          child:  AutoSizeText('Activity Name: ',style: TextStyle( color: Colors.white ),minFontSize: 8,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Container(
                          constraints: BoxConstraints(minWidth: 20, maxWidth: 100),
                          child:  AutoSizeText(
                            Value_name ?? '',
                            style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500),
                            minFontSize: 10,
                            maxLines: 2,

                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        Spacer(),
                        Container(
                            child: Row(
                              children: <Widget>[

                                Container(
                                  constraints: BoxConstraints(minWidth: 20, maxWidth: 100),

                                  child:  AutoSizeText('Logged in: ',style: TextStyle( color: Colors.white ),minFontSize: 8,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                ),

                                Container(
                                  constraints: BoxConstraints(minWidth: 20, maxWidth:100),
                                  child:  AutoSizeText(

                                    userName??'-----' ,
                                    style: TextStyle(color: Colors.white),
                                    minFontSize: 8,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.right,

                                  ),
                                )

                              ],
                            )
                        ),


                      ]
                  )
              ),
              Container(
                  height: 80.0,
                  padding: const EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0,bottom: 8.0,),
                  color: Colors.black54,



                  child: Row(
                      children: [

                        Text('Beneficiary Referral Form ',style: TextStyle( fontSize: 23,color: Colors.white),),


                      ]
                  )
              ),

            ],
          )
      ),
      ///working on scrolling
      body: SafeArea(
          child: Center (
              child:    Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width ,
//          color: Color.fromRGBO(246,246,246, 1),
                padding: EdgeInsets.all(20.0),
//        color:Colors.green,
                child:Column(
                  children: [

                    Expanded(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
//                      controller: emailController,

                                  style: TextStyle(color: Colors.grey),

                                  decoration: new InputDecoration(

                                    labelStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                    errorStyle: TextStyle(
                                        color: Colors.red
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
//                        prefixIcon: Icon(Icons.person_outline,color: Colors.white),
                                    labelText: 'Name',
//                                   hintText: "Name Head of Household",
                                    hintStyle: TextStyle(color: Colors.grey),

                                  ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Field is required';
                                    }
                                    if (val.length < 2) {
                                      return 'Field is too short';
                                    }
                                    return null;
                                  },
                                  controller: nameController,
                                  onChanged: (value){
                                    setState(() {
                                      _AddBeneficiary.name = nameController.text;
                                      print(nameController);
                                    });
                                  },

                                ),
                                SizedBox(height: 20.0,),
                                TextFormField(
//                      controller: emailController,

                                  style: TextStyle(color: Colors.grey),

                                  decoration: new InputDecoration(

                                    labelStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                    errorStyle: TextStyle(
                                        color: Colors.red
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
//                        prefixIcon: Icon(Icons.person_outline,color: Colors.white),
                                    labelText: 'Father Name',
//                                   hintText: "Name Head of Household",
                                    hintStyle: TextStyle(color: Colors.grey),

                                  ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Field is required';
                                    }
                                    if (val.length < 2) {
                                      return 'Field is too short';
                                    }
                                    return null;
                                  },
                                  controller: fatherController,
                                  onChanged: (value){
                                    setState(() {
                                      _AddBeneficiary..fatherName = fatherController.text;
                                      print(fatherController);
                                    });
                                  },

                                ),
                                SizedBox(height: 20.0,),
                                TextFormField(
//                      controller: emailController,
                                  inputFormatters: [
                                    MaskedTextInputFormatter(
                                      mask: 'xxxxx-xxxxxxx-x',
                                      separator: '-',

                                    ),
                                  ],
                                  style: TextStyle(color: Colors.grey),
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(

                                    labelStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                    errorStyle: TextStyle(
                                        color: Colors.red
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
//                        prefixIcon: Icon(Icons.person_outline,color: Colors.white),
                                    labelText: 'CNIC Number',
                                    hintText: "xxxxx-xxxxxxx-x",
                                    hintStyle: TextStyle(color: Colors.grey),


                                  ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Field is required';
                                    }
                                    if (val.length <= 13) {
                                      return 'Enter Nic 13 digits';
                                    }
                                    return null;
                                  },
                                  controller: cnicController,
                                  onChanged: (value){
                                    setState(() {
                                      _AddBeneficiary.cnic = cnicController.text;
                                      print(cnicController);
                                    });
                                  },

                                ),
                                SizedBox(height: 20.0,),
                                TextFormField(
//                      controller: emailController,
                                  inputFormatters: [
                                    MaskedTextInputFormatter(
                                      mask: 'xxxx-xxxxxxx',
                                      separator: '-',
                                    ),
                                  ],
                                  style: TextStyle(color: Colors.grey),
                                  keyboardType: TextInputType.number,

                                  decoration: new InputDecoration(

                                    labelStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                    errorStyle: TextStyle(
                                        color: Colors.red
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
//                        prefixIcon: Icon(Icons.person_outline,color: Colors.white),
                                    labelText: 'Mobile No',
                                    hintText: "03xx-xxxxxx",
                                    hintStyle: TextStyle(color: Colors.grey),

                                  ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Field is required';
                                    }
                                    if (val.length <= 11) {
                                      return 'Enter 11 digits';
                                    }
                                    return null;
                                  },
                                  controller: cellController,
                                  onChanged: (value){
                                    setState(() {
                                      _AddBeneficiary.mobileNo = cellController.text;
                                      print(cellController);
                                    });
                                  },

                                ),
                                SizedBox(height: 20.0,),
                                TextFormField(
//                      controller: emailController,

                                  style: TextStyle(color: Colors.grey),

                                  decoration: new InputDecoration(

                                    labelStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                    errorStyle: TextStyle(
                                        color: Colors.red
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
//                        prefixIcon: Icon(Icons.person_outline,color: Colors.white),
                                    labelText: 'District',
//                                   hintText: "Name Head of Household",
                                    hintStyle: TextStyle(color: Colors.grey),

                                  ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Field is required';
                                    }
                                    if (val.length < 2) {
                                      return 'Field is too short';
                                    }
                                    return null;
                                  },
                                  controller: districtController,
                                  onChanged: (value){
                                    setState(() {
                                      _AddBeneficiary.district = districtController.text;
                                      print(districtController);
                                    });
                                  },

                                ),

                                SizedBox(height: 20.0,),
                                TextFormField(
//                      controller: emailController,

                                  style: TextStyle(color: Colors.grey),

                                  decoration: new InputDecoration(

                                    labelStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                    errorStyle: TextStyle(
                                        color: Colors.red
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
//                        prefixIcon: Icon(Icons.person_outline,color: Colors.white),
                                    labelText: 'Taluka',
//                                   hintText: "Name Head of Household",
                                    hintStyle: TextStyle(color: Colors.grey),

                                  ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Field is required';
                                    }
                                    if (val.length < 2) {
                                      return 'Field is too short';
                                    }
                                    return null;
                                  },
                                  controller: talukaController,
                                  onChanged: (value){
                                    setState(() {
                                      _AddBeneficiary.taluka = talukaController.text;
                                      print(talukaController);
                                    });
                                  },


                                ),
                                SizedBox(height: 20.0,),
                                TextFormField(
//                      controller: emailController,

                                  style: TextStyle(color: Colors.grey),

                                  decoration: new InputDecoration(

                                    labelStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                    errorStyle: TextStyle(
                                        color: Colors.red
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
//                        prefixIcon: Icon(Icons.person_outline,color: Colors.white),
                                    labelText: 'Village',
//                                   hintText: "Name Head of Household",
                                    hintStyle: TextStyle(color: Colors.grey),

                                  ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Field is required';
                                    }
                                    if (val.length < 2) {
                                      return 'Field is too short';
                                    }
                                    return null;
                                  },
                                  controller: villageController,
                                  onChanged: (value){
                                    setState(() {
                                      _AddBeneficiary.village = villageController.text;
                                      print(villageController);
                                    });
                                  },

                                ),
                                SizedBox(height: 20.0,),
                                TextFormField(
//                      controller: emailController,

                                  style: TextStyle(color: Colors.grey),

                                  decoration: new InputDecoration(

                                    labelStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                    errorStyle: TextStyle(
                                        color: Colors.red
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
//                        prefixIcon: Icon(Icons.person_outline,color: Colors.white),
                                    labelText: 'Activity of engagement',
//                                   hintText: "Name Head of Household",
                                    hintStyle: TextStyle(color: Colors.grey),

                                  ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Field is required';
                                    }
                                    if (val.length < 2) {
                                      return 'Field is too short';
                                    }
                                    return null;
                                  },
                                  controller: activityController,
                                  onChanged: (value){
                                    setState(() {
                                      _AddBeneficiary.activityEvent = activityController.text;
                                      print(activityController);
                                    });
                                  },

                                ),
                                SizedBox(height: 20.0,),
                                TextFormField(
//                      controller: emailController,

                                  style: TextStyle(color: Colors.grey),

                                  decoration: new InputDecoration(

                                    labelStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                    errorStyle: TextStyle(
                                        color: Colors.red
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
//                        prefixIcon: Icon(Icons.person_outline,color: Colors.white),
                                    labelText: 'Supplier name',
//                                   hintText: "Name Head of Household",
                                    hintStyle: TextStyle(color: Colors.grey),

                                  ),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Field is required';
                                    }
                                    if (val.length < 2) {
                                      return 'Field is too short';
                                    }
                                    return null;
                                  },
                                  controller: supplierController,
                                  onChanged: (value){
                                    setState(() {
                                      _AddBeneficiary.supplierName = supplierController.text;
                                      print(supplierController);
                                    });
                                  },

                                ),
                                // SizedBox(height: 20.0,),
                                // Container(
                                //   padding: new EdgeInsets.only(top: 20.0,),
                                //   alignment: Alignment.topLeft,
                                //   child:  Text(
                                //     'Location',
                                //     style: TextStyle(fontSize: 16, color: myColor,
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(height: 15.0,),
                                // Container(
                                //     child:Text(_AddBeneficiary.mapLocation ?? "no location" ,style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black),)
                                //
                                // ),
                                SizedBox(height: 20.0,),
                                TextFormField(
//                      controller: emailController,

                                  style: TextStyle(color: Colors.grey),

                                  decoration: new InputDecoration(

                                    labelStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                    errorStyle: TextStyle(
                                        color: Colors.red
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
//                        prefixIcon: Icon(Icons.person_outline,color: Colors.white),
                                    labelText: 'Location',
//                                   hintText: "Name Head of Household",
                                    hintStyle: TextStyle(color: Colors.grey),

                                  ),
                                  // validator: (val) {
                                  //   if (val.isEmpty) {
                                  //     return 'Field is required';
                                  //   }
                                  //   if (val.length < 2) {
                                  //     return 'Field is too short';
                                  //   }
                                  //   return null;
                                  // },
                                  controller: LocationController,
                                  onChanged: (value){
                                    setState(() {
                                      _AddBeneficiary.mapLocation = LocationController.text;
                                      print(LocationController);
                                    });
                                  },

                                ),
                                SizedBox(height: 20.0,),
//                                 Container(
//                                   child: files.isEmpty
//                                       ? new Text("No attachment!",style: TextStyle(fontSize: 20.0),)
//                                       : new Text("attachment added",style: TextStyle(fontSize: 20.0,color: Colors.green)),
//                                 ),
//                                 SizedBox(height: 5.0,),
//                                 Container(
//                                   child: Text(attachnames.join(", ") ,style: new TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1)) ),
//                                 ),
//                                 Container(
//
//                                     child:  Row(
//
//                                       children: <Widget>[
//                                         ElevatedButton(
//                                           style: ButtonStyle(
//                                               backgroundColor: (galaryPressed) ? MaterialStateProperty.all(Colors.red)
//                                                   : MaterialStateProperty.all(themeblue),
//                                               padding: MaterialStateProperty.all(EdgeInsets.only(left: 30.0,right: 30.0,top: 7.0,bottom: 7.0)),
//                                               textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))),
//
//                                           child: Icon(Icons.image, color: Colors.white,),
//                                           onPressed: loadAssets,
//                                         ),
//                                         SizedBox(width: 10.0,),
//                                         ElevatedButton(
//                                           style: ButtonStyle(
//                                               backgroundColor: (galaryPressed) ? MaterialStateProperty.all(Colors.red)
//                                                   : MaterialStateProperty.all(themeblue),
//                                               padding: MaterialStateProperty.all(EdgeInsets.only(left: 30.0,right: 30.0,top: 7.0,bottom: 7.0)),
//                                               textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))),
//
//                                           child: Icon(Icons.camera_alt,color: Colors.white,),
//                                           onPressed:
//                                           getImageCamera,
//                                         ),
// //                                              RaisedButton(
// //                                                child: Text("UPLOAD video"),
// //                                                onPressed:(){
// ////                                                  uploadVideo(_video);
// //                                                },
// //                                              ),
//
//                                       ],
//                                     )
//                                 ),
//                                 SizedBox(height: 15.0,),

                              ],
                            ),
                          ),
                        ),
                      ),


                    ),
//                      Padding(
//                          padding: const EdgeInsets.symmetric(vertical: 10.0),
//                          child:
                    Align(
                      child: SizedBox(
//                              width: 600,
                        child: ElevatedButton(

                            style: ElevatedButton.styleFrom(
                              primary: darkblue,
                              shadowColor: Colors.deepOrangeAccent,


                            ),
                            onPressed: () {
//                                   Validate returns true if the form is valid, or false
//                                   otherwise.
//                               if (_formKey.currentState.validate() && files.isNotEmpty ) {
                                if (_formKey.currentState.validate() ) {
                                showLoaderDialog(context);
                                _submitForm();
                              }
                              // else if (files.isEmpty  ){
                              //
                              //   setState(()
                              //   {
                              //     galaryPressed = true;
                              //   });
                              // }

                            },
                            child: Container(
//                                    height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width ,
//                                    width: 600.0,

                              child:Text('Submit',textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0)
                              ),
                            )
                        ),
                      ),
                    ),

//                      ),
                  ],
                ),



              )

          )

      ),
//      drawer: CustomerDrawer(),
    )
    ),

    );
  }
  Future<void> _submitForm() async {
    final FormState form = _formKey.currentState;

//    if (form.validate()) {
//      String a= _fbKey.currentState.value.toString();
//      _formResult.supporterType = a;
    SharedPreferences prefs = await SharedPreferences.getInstance();
//    //Return int
//    int Value = prefs.getInt('jobId');
    int u_id = prefs.getInt('user_id');




//    _AddResult.name = widget.EconomicDetail.name.toString();
    form.save();
//    print(_AddResult.toMap());

//    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenn = ( prefs.getString('token'));
    String token = 'Bearer '+ tokenn;

    final uri = baseURL + 'beneficiaryform';
//    _onLoading();
    http.Response response = await http.post(
      Uri.parse(uri), headers: { 'Content-type': 'application/json',
      'Accept': 'application/json', HttpHeaders.authorizationHeader: token },body: (json.encode(_AddBeneficiary.toMap())),
    );
    Navigator.pop(this.context);

    print(response.toString());


    if (response.statusCode == 200) {
      print('Data saved');
      _onLoading();

//      setState(() => _dialogState = DialogState.LOADING);
//      Future.delayed(Duration(seconds: 5)).then((_) {
//        setState(() => _dialogState = DialogState.COMPLETED);
//        Timer(Duration(seconds: 5), () =>
//            setState(() => _dialogState = DialogState.DISMISSED));
//      });
    } else {
      _notUploaded();
      print('Data not saved');
      print(response.statusCode);
      throw Exception("Problem in uploading");
//      setState(() => _f_dialogState = F_DialogState.LOADING);
//      setState(() => _f_dialogState = F_DialogState.Failed);
//      Future.delayed(Duration(seconds: 5)).then((_) {
//        setState(() => _f_dialogState = F_DialogState.DISMISSED);
//      });
    }


//    print(response.body);
    print(_AddBeneficiary.toMap());



//    }

  }

  void _onLoading() {
    showDialog(
        barrierDismissible: false,
        context: this.context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container( margin: EdgeInsets.only(bottom: 20.0),
                      child: Text("Data uploaded successfully",  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                      ),
                    ),
                    SizedBox(
                      width: 200.0,
                      child: RaisedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => BeneficiaryForm()),
                                    (Route<dynamic> route) => false
                            );

                          },
                          child: Text(
                            "Back to Form",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: myColor
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
  void _notUploaded() {
    showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              width: 300,

              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child:  Text("Something went wrong..!",  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                      ),

                    ),
                    SizedBox(
                      width: 200.0,
                      child: RaisedButton(
                          onPressed: () {Navigator.pop(context);},
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Color.fromRGBO(0, 150, 136, 1)                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 15.0),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

//   getLocation() async {
//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
// //    String posi  = position.toString();
//     Coordinates coordinates = Coordinates(position.latitude,position.longitude);
//     var location = await Geocoder.local.findAddressesFromCoordinates(coordinates);
// //    print(location);
//     var first = location.first;
//
//     setState(() {
//       _AddBeneficiary.mapLat = position.latitude.toString();
//       _AddBeneficiary.mapLong = position.longitude.toString();
//       _AddBeneficiary.mapLocation = first.addressLine;
//     });
//     print("${first.addressLine}");
//
// //    print(MapAddress);
//   }
//   Future getImageCamera() async{
//     final pickedFile = await picker.getImage(source: ImageSource.camera);
//     File imageFile = new File(pickedFile.path);
//     var base64Image = base64Encode(imageFile.readAsBytesSync());
//     String fileExt = imageFile.path.split('.').last;
//
//     attachnames.clear();
//     attachnames.add(imageFile.path.split('/').last);
//     files.add(AttachmentsClass(image: base64Image,extension: fileExt));
// //    var videoFile = await ImagePicker.pickImage(source: ImageSource.camera);
// //     List<int> videoBytes = imageFile.readAsBytesSync();
// //     file = base64.encode(videoBytes);
// //     String fi = "jpg,"+ file ;
// //     print(fi);
//     setState(()  {
//
//       _AddBeneficiary.attachment = files;
//
//     });
//   }
//   Future<void> loadAssets() async {
//
//     List<Asset> resultList = <Asset>[];
//     String error = 'No Error Detected';
//
//     try {
//       resultList = await MultiImagePicker.pickImages(
//         maxImages: 6,
//         enableCamera: false,
//         selectedAssets: images,
//         cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//         materialOptions: MaterialOptions(
//           actionBarColor: "#abcdef",
//           actionBarTitle: "SSEP",
//           allViewTitle: "All Photos",
//           useDetailsView: false,
//           selectCircleStrokeColor: "#000000",
//         ),
//       );
//
//     } on Exception catch (e) {
//       error = e.toString();
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       images = resultList;
// //      final String _images = resultList.map((e){
// //        return e.getByteData().then((value) =>value.toString());
// //      }).toList().join(',');
//
// //      attch.insert(0, Attachment(image:images.getByteData.toString(),extension: "abc"));
//
//
// //      _AddBeneficiary.attachment =_images;
//       print(images);
//
//       _error = error;
//       _saveimg();
//     });
//
//   }
//
//   getImgaeFilefromPath (String path) async{
//     final filee = File(path);
//     return filee;
//   }
//
//   _saveimg () async{
//     if(images != null)
//     {
//       attachnames.clear();
//       for(var i = 0 ; i <images.length; i++)
//       {
//         var path2  = await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
//         var file = await getImgaeFilefromPath(path2);
//         var base64Image = base64Encode(file.readAsBytesSync());
//         String fileExt = file.path.split('.').last;
//         attachnames.add(file.path.split('/').last);
//         files.add(AttachmentsClass(image: base64Image,extension: fileExt));
//
// //          List<int> imgdata = byteData.buffer.asInt8List();
// //          file = base64.encode(imgdata);
// //          String fi = file ;
//
//         setState(()  {
// //      _video = imageFile;
//           _AddBeneficiary.attachment = files;
//
//         });
//
//       }
//     }
//   }

}

_moveToSignInScreen(BuildContext context) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Btl_Record_List()),
            (Route<dynamic> route) => false
    );


class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    @required this.mask,
    @required this.separator,
  }) { assert(mask != null); assert (separator != null); }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.length > 0) {
      if(newValue.text.length > oldValue.text.length) {
        if(newValue.text.length > mask.length) return oldValue;
        if(newValue.text.length < mask.length && mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text: '${oldValue.text}$separator${newValue.text.substring(newValue.text.length-1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
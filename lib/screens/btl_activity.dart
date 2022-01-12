
import 'dart:convert';
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
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssepnew/CustomAppBar.dart';
import 'package:ssepnew/consts.dart';
import 'package:ssepnew/models/BtlActivity_model.dart';
import 'package:ssepnew/models/SurveyModel.dart';
import 'package:ssepnew/screens/btl_records.dart';
import 'package:ssepnew/screens/purchased.dart';
import 'package:ssepnew/themes.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';




class BtlActivityScreen extends StatefulWidget {

//  final List<Survey> EconomicDetail;

//  const EconomicScreen({Key key, @required this.EconomicDetail}) : super(key: key);


  @override
  _BtlActivityScreen createState() => _BtlActivityScreen();
}

class _BtlActivityScreen extends State<BtlActivityScreen> {


  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String userName = '';

  String file;
  final picker = ImagePicker();
  // final picker2 = ImagePicker();
  final _AddBtl = BtlActivityModel();
  String Value_name;
  bool viewVisible = true ;
  bool viewMfi = true;
  String electricity = 'No';
  String Mfi = "No";
  String information = "TV";
  String MapAddress = '';
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  List<AttachmentsClass> files = [] ;
  bool  galaryPressed = false;
  bool  CameraPressed = false;
  String attachmentname ='';
  List<String> attachnames = [];


  TextEditingController nameController = TextEditingController();
  TextEditingController fatherController = TextEditingController();
  TextEditingController nicController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController ucController = TextEditingController();
  TextEditingController talukaController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController nearestController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController Controller = TextEditingController();
  TextEditingController maleController = TextEditingController();
  TextEditingController femaleController = TextEditingController();
  TextEditingController childrenController = TextEditingController();
  TextEditingController loadController = TextEditingController();
  TextEditingController mfiController = TextEditingController();

  void showWidgetElect(){

    setState(() {
      viewVisible = true ;
    });
  }

  void hideWidgetElect(){

    setState(() {
      viewVisible = false ;
    });
  }

  void showWidgetMfi(){

    setState(() {
      viewMfi = true ;
    });
  }

  void hideWidgetMfi(){

    setState(() {
      viewMfi = false ;
    });
  }




  @override
  void dispose() {
    nameController.dispose();
    fatherController.dispose();
        nicController.dispose();
        mobileController.dispose();
        districtController.dispose();
        ucController.dispose();
        talukaController.dispose();
        villageController.dispose();
        nearestController.dispose();
        addressController.dispose();
        maleController.dispose();
        femaleController.dispose();
        childrenController.dispose();
        loadController.dispose();
        mfiController.dispose();


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

      getLocation();
      hideWidgetElect();
      hideWidgetMfi();
      galaryPressed = false;
      CameraPressed = false;
      electricity = "No";
      information ="TV";
      _AddBtl.sourceOfInfo =information;
      _AddBtl.electricity =electricity;
      _AddBtl.mocrofinanceload  =Mfi;

    });
    super.initState();
  }





  bool _validate = false;


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 2;
    return WillPopScope (
        onWillPop: () {
      return _moveToSignInScreen(context);
    },
        child: SafeArea(
            child:  new Scaffold(
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

                                Text('Call Center Form',style: TextStyle( fontSize: 23,color: Colors.white),),


//                    Spacer(),
//                    Container(
//                        child: Row(
//                          children: <Widget>[
//                            Text('Clinic Name : ',style: TextStyle( fontSize: 20,color: Colors.white),),
//                            Container(
//                              constraints: BoxConstraints(minWidth: 20, maxWidth: 250),
//                              child:  AutoSizeText(
//                                Clinic??'',
//                                style: TextStyle(fontSize: 20,color: Colors.white),
//                                minFontSize: 18,
//                                maxLines: 2,
//                                overflow: TextOverflow.ellipsis,
////                       textAlign: TextAlign.right,
//
//                              ),
//                            )
//
//                          ],
//                        )
//                    ),


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
                                              _AddBtl.name = nameController.text;
                                              print(_AddBtl.name);
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
                                              _AddBtl.fatherName = fatherController.text;
                                              print(_AddBtl.fatherName);
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
                                            labelText: 'Nic No',
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
                                          controller: nicController,
                                          onChanged: (value){
                                            setState(() {
                                              _AddBtl.cnic = nicController.text;
                                              print(_AddBtl.cnic);
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
                                            labelText: 'Mobile no',
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
                                          controller: mobileController,
                                          onChanged: (value){
                                            setState(() {
                                              _AddBtl.mobileNo = mobileController.text;
                                              print(_AddBtl.mobileNo);
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
                                              _AddBtl.district = districtController.text;
                                              print(_AddBtl.district);
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
                                            labelText: 'UC',
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
                                          controller: ucController,
                                          onChanged: (value){
                                            setState(() {
                                              _AddBtl.uc = ucController.text;
                                              print(_AddBtl.uc);
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
                                              _AddBtl.taluka = talukaController.text;
                                              print(_AddBtl.taluka);
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
                                              _AddBtl.village = villageController.text;
                                              print(_AddBtl.village);
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
                                            labelText: 'Nearest Landmark',
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
                                          controller: nearestController,
                                          onChanged: (value){
                                            setState(() {
                                              _AddBtl.nLandmark = nearestController.text;
                                              print(_AddBtl.nLandmark);
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
                                            labelText: 'Address',
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
                                          controller: addressController,
                                          onChanged: (value){
                                            setState(() {
                                              _AddBtl.address = addressController.text;
                                              print(_AddBtl.address);
                                            });
                                          },

                                        ),
                                        SizedBox(height: 20.0,),
                                        Container(
                                          padding: new EdgeInsets.only(top: 20.0,),

                                          child:  Text(
                                            'Number of Family Members in your household:',
                                            style: TextStyle(fontSize: 16, color: myColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20.0,),
                                        Row(
                                          children:<Widget> [
                                            Container(
                                              padding: new EdgeInsets.only(top: 15.0,right: 15.0),
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Male',
                                                style: new TextStyle(
//                                     fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 30.0,

                                              child:  TextFormField(

//                      controller: emailController,
                                                style: TextStyle(color: Colors.grey),

                                                decoration: new InputDecoration(
                                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: -5),
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
                                                  labelText: '',
                                                  hintStyle: TextStyle(color: Colors.grey),

                                                ),
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter.digitsOnly,
                                                  LengthLimitingTextInputFormatter(2)

                                                ],
//                                          validator: (val) {
//                                            if (val.isEmpty) {
//                                              return 'Field is required';
//                                            }
//                                            return null;
//                                          },
                                                controller: maleController,
                                                onChanged: (value){
                                                  setState(() {
                                                    _AddBtl.maleCount = int.parse(maleController.text);
                                                    print(_AddBtl.maleCount);
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children:<Widget> [
                                            Container(
                                              padding: new EdgeInsets.only(top: 15.0,right: 15.0),
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Female',
                                                style: new TextStyle(
//                                     fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 30.0,

                                              child:  TextFormField(

//                      controller: emailController,
                                                style: TextStyle(color: Colors.grey),

                                                decoration: new InputDecoration(
                                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: -5),
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
                                                  labelText: '',
                                                  hintStyle: TextStyle(color: Colors.grey),

                                                ),
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter.digitsOnly,
                                                  LengthLimitingTextInputFormatter(2)

                                                ],
//                                          validator: (val) {
//                                            if (val.isEmpty) {
//                                              return 'Field is required';
//                                            }
//                                            return null;
//                                          },
                                                controller: femaleController,
                                                onChanged: (value){
                                                  setState(() {
                                                    _AddBtl.femaleCount = int.parse(femaleController.text);
                                                    print(_AddBtl.femaleCount);
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children:<Widget> [
                                            Container(
                                              padding: new EdgeInsets.only(top: 15.0,right: 15.0),
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'children',
                                                style: new TextStyle(
//                                     fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 30.0,

                                              child:  TextFormField(

//                      controller: emailController,
                                                style: TextStyle(color: Colors.grey),

                                                decoration: new InputDecoration(
                                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: -5),
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
                                                  labelText: '',
                                                  hintStyle: TextStyle(color: Colors.grey),

                                                ),
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter.digitsOnly,
                                                  LengthLimitingTextInputFormatter(2)

                                                ],
//                                          validator: (val) {
//                                            if (val.isEmpty) {
//                                              return 'Field is required';
//                                            }
//                                            return null;
//                                          },
                                                controller: childrenController,
                                                onChanged: (value){
                                                  setState(() {
                                                    _AddBtl.childrenCount = int.parse(childrenController.text);
                                                    print(_AddBtl.childrenCount);
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.0,),
                                        Container(
                                          padding: new EdgeInsets.only(top: 20.0,),

                                          child:  Text(
                                            'What is your source of information?',
                                            style: TextStyle(fontSize: 16, color: myColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20.0,),
                                        new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Radio(
                                              value: "TV",
                                              groupValue: information,
                                              activeColor: myColor,

                                              onChanged:  ( value) {
                                                setState(() {
                                                  information = value;
                                                  _AddBtl.sourceOfInfo =information.toString();
                                                  print(_AddBtl.sourceOfInfo);
                                                });
                                              },
                                            ),
                                            new Text(
                                              'TV',
                                              style: new TextStyle(fontSize: 16.0),
                                            ),


                                          ],
                                        ),
                                        new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Radio(
                                              value: "Social Media",
                                              groupValue: information,
                                              activeColor: myColor,

                                              onChanged:  ( value) {
                                                setState(() {
                                                  information = value;
                                                  _AddBtl.sourceOfInfo =information.toString();
                                                  print(_AddBtl.sourceOfInfo );
                                                });
                                              },
                                            ),
                                            new Text(
                                              'Social Media',
                                              style: new TextStyle(fontSize: 16.0),
                                            ),


                                          ],
                                        ),
                                        new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Radio(
                                              value: "Connect Representative",
                                              groupValue: information,
                                              activeColor: myColor,

                                              onChanged:  ( value) {
                                                setState(() {
                                                  information = value;
                                                  _AddBtl.sourceOfInfo =information.toString();
                                                  print(_AddBtl.sourceOfInfo );
                                                });
                                              },
                                            ),
                                            new Text(
                                              'Connect Representative',
                                              style: new TextStyle(fontSize: 16.0),
                                            ),


                                          ],
                                        ),
                                        new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Radio(
                                              value:'Radio',
                                              groupValue: information,
                                              activeColor: myColor,

                                              onChanged:  ( value) {
                                                setState(() {
                                                  information = value;
                                                  _AddBtl.sourceOfInfo =information.toString();
                                                  print(_AddBtl.sourceOfInfo );
                                                });
                                              },
                                            ),
                                            new Text(
                                              'Radio',
                                              style: new TextStyle(fontSize: 16.0),
                                            ),


                                          ],
                                        ),
                                        new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Radio(
                                              value: 'Friend',
                                              groupValue: information,
                                              activeColor: myColor,

                                              onChanged:  ( value) {
                                                setState(() {
                                                  information = value;
                                                  _AddBtl.sourceOfInfo =information.toString();
                                                  print(_AddBtl.sourceOfInfo );
                                                });
                                              },
                                            ),
                                            new Text(
                                              'Friend',
                                              style: new TextStyle(fontSize: 16.0),
                                            ),


                                          ],
                                        ),
                                        new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Radio(
                                              value: 'Other',
                                              groupValue: information,
                                              activeColor: myColor,

                                              onChanged:  ( value) {
                                                setState(() {
                                                  information = value;
                                                  _AddBtl.sourceOfInfo =information.toString();
                                                  print(_AddBtl.sourceOfInfo );
                                                });
                                              },
                                            ),
                                            new Text(
                                              'Other',
                                              style: new TextStyle(fontSize: 16.0),
                                            ),


                                          ],
                                        ),
                                        Container(
                                          padding: new EdgeInsets.only(top: 20.0,),

                                          child:  Text(
                                            'Do you have electricity in your house?',
                                            style: TextStyle(fontSize: 16, color: myColor,
                                            ),
                                          ),
                                        ),
                                        new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Radio(
                                              value: "Yes",
                                              groupValue: electricity,
                                              activeColor: myColor,

                                              onChanged:  ( value) {
                                                setState(() {
                                                  showWidgetElect();
                                                  electricity = value;
                                                  _AddBtl.electricity =electricity.toString();
                                                  print(electricity);
                                                });
                                              },
                                            ),
                                            new Text(
                                              'Yes',
                                              style: new TextStyle(fontSize: 16.0),
                                            ),
                                            new Radio(
                                              value: "No",
                                              groupValue: electricity,
                                              activeColor: myColor,

                                              onChanged:  ( value) {
                                                setState(() {
                                                  hideWidgetElect();
                                                  electricity = value;
                                                  _AddBtl.electricity =electricity.toString();
                                                  print(electricity);
                                                });
                                              },
                                            ),
                                            new Text(
                                              'No',
                                              style: new TextStyle(fontSize: 16.0),
                                            ),


                                          ],
                                        ),
                                        Visibility(
                                            maintainSize: true,
                                            maintainAnimation: true,
                                            maintainState: true,
                                            visible: viewVisible,
                                            child: Container(
//                                      height: 200,
//                                      width: 200,
//                                      color: Colors.green,
//                                      margin: EdgeInsets.only(top: 50, bottom: 30),
                                                child: Column(children: [
                                                  Container(
                                                    padding: new EdgeInsets.only(top: 20.0,),
                                                    alignment: Alignment.topLeft,
                                                    child:  Text(
                                                      'How many hours of load shedding you face?',
                                                      style: TextStyle(fontSize: 14, color: myColor,
                                                      ),
                                                    ),
                                                  ),
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
                                                      labelText: 'Details',
//                                   hintText: "Name Head of Household",
                                                      hintStyle: TextStyle(color: Colors.grey),

                                                    ),
//                                          validator: (val) {
//                                            if (val.isEmpty) {
//                                              return 'Field is required';
//                                            }
//                                            if (val.length < 2) {
//                                              return 'Field is too short';
//                                            }
//                                            return null;
//                                          },
                                                    controller: loadController,
                                                    onChanged: (value){
                                                      setState(() {
                                                        _AddBtl.loadsheddingHours = loadController.text;
                                                        print(_AddBtl.loadsheddingHours);
                                                      });
                                                    },

                                                  ),
                                                ],
                                                )
                                            )
                                        ),
                                        Container(
                                          padding: new EdgeInsets.only(top: 20.0,),

                                          child:  Text(
                                            'Have you ever got Micro Finance Load?',
                                            style: TextStyle(fontSize: 16, color: myColor,
                                            ),
                                          ),
                                        ),
                                        new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Radio(
                                              value: "Yes",
                                              groupValue: Mfi,
                                              activeColor: myColor,

                                              onChanged:  ( value) {
                                                setState(() {
                                                  showWidgetMfi();
                                                  Mfi = value;
                                                  _AddBtl.mocrofinanceload  =Mfi.toString();
                                                  print( _AddBtl.mocrofinanceload);
                                                });
                                              },
                                            ),
                                            new Text(
                                              'Yes',
                                              style: new TextStyle(fontSize: 16.0),
                                            ),
                                            new Radio(
                                              value: "No",
                                              groupValue: Mfi,
                                              activeColor: myColor,

                                              onChanged:  ( value) {
                                                setState(() {
                                                  hideWidgetMfi();
                                                  Mfi = value;
                                                  _AddBtl.mocrofinanceload  =Mfi.toString();
                                                  print(Mfi);
                                                });
                                              },
                                            ),
                                            new Text(
                                              'No',
                                              style: new TextStyle(fontSize: 16.0),
                                            ),


                                          ],
                                        ),
                                        Visibility(
                                            maintainSize: true,
                                            maintainAnimation: true,
                                            maintainState: true,
                                            visible: viewMfi,
                                            child: Container(
//                                      height: 200,
//                                      width: 200,
//                                      color: Colors.green,
//                                      margin: EdgeInsets.only(top: 50, bottom: 30),
                                                child: Column(children: [
                                                  Container(
                                                    padding: new EdgeInsets.only(top: 20.0,),
                                                    alignment: Alignment.topLeft,
                                                    child:  Text(
                                                      'From which MFI ?',
                                                      style: TextStyle(fontSize: 14, color: myColor,
                                                      ),
                                                    ),
                                                  ),
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
                                                      labelText: 'Details',
//                                   hintText: "Name Head of Household",
                                                      hintStyle: TextStyle(color: Colors.grey),

                                                    ),
//                                          validator: (val) {
//                                            if (val.isEmpty) {
//                                              return 'Field is required';
//                                            }
//                                            if (val.length < 2) {
//                                              return 'Field is too short';
//                                            }
//                                            return null;
//                                          },
                                                    controller: mfiController,
                                                    onChanged: (value){
                                                      setState(() {
                                                        _AddBtl.mfi = mfiController.text;
                                                        print(_AddBtl.mfi);
                                                      });
                                                    },

                                                  ),
                                                ],
                                                )
                                            )
                                        ),
                                        SizedBox(height: 10.0,),
                                        Container(
                                          padding: new EdgeInsets.only(top: 20.0,),
                                          alignment: Alignment.topLeft,
                                          child:  Text(
                                            'Location',
                                            style: TextStyle(fontSize: 16, color: myColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15.0,),
                                        Container(
                                            child:Text(_AddBtl.mapLocation ?? "no location" ,style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black),)

                                        ),
                                        SizedBox(height: 20.0,),
                                        Container(
                                          child: files.isEmpty
                                              ? new Text("No attachment!",style: TextStyle(fontSize: 20.0),)
                                              : new Text("attachment added",style: TextStyle(fontSize: 20.0,color: Colors.green)),
                                        ),
                                        SizedBox(height: 5.0,),
                                        Container(
                                          child: Text(attachnames.join(", ") ,style: new TextStyle(fontSize: 16.0,fontWeight:FontWeight.w400,color: Color.fromRGBO(113, 113, 113, 1)) ),
                                        ),
                                        Container(

                                            child:  Row(

                                              children: <Widget>[
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor: (galaryPressed) ? MaterialStateProperty.all(Colors.red)
                                                          : MaterialStateProperty.all(themeblue),
                                                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 30.0,right: 30.0,top: 7.0,bottom: 7.0)),
                                                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))),

                                                  child: Icon(Icons.image, color: Colors.white,),
                                                  onPressed: loadAssets,
                                                ),
                                                SizedBox(width: 10.0,),
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor: (galaryPressed) ? MaterialStateProperty.all(Colors.red)
                                                          : MaterialStateProperty.all(themeblue),
                                                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 30.0,right: 30.0,top: 7.0,bottom: 7.0)),
                                                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))),

                                                  child: Icon(Icons.camera_alt,color: Colors.white,),
                                                  onPressed:
                                                  getImageCamera,
                                                ),
//                                              RaisedButton(
//                                                child: Text("UPLOAD video"),
//                                                onPressed:(){
////                                                  uploadVideo(_video);
//                                                },
//                                              ),

                                              ],
                                            )
                                        ),
                                        SizedBox(height: 15.0,),
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
//                            onPrimary: Color.fromRGBO(32, 87, 163, 1),


                                    ),
                                    onPressed: () {
//                                   Validate returns true if the form is valid, or false
//                                   otherwise.
                                      if (_formKey.currentState.validate() && files.isNotEmpty ) {
//working on image add
                                        showLoaderDialog(context);
                                        _submitForm();
                                      }
                                      else if (files.isEmpty  ){

                                        setState(()
                                        {
                                          galaryPressed = true;
                                        });
                                      }

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
    _AddBtl.userId = u_id;
    int jbId = prefs.getInt('jobId');
    _AddBtl.formNo = "21";
    _AddBtl.date = "abc";



//    _AddResult.name = widget.EconomicDetail.name.toString();
    form.save();
//    print(_AddResult.toMap());

//    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenn = ( prefs.getString('token'));
    String token = 'Bearer '+ tokenn;
    print(_AddBtl.toString());
    final uri = baseURL +'callcenterform';
//    _onLoading();
    http.Response response = await http.post(
      Uri.parse(uri), headers: { 'Content-type': 'application/json',
      'Accept': 'application/json', HttpHeaders.authorizationHeader: token },body: (json.encode(_AddBtl.toMap())),
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
    print(_AddBtl.toMap());



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
                                MaterialPageRoute(builder: (context) => BtlActivityScreen()),
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

   _moveToSignInScreen(BuildContext context) =>
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Btl_Record_List()),
              (Route<dynamic> route) => false
      );

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
  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//    String posi  = position.toString();
    Coordinates coordinates = Coordinates(position.latitude,position.longitude);
    var location = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//    print(location);
    var first = location.first;

    setState(() {
      _AddBtl.mapLat = position.latitude.toString();
      _AddBtl.mapLong = position.longitude.toString();
      _AddBtl.mapLocation = first.addressLine;
    });
    print("${first.addressLine}");

//    print(MapAddress);
  }

  Future getImageCamera() async{
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    File imageFile = new File(pickedFile.path);
    var base64Image = base64Encode(imageFile.readAsBytesSync());
    String fileExt = imageFile.path.split('.').last;
    attachnames.clear();
    attachnames.add(imageFile.path.split('/').last);
    files.add(AttachmentsClass(image: base64Image,extension: fileExt));
//    var videoFile = await ImagePicker.pickImage(source: ImageSource.camera);
//     List<int> videoBytes = imageFile.readAsBytesSync();
//     file = base64.encode(videoBytes);
//     String fi = "jpg,"+ file ;
//     print(fi);
    setState(()  {

      _AddBtl.attachment = files;

    });
  }
  Future<void> loadAssets() async {

    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 6,
        enableCamera: false,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "SSEP",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );

    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
//      final String _images = resultList.map((e){
//        return e.getByteData().then((value) =>value.toString());
//      }).toList().join(',');

//      attch.insert(0, Attachment(image:images.getByteData.toString(),extension: "abc"));


//      _AddBeneficiary.attachment =_images;
      print(images);

      _error = error;
      _saveimg();
    });

  }

  getImgaeFilefromPath (String path) async{
    final filee = File(path);
    return filee;
  }

  _saveimg () async{
    if(images != null)
    {
      attachnames.clear();
      for(var i = 0 ; i <images.length; i++)
      {
        var path2  = await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
        var file = await getImgaeFilefromPath(path2);
        var base64Image = base64Encode(file.readAsBytesSync());
        String fileExt = file.path.split('.').last;

        attachnames.add(file.path.split('/').last);
        files.add(AttachmentsClass(image: base64Image,extension: fileExt));

//          List<int> imgdata = byteData.buffer.asInt8List();
//          file = base64.encode(imgdata);
//          String fi = file ;

        setState(()  {
//      _video = imageFile;
          _AddBtl.attachment = files;

        });

      }
    }
  }



//   Future getImageGallery() async{
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//     File imageFile = new File(pickedFile.path);
// //    var videoFile = await ImagePicker.pickImage(source: ImageSource.camera);
//     List<int> videoBytes = imageFile.readAsBytesSync();
//     file = base64.encode(videoBytes);
//     String fi = "jpg,"+ file ;
//     print(fi);
//     setState(()  {
// //      _video = imageFile;
//       _AddBtl.attachment = fi;
//
//     });
//   }


}


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
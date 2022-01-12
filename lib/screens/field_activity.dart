
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
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssepnew/CustomAppBar.dart';
import 'package:ssepnew/consts.dart';
import 'package:ssepnew/models/BeneficiaryFormModel.dart';
import 'package:ssepnew/models/BtlActivity_model.dart';
import 'package:ssepnew/models/FieldActivityModel.dart';
import 'package:ssepnew/models/SurveyModel.dart';
import 'package:ssepnew/screens/btl_records.dart';
import 'package:ssepnew/screens/purchased.dart';
import 'package:ssepnew/themes.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as path_provider;



class FieldActivityScreen extends StatefulWidget {

//  final List<Survey> EconomicDetail;

  FieldActivityScreen({Key key, }) : super(key: key);


  @override
  _FieldActivityScreen createState() => _FieldActivityScreen();
}

class _FieldActivityScreen extends State<FieldActivityScreen> {


  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _setDate = '';
  String userName = '';
  String Do_id = "";
  String officer = '';
  String Lat = '';
  String Long = '';

  // String file ='';
  // String file2 = '';

  // final picker = ImagePicker();
  // final picker2 = ImagePicker();
  final _AddFieldActivity = FieldActivityModel();
  String Value_name = '';
  bool viewVisible = true ;

  String MapAddress = '';

  TextEditingController activitynmController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController ucController = TextEditingController();
  TextEditingController talukaController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController participantsController = TextEditingController();
  TextEditingController maleController = TextEditingController();
  TextEditingController femaleController = TextEditingController();
  TextEditingController  dateController = TextEditingController();
  TextEditingController  LatController = TextEditingController();
  TextEditingController  longController = TextEditingController();
  TextEditingController  locationController = TextEditingController();



  List<AttachmentsList> files = [] ;
  List<AttendanceSheets> attdncfiles = [] ;

  List<Asset> images = <Asset>[];
  List<Asset> attendanceimages = <Asset>[];

  String _error = 'No Error Dectected';


  String dateTime;
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  bool  imagesPressed = false;
  bool attendancePressed = false;
  String imagescount = '';
  String attachimagescount = '';



  @override
  void dispose() {
    activitynmController.dispose();
    districtController.dispose();
    ucController.dispose();
    talukaController.dispose();
    villageController.dispose();
    participantsController.dispose();
    maleController.dispose();
    femaleController.dispose();
    dateController.dispose();
    LatController.dispose();
    longController.dispose();
    locationController.dispose();
    super.dispose();

  }

  FetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    setState(() {
      userName = (prefs.getString('user_name') ?? '');
      officer = (prefs.getString('createdBy') ?? '');
      Value_name =(prefs.getString('task_title') ?? '');
      Do_id =(prefs.getString('do_id') ?? '');
    });
  }




  @override
  void initState() {
    super.initState();
    setState(() {
      dateController.text = dateFormat.format(selectedDate) ;
      FetchData();
      // getLocation();
       imagesPressed = false;
       attendancePressed = false;
    });

  }






  bool _validate = false;


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return  WillPopScope (
        onWillPop: () {
      return _moveToSignInScreen(context);
    },
    child: GestureDetector(
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    child:
    SafeArea(
      child:new Scaffold(
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

                          Text('Field Activity Form',style: TextStyle( fontSize: 23,color: Colors.white),),


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
        body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child:  new Center (

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

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Date',
                                          style: TextStyle(fontSize: 16, color: myColor, fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 20.0,),
                                        new Flexible(
                                            child: Container(
                                              width: 230.0,
                                              child:InkWell(
                                                onTap: () async {
                                                  var date =  await showDatePicker(
                                                      context: context,
                                                      initialDate:DateTime.now(),
                                                      firstDate:DateTime(2021),
                                                      lastDate: DateTime(2100)
                                                  );
                                                  dateController.text = date.toString().substring(0,10);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(top: 10),
//                                  width: _width / 1.7,
//                                  height: _height / 9,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(color: Colors.grey[200]),
                                                  child: TextFormField(
                                                    style: TextStyle(fontSize: 25),
                                                    textAlign: TextAlign.center,
                                                    onSaved: (String val) {
                                                      _setDate = val;
                                                    },
                                                    enabled: false,

                                                    keyboardType: TextInputType.text,
                                                    controller: dateController,
                                                    decoration: InputDecoration(
                                                        disabledBorder:
                                                        UnderlineInputBorder(borderSide: BorderSide.none),
                                                        // labelText: 'Time',
                                                        contentPadding: EdgeInsets.all(5)),
                                                  ),
                                                ),
                                              ),
                                            )

                                        ),
                                        SizedBox(width: 20.0,),

                                      ],
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
                                        labelText: 'Activity Name',
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
                                      controller: activitynmController,
                                      onChanged: (value){
                                        setState(() {
                                          _AddFieldActivity.activityName = activitynmController.text;
                                          print(_AddFieldActivity.activityName);
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
                                          _AddFieldActivity.village = villageController.text;
                                          print(_AddFieldActivity.village);
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
                                          _AddFieldActivity.uc = ucController.text;
                                          print(_AddFieldActivity.uc);
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
                                          _AddFieldActivity.taluka = talukaController.text;
                                          print(_AddFieldActivity.taluka);
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
                                          _AddFieldActivity.district = districtController.text;
                                          print(_AddFieldActivity.district);
                                        });
                                      },

                                    ),
                                    SizedBox(height: 10.0,),
                                    Container(
                                      padding: new EdgeInsets.only(top: 10.0,),
                                      alignment: Alignment.topLeft,
                                      child:  Text(
                                        'GPS Coordinates',
                                        style: TextStyle(fontSize: 16, color: myColor,
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
                                        labelText: 'Latitude',
//                                   hintText: "Name Head of Household",
                                        hintStyle: TextStyle(color: Colors.grey),

                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return 'Field is required';
                                        }
                                        if (val.length < 2) {
                                          return 'Field is too short';
                                        }
                                        return null;
                                      },
                                      controller: LatController,
                                      onChanged: (value){
                                        setState(() {
                                          _AddFieldActivity.mapLat = LatController.text;
                                          print(_AddFieldActivity.mapLat);
                                        });
                                      },

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
                                        labelText: 'Longitude',
//                                   hintText: "Name Head of Household",
                                        hintStyle: TextStyle(color: Colors.grey),

                                      ),
                                      keyboardType: TextInputType.number,
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return 'Field is required';
                                        }
                                        if (val.length < 2) {
                                          return 'Field is too short';
                                        }
                                        return null;
                                      },
                                      controller: longController,
                                      onChanged: (value){
                                        setState(() {
                                          _AddFieldActivity.mapLong = longController.text;
                                          print(_AddFieldActivity.mapLong);
                                        });
                                      },

                                    ),
                                    SizedBox(height: 10.0,),
                                    Container(
                                      padding: new EdgeInsets.only(top: 10.0,),
                                      alignment: Alignment.topLeft,
                                      child:  Text(
                                        'Location',
                                        style: TextStyle(fontSize: 16, color: myColor,
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
                                        labelText: 'Activity location',
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
                                      controller: locationController,
                                      onChanged: (value){
                                        setState(() {
                                          _AddFieldActivity.mapLocation = locationController.text;
                                          print(locationController);
                                        });
                                      },

                                    ),
                                    // SizedBox(height: 15.0,),
//                                     Row(
//                                       children:<Widget> [
//                                         Container(
//                                           padding: new EdgeInsets.only(top: 15.0,right: 15.0),
//                                           alignment: Alignment.topLeft,
//                                           child: Text(
//                                             'GPS Coordinate',
//                                             style: new TextStyle(
// //                                     fontWeight: FontWeight.bold,
//                                               color: Colors.grey,
//                                               fontSize: 15.0,
//                                             ),
//                                           ),
//                                         ),
//                                         Container(
// //                                      width: 30.0,
//                                           padding: new EdgeInsets.only(top: 15.0,),
//
//
//                                           child:  Text("Lat: "),
//                                         ),
//                                         Container(
// //                                      width: 30.0,
//                                           padding: new EdgeInsets.only(top: 15.0,),
//
//                                           child:  TextFormField(
// //                      controller: emailController,
//
//                                             style: TextStyle(color: Colors.grey),
//
//                                             decoration: new InputDecoration(
//
//                                               labelStyle: TextStyle(
//                                                   color: Colors.grey
//                                               ),
//                                               errorStyle: TextStyle(
//                                                   color: Colors.red
//                                               ),
//                                               enabledBorder: UnderlineInputBorder(
//                                                 borderSide: BorderSide(color: Colors.black12),
//                                               ),
//                                               focusedBorder: UnderlineInputBorder(
//                                                 borderSide: BorderSide(color: Colors.grey),
//                                               ),
//                                               border: UnderlineInputBorder(
//                                                 borderSide: BorderSide(color: Colors.red),
//                                               ),
// //                        prefixIcon: Icon(Icons.person_outline,color: Colors.white),
//                                               labelText: 'District',
// //                                   hintText: "Name Head of Household",
//                                               hintStyle: TextStyle(color: Colors.grey),
//
//                                             ),
//                                             validator: (val) {
//                                               if (val.isEmpty) {
//                                                 return 'Field is required';
//                                               }
//                                               if (val.length < 2) {
//                                                 return 'Field is too short';
//                                               }
//                                               return null;
//                                             },
//                                             controller: districtController,
//                                             onChanged: (value){
//                                               setState(() {
//                                                 _AddFieldActivity.district = districtController.text;
//                                                 print(_AddFieldActivity.district);
//                                               });
//                                             },
//
//                                           ),
//                                         ),
//                                         SizedBox(width: 10.0,),
//                                         Container(
// //                                      width: 30.0,
//                                           padding: new EdgeInsets.only(top: 15.0,),
//
//                                           child:  Text("Long: "),
//                                         ),
//                                         Container(
// //                                      width: 30.0,
//                                           padding: new EdgeInsets.only(top: 15.0,),
//
//                                           child:  Text(_AddFieldActivity.mapLong ??''),
//                                         ),
//                                       ],
//                                     ),

                                    SizedBox(height: 10.0,),
                                    Row(
                                      children:<Widget> [
                                        Container(
                                          padding: new EdgeInsets.only(top: 10.0,right: 15.0),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'District Officer Name:',
                                            style: new TextStyle(
//                                     fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: new EdgeInsets.only(top: 10.0,),

                                          child:  Text( officer ?? "", style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: themeblue,
                                            fontSize: 16.0,),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children:<Widget> [
                                        Container(
//                                      width:60.0 ,
                                          padding: new EdgeInsets.only(top: 20.0,),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'No. of Participants',
                                            style: new TextStyle(
//                                     fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.0,),

                                        Container(
                                          width: 130.0,

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
                                              LengthLimitingTextInputFormatter(7)

                                            ],
                                            validator: (val) {
                                              if (val.isEmpty) {
                                                return 'Field is required';
                                              }
                                              return null;
                                            },
                                            controller: participantsController,
                                            onChanged: (value){
                                              setState(() {
                                                _AddFieldActivity.countParticipants = int.parse(participantsController.text);
                                                print(_AddFieldActivity.countParticipants);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 15.0,),


                                    Container(


                                      child:  Text(
                                        'Gender',
                                        style: TextStyle(fontSize: 16, color: myColor,
                                        ),
                                      ),
                                    ),

                                    Row(
                                      children:<Widget> [
                                        Container(
                                          width:60.0 ,
                                          padding: new EdgeInsets.only(top: 20.0,),
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
                                          width: 100.0,

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
                                              LengthLimitingTextInputFormatter(5)

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
                                                _AddFieldActivity.male = int.parse(maleController.text);
                                                print(_AddFieldActivity.male);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children:<Widget> [
                                        Container(
                                          width:60.0 ,
                                          padding: new EdgeInsets.only(top: 20.0,),
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
                                          width: 100.0,

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
                                              LengthLimitingTextInputFormatter(5)

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
                                                _AddFieldActivity.female = int.parse(femaleController.text);
                                                print(_AddFieldActivity.female);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.0,),
                                    Container(
                                      child:  Text(
                                        'Concise Activity Details',
                                        style: TextStyle(fontSize: 25, color: myColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.0,),
                                    Container(
                                      margin: EdgeInsets.only(bottom:8.0),
                                      // hack textfield height
                                      child: TextFormField(
                                        maxLines: 15,
                                        decoration: InputDecoration(
                                          hintText: "Details",
                                          border: OutlineInputBorder(),
                                        ),
                                        onSaved: (val) {
                                          _AddFieldActivity.details = val;
                                          print( _AddFieldActivity.details  );
                                        },
                                      ),
                                    ),
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
                                    //     child:Text(_AddFieldActivity.mapLocation ?? "no location" ,style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black),)
                                    //
                                    // ),

                                    SizedBox(height: 10.0,),
                                    Row(
                                      children: [
                                        // Container(
                                        //   child: files.isEmpty
                                        //       ? new Text("Add activity images",style: TextStyle(fontSize: 20.0,color: myColor,),)
                                        //       : new Text("Activity images added",style: TextStyle(fontSize: 20.0,color: Colors.green,)),
                                        // ),
                                        // SizedBox(width: 10.0,),
                                        Container(
                                          child: imagescount.isEmpty
                                              ? new Text("Add activity images",style: TextStyle(fontSize: 20.0,color: myColor,),)
                                              : new Text(imagescount + " Activity image(s) added", style: TextStyle(fontSize: 20.0,color: Colors.green,)),
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: 10.0,),
                                    Container(

                                        child:  Row(

                                          children: <Widget>[
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor: (imagesPressed) ? MaterialStateProperty.all(Colors.red)
                                                  : MaterialStateProperty.all(myColor),
                                              padding: MaterialStateProperty.all(EdgeInsets.only(left: 30.0,right: 30.0,top: 7.0,bottom: 7.0)),
                                              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))),

                                              child: Icon(Icons.image, color: Colors.white,),
                                              onPressed:(){
                                            FocusScope.of(context).requestFocus(FocusNode());
                                            loadAssets();

                                        }
                                            ),
//                                        RaisedButton(
//                                          color: myColor,
//
//                                          child: Icon(Icons.camera_alt,color: Colors.white,),
//                                          onPressed: getImageCamera,
//                                        ),
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
                                    Container(
                                      child: attachimagescount.isEmpty
                                          ? new Text("Add attendance sheet ",style: TextStyle(fontSize: 20.0,color: myColor,),)
                                          : new Text(attachimagescount + " Attendance sheet(s) added",style: TextStyle(fontSize: 20.0,color: Colors.green,)),
                                    ),
                                    SizedBox(height: 10.0,),
                                    Container(

                                        child:  Row(

                                          children: <Widget>[

                                            ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor: (attendancePressed) ? MaterialStateProperty.all(Colors.red)
                                                      : MaterialStateProperty.all(Colors.blue),
                                                  padding: MaterialStateProperty.all(EdgeInsets.only(left: 30.0,right: 30.0,top: 7.0,bottom: 7.0)),
                                                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))),

                                              child: Icon(Icons.image, color: Colors.white,),
                                              onPressed:() {
                                                FocusScope.of(context).requestFocus(FocusNode());
                                                loadAttendance();
                                              },
                                            ),
//                                        RaisedButton(
//                                          color: myColor,
//
//                                          child: Icon(Icons.camera_alt,color: Colors.white,),
//                                          onPressed: getAttndcImageCamera,
//                                        ),
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
                            )
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
                                if (_formKey.currentState.validate() && images.isNotEmpty && attendanceimages.isNotEmpty) {

                                  showLoaderDialog(context);
                                  _submitForm();
                                }
                                else if (images.isEmpty && attendanceimages.isNotEmpty ){

                                  setState(()
                                  {
                                    imagesPressed = true;
                                  });
                                }
                                else if (attendanceimages.isEmpty && images.isNotEmpty  ){

                                  setState(()
                                  {
                                    attendancePressed  = true;
                                  });
                                }
                                else if ( images.isEmpty && attendanceimages.isEmpty  ){

                                  setState(()
                                  {
                                    imagesPressed = true;
                                    attendancePressed  = true;
                                  });
                                }
                              },
//                            {
////                                   Validate returns true if the form is valid, or false
////                                   otherwise.
//                              if (_formKey.currentState.validate()) {
//                                showLoaderDialog(context);
//                                _submitForm();
//
//                              }
//                            },
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
    )
    )
    );
  }

  Future<void> _submitForm() async {
    final FormState form = _formKey.currentState;

//    if (form.validate()) {
//      String a= _fbKey.currentState.value.toString();
//      _formResult.supporterType = a;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _AddFieldActivity.doName = prefs.getString('createdBy');
    _AddFieldActivity.doID = prefs.getString('do_id').toString();
    _AddFieldActivity.date = dateController.text;
//    _AddResult.name = widget.EconomicDetail.name.toString();
    form.save();
//    print(_AddResult.toMap());

//    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenn = ( prefs.getString('token'));
    String token = 'Bearer '+ tokenn;

    final uri = baseURL + 'fieldactivity';
//    _onLoading();
    http.Response response = await http.post(
      Uri.parse(uri), headers: { 'Content-type': 'application/json',
      'Accept': 'application/json', HttpHeaders.authorizationHeader: token },body: (json.encode(_AddFieldActivity.toMap())),
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
    print(_AddFieldActivity.toMap());



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
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => FieldActivityScreen()),
                                    (Route<dynamic> route) => false
                            );

                          },
                          child: Text(
                            "Back to Form",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: myColor // set the background color
                          ),

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

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//    String posi  = position.toString();
    Coordinates coordinates = Coordinates(position.latitude,position.longitude);
    var location = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//    print(location);
    var first = location.first;

    setState(() {
      _AddFieldActivity.mapLat = position.latitude.toString();
      _AddFieldActivity.mapLong = position.longitude.toString();
      _AddFieldActivity.mapLocation = first.addressLine;
    });
    print("${first.addressLine}");

//    print(MapAddress);
  }

//  Future getImageCamera() async{
//    final pickedFile = await picker.getImage(source: ImageSource.camera);
//    File imageFile = new File(pickedFile.path);
////    var videoFile = await ImagePicker.pickImage(source: ImageSource.camera);
//    String fileExt = imageFile.path.split('.').last;
//    List<int> videoBytes = imageFile.readAsBytesSync();
//
////    String basename = basename(imageFile.path);
//    file = base64.encode(videoBytes);
//    files.add(Att(image: file ,extension: fileExt));
//    setState(()  {
////      _video = imageFile;
//      _AddFieldActivity.attachment = files;
//
//    });
//  }

//  Future getAttndcImageCamera() async{
//    final pickedFile = await picker2.getImage(source: ImageSource.camera);
//    File imageFile = new File(pickedFile.path);
////    var videoFile = await ImagePicker.pickImage(source: ImageSource.camera);
//    String fileExt = imageFile.path.split('.').last;
//    List<int> videoBytes = imageFile.readAsBytesSync();
//
////    String basename = basename(imageFile.path);
//    file2 = base64.encode(videoBytes);
//    files.add(Att(image: file2 ,extension: fileExt));
//    setState(()  {
////      _video = imageFile;
//      _AddFieldActivity.attachment = files;
//
//    });
//  }

//  Future getImageGallery() async{
//    final pickedFile = await picker.getImage(source: ImageSource.gallery);
//    File imageFile = new File(pickedFile.path);
////    var videoFile = await ImagePicker.pickImage(source: ImageSource.camera);
//    List<int> videoBytes = imageFile.readAsBytesSync();
//    file = base64.encode(videoBytes);
//    String fi = "jpg,"+ file ;
//    print(fi);
//    setState(()  {
////      _video = imageFile;
//      _AddBtl.attachment = fi;
//
//    });
//  }
  String _timestamp1() => DateTime.now().millisecondsSinceEpoch.toString();
  String _timestamp2() => DateTime.now().millisecondsSinceEpoch.toString();


  Future<void> loadAssets() async {
    // await Permission.camera.request();
    // _AddFieldActivity.images =[];
    files = [];
    imagescount = '';
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
      if(images.isEmpty ) {
        images = resultList;
      }
      else if(images.isNotEmpty){
        images.isEmpty;
        images = resultList;
      }
//      final String _images = resultList.map((e){
//        return e.getByteData().then((value) =>value.toString());
//      }).toList().join(',');

//      attch.insert(0, Attachment(image:images.getByteData.toString(),extension: "abc"));


//      _AddBeneficiary.attachment =_images;
      print(images);

      _error = error;
      showLoaderDialog(context);
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

      for(var i = 0 ; i <images.length; i++)
      {
        final dir = await path_provider.getTemporaryDirectory();
        var path  = await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
        File file = await getImgaeFilefromPath(path);
        String fileExt = file.path.split('.').last;
        final targetpath = dir.absolute.path + "/" + _timestamp1() + ".jpg" ;
        var filecompressed;
        final compressedImage = await FlutterImageCompress.compressAndGetFile(
            file.absolute.path,
            targetpath,
            // minWidth: 240,
            // minHeight: 240,
            quality: 50);

        setState(() {
          filecompressed = compressedImage;
        });

        var base64Image = base64Encode(filecompressed.readAsBytesSync());
        files.add(AttachmentsList(image: base64Image,extension: fileExt));
        print(files.length);
        imagescount = files.length.toString();

      }

      setState(()  {
//      _video = imageFile;
        _AddFieldActivity.images = files;
        imagesPressed = false;

      });
      Navigator.pop(this.context);
    }
  }


  Future<void> loadAttendance() async {

    attdncfiles = [];
    attachimagescount = '';
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 6,
        enableCamera: false,
        selectedAssets: attendanceimages,
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
      attendanceimages = resultList;
      // if(attendanceimages.isEmpty) {
      //   attendanceimages = resultList;
      // }
      // else if (attendanceimages.isNotEmpty){
      //   attendanceimages.isEmpty;
      //   attendanceimages= resultList;
      // }


//      final String _images = resultList.map((e){
//        return e.getByteData().then((value) =>value.toString());
//      }).toList().join(',');

//      attch.insert(0, Attachment(image:images.getByteData.toString(),extension: "abc"));


//      _AddBeneficiary.attachment =_images;
      print(attendanceimages);

      _error = error;
      showLoaderDialog(context);
      _saveimgAttdnc();
    });

  }

  getImgaeFilefromPathAttdnc (String path2) async{
    final filee2 = File(path2);
    return filee2;
  }

  _saveimgAttdnc () async{
    if(attendanceimages != null)
    {
      for(var i = 0 ; i <attendanceimages.length; i++)
      {
        final dir2 = await path_provider.getTemporaryDirectory();
        var path2  = await FlutterAbsolutePath.getAbsolutePath(attendanceimages[i].identifier);
        File file2 = await getImgaeFilefromPathAttdnc(path2);

        String fileExt2 = file2.path.split('.').last;

        final targetpath2 = dir2.absolute.path + "/" + _timestamp2() + ".jpg" ;
        var filecompressed2;
        final compressedImage2 = await FlutterImageCompress.compressAndGetFile(
            file2.absolute.path,
            targetpath2,
            // minWidth: 240,
            // minHeight: 240,
            quality: 70);

        setState(() {
          filecompressed2 = compressedImage2;
        });


        var base64Image2 = base64Encode(filecompressed2.readAsBytesSync());
        attdncfiles.add(AttendanceSheets(image: base64Image2,extension: fileExt2));
        print(attdncfiles.length);
        attachimagescount = attdncfiles.length.toString();

      }

      setState(()  {
//      _video = imageFile;
        _AddFieldActivity.attendanceSheet = attdncfiles ;
        attendancePressed = false;

      });
      Navigator.pop(this.context);
    }
  }

  _moveToSignInScreen(BuildContext context) =>
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Btl_Record_List()),
              (Route<dynamic> route) => false
      );
}


//class MaskedTextInputFormatter extends TextInputFormatter {
//  final String mask;
//  final String separator;
//
//  MaskedTextInputFormatter({
//    @required this.mask,
//    @required this.separator,
//  }) { assert(mask != null); assert (separator != null); }
//
//  @override
//  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
//    if(newValue.text.length > 0) {
//      if(newValue.text.length > oldValue.text.length) {
//        if(newValue.text.length > mask.length) return oldValue;
//        if(newValue.text.length < mask.length && mask[newValue.text.length - 1] == separator) {
//          return TextEditingValue(
//            text: '${oldValue.text}$separator${newValue.text.substring(newValue.text.length-1)}',
//            selection: TextSelection.collapsed(
//              offset: newValue.selection.end + 1,
//            ),
//          );
//        }
//      }
//    }
//    return newValue;
//  }
//}
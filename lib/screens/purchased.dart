
import 'dart:async';
import 'dart:convert';
//import 'dart:html';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:ssepnew/CustomAppBar.dart';
import 'package:ssepnew/models/SurveyModel.dart';
import 'package:ssepnew/screens/btl_records.dart';
import 'package:ssepnew/screens/success_dialog.dart';

import '../themes.dart';



class PurchasedScreen extends StatefulWidget {
//  Survey EconomicDetial;

//  final Survey EconomicDetail;

//   PurchasedScreen({Key key, @required this.EconomicDetail}) : super(key: key);


  @override
  _PurchasedScreen createState() => _PurchasedScreen( );

}

class _PurchasedScreen extends State<PurchasedScreen>  {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  ProgressDialog progressDialog;
  DialogState _dialogState = DialogState.DISMISSED;
  F_DialogState _f_dialogState = F_DialogState.DISMISSED;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  final _formKey = GlobalKey<FormState>();
//  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int LengthValue ;
  int DChoice;
  final _text = TextEditingController();
  final _AddResult = Survey();
  int Value_id;
  File  _video;
  String file;
  String Value_name;
  String userName = '';
  String Latitude ='';
  String Longitude = '';
  String MapAddress = '';




//  Survey economicDetail;
//  _PurchasedScreen(Survey economicDetail);
//  fetchid()async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    //Return int
//    int Value = prefs.getInt('jobId');
//    print(Value);
//    setState(() {
//      Value_id = Value;
//    });
//    return Value_id;
//  }





  @override
  void initState() {
    setState(() {
      fetchname();
      FetchData();
      getLocation();
    });
    super.initState();
  }
  @override
  void dispose(){
    // Additional disposal code
    super.dispose();
  }
  void handleRadioValueChange(int value) {
    print(value);
    setState(() => LengthValue = value);
  }

  fetchname()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    String Value_n = prefs.getString('task_title');
    setState(() {
      Value_name = Value_n;
    });

    return Value_name;
  }
  FetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    setState(() {
      userName = (prefs.getString('user_name') ?? '');
    });
  }

  bool _validate = false;

  @override
  // TODO: implement widget
  PurchasedScreen get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
//    widget.EconomicDetail;
//    ProgressDialog pr = ProgressDialog(context);
//    pr = ProgressDialog(context,type: ProgressDialogType.Normal);

  final Survey economicDetail = ModalRoute.of(context).settings.arguments;
  _AddResult.name = economicDetail.name;
  _AddResult.address = economicDetail.address;
  _AddResult.pn = economicDetail.pn;
  _AddResult.or= economicDetail.or;
  _AddResult.lot = economicDetail.lot;
  _AddResult.rooms = economicDetail.rooms;
  _AddResult.fms = economicDetail.fms;
  _AddResult.nprw = economicDetail.nprw;
  _AddResult.distance = economicDetail.distance;
  _AddResult.occupation = economicDetail.occupation;
  _AddResult.gi = economicDetail.gi;
  _AddResult.expenditures = economicDetail.expenditures;
  _AddResult.farmSize = economicDetail.farmSize;
  _AddResult.map_location = MapAddress;
  _AddResult.map_lat = Latitude;
  _AddResult.map_long = Longitude;

    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(   height: 200,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                  height: 100.0,
                  padding: const EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0,bottom: 8.0,),



                  child: Row(
                      children: [

                        Text('Activity Name: ',style: TextStyle( fontSize: 17,color: Colors.white),),
                        Container(
                          constraints: BoxConstraints(minWidth: 20, maxWidth: 200),
                          child:  AutoSizeText(
                            Value_name ?? '',
                            style: TextStyle(fontSize: 17,color: Colors.white),
                            minFontSize: 18,
                            maxLines: 2,

                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        Spacer(),
                        Container(
                            child: Row(
                              children: <Widget>[
                                Text('You are Logged in as : ',style: TextStyle( fontSize: 17,color: Colors.white),),
                                Container(
                                  constraints: BoxConstraints(minWidth: 20, maxWidth: 200),
                                  child:  AutoSizeText(

                                    userName ,
                                    style: TextStyle(fontSize: 17,color: Colors.white),
                                    minFontSize: 18,
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
                  height: 100.0,
                  padding: const EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0,bottom: 8.0,),
                  color: Colors.black54,



                  child: Row(
                      children: [

                        Text('BTL Surveys Activity : ',style: TextStyle( fontSize: 30,color: Colors.white),),
                        Container(
                          constraints: BoxConstraints(minWidth: 20, maxWidth: 250),
//                      child:  AutoSizeText(
//                        Doctor??'',
//                        style: TextStyle(fontSize: 20,color: Colors.white),
//                        minFontSize: 18,
//                        maxLines: 2,
//
//                        overflow: TextOverflow.ellipsis,
//                      ),
                        ),

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
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(

                    height:70,
                    width: double.infinity,
                    child: Center(
                      child:  Text(
                        'For purchased electricity',
                        style: TextStyle(fontSize: 25, color: myColor,
                        ),
                      ),
                    ),


                  ),

                  const Divider(
                    color: Colors.black,
                    height: 1,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20.0,right: 10.0),

//            height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width ,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: new EdgeInsets.only(top: 20.0,),

                            child:  Text(
                              'Average bill and kWh',
                              style: TextStyle(fontSize: 20, color: myColor,
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(

                                  children: <Widget>[
                                    Container(
//                                  width: 200,
                                      padding: const EdgeInsets.only(right: 85.0),

                                      child:  TextFormField(
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
                                          labelText: 'Amount',
//                                   hintText: "Name Head of Household",
                                          hintStyle: TextStyle(color: Colors.grey),

                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter.digitsOnly
                                        ],
                                        ///working
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return 'Field is required';
                                          }
                                          if (val.length < 2) {
                                            return 'Field is too short';
                                          }
                                          return null;
                                        },
                                        onSaved: (val) {
                                          _AddResult.amount = val;
                                          print(_AddResult.amount);
                                        },
                                      ),
                                    )

                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.only(right: 85.0),

                                      child: TextFormField(
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
                                          labelText: 'Price per Kwh',
                                          hintStyle: TextStyle(color: Colors.grey),

                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          WhitelistingTextInputFormatter.digitsOnly
                                        ],
                                        onSaved: (val) {
                                          _AddResult.priceKwh = val;
                                          print(_AddResult.priceKwh);
                                        },
                                      ),

                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                          Container(
                            width: 300.0,

                            child:   TextFormField(
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
                                labelText: 'Peak hours',
//                             hintText: "1",
                                hintStyle: TextStyle(color: Colors.grey),

                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              onSaved: (val) {
                                _AddResult.peakHours = val;
                                print(_AddResult.peakHours);
                              },
                            ),
                          ),
                          Container(
                            width: 300.0,

                            child:   TextFormField(
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
                                labelText: 'Reliability of supply',
//                             hintText: "1",
                                hintStyle: TextStyle(color: Colors.grey),

                              ),
                              onSaved: (val) {
                                _AddResult.reliability = val;
                                print(_AddResult.reliability);
                              },
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.only(top: 30.0),
                            child:  Text(
                              'Appliance Stock',
                              style: TextStyle(fontSize: 20, color: myColor,
                              ),
                            ),
                          ),

                          Row(
                            children: <Widget>[
                              Expanded(
                                child:  Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(

                                        children: <Widget>[
                                          Container(
//                                  width: 200,
                                            padding: const EdgeInsets.only(right: 85.0),

                                            child:  TextFormField(
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
                                                labelText: 'Fan',
//                                   hintText: "Name Head of Household",
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.fan = val;
                                                print(_AddResult.fan);
                                              },
                                            ),
                                          ),
                                          Container(
//                                  width: 200,
                                            padding: const EdgeInsets.only(right: 85.0),

                                            child:  TextFormField(
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
                                                labelText: 'AC',
//                                   hintText: "Name Head of Household",
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.ac = val;
                                                print(_AddResult.ac);
                                              },
                                            ),
                                          ),
                                          Container(
//                                  width: 200,
                                            padding: const EdgeInsets.only(right: 85.0),

                                            child:  TextFormField(
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
                                                labelText: 'Computers',
//                                   hintText: "Name Head of Household",
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.computers = val;
                                                print(_AddResult.computers);
                                              },
                                            ),
                                          ),
                                          Container(
//                                  width: 200,
                                            padding: const EdgeInsets.only(right: 85.0),

                                            child:  TextFormField(
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
                                                labelText: 'Refrigerator',
//                                   hintText: "Name Head of Household",
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.refrigerator = val;
                                                print(_AddResult.refrigerator);
                                              },
                                            ),
                                          ),
                                          Container(
//                                  width: 200,
                                            padding: const EdgeInsets.only(right: 85.0),

                                            child:  TextFormField(
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
                                                labelText: 'Energy Savers',
//                                   hintText: "Name Head of Household",
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.savers = val;
                                                print(_AddResult.savers);
                                              },
                                            ),
                                          ),
                                          Container(
//                                  width: 200,
                                            padding: const EdgeInsets.only(right: 55.0),

                                            child:  TextFormField(
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
                                                labelText: 'Washing Machine',
//                                   hintText: "Name Head of Household",
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.machine = val;
                                                print(_AddResult.machine);
                                              },
                                            ),
                                          ),
                                          Container(
//                                  width: 200,
                                            padding: const EdgeInsets.only(right: 85.0),

                                            child:  TextFormField(
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
                                                  borderSide: BorderSide(color: Colors.black12
                                                  ),
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.grey),
                                                ),
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.red),
                                                ),
//                        prefixIcon: Icon(Icons.person_outline,color: Colors.white),
                                                labelText: 'TV',
//                                   hintText: "Name Head of Household",
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.tv = val;
                                                print(_AddResult.tv);
                                              },
                                            ),
                                          ),
                                          Container(
//                                  width: 200,
                                            padding: const EdgeInsets.only(right: 85.0),

                                            child:  TextFormField(
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
                                                labelText: 'Other',
//                                   hintText: "Name Head of Household",
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.other = val;
                                                print(_AddResult.other);
                                              },
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.only(right: 35.0),

                                            child: TextFormField(
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
                                                labelText: 'Hours used per day',
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.fanHours = val;
                                                print(_AddResult.fanHours);
                                              },
                                            ),

                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(right: 35.0),

                                            child: TextFormField(
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
                                                labelText: 'Hours used per day',
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.acHours = val;
                                                print(_AddResult.acHours);
                                              },
                                            ),

                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(right: 35.0),

                                            child: TextFormField(
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
                                                labelText: 'Hours used per day',
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.computerHours = val;
                                                print(_AddResult.computerHours);
                                              },
                                            ),

                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(right: 35.0),

                                            child: TextFormField(
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
                                                labelText: 'Hours used per day',
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.refrigeratorHours = val;
                                                print(_AddResult.refrigeratorHours);
                                              },
                                            ),

                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(right: 35.0),

                                            child: TextFormField(
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
                                                labelText: 'Hours used per day',
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.saverHours = val;
                                                print(_AddResult.saverHours);
                                              },
                                            ),

                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(right: 35.0),

                                            child: TextFormField(
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
                                                labelText: 'Hours used per day',
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.machineHours = val;
                                                print(_AddResult.machineHours);
                                              },
                                            ),

                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(right: 35.0),

                                            child: TextFormField(
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
                                                labelText: 'Hours used per day',
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.tvHours = val;
                                                print(_AddResult.tvHours);
                                              },
                                            ),

                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(right: 35.0),

                                            child: TextFormField(
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
                                                labelText: 'Hours used per day',
                                                hintStyle: TextStyle(color: Colors.grey),

                                              ),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                WhitelistingTextInputFormatter.digitsOnly
                                              ],
                                              onSaved: (val) {
                                                _AddResult.otherHours = val;
                                                print(_AddResult.otherHours);
                                              },
                                            ),

                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        child:Column(
                                          children: [
                                            Container(
                                               alignment: Alignment.centerLeft,
                                                  child:Text('Location',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue))

                                            ),
                                            SizedBox(height: 15.0,),
                                            Container(
                                                child:Text(_AddResult.map_location ?? "no location" ,style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black),)

                                            )
                                          ],
                                        )
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left:8.0,right:8.0,bottom:8.0),
                                      // hack textfield height
                                      padding: EdgeInsets.only(bottom: 20.0,top: 0.0),
                                      child: TextFormField(
                                        maxLines: 15,
                                        decoration: InputDecoration(
                                          hintText: "Feedback",
                                          border: OutlineInputBorder(),
                                        ),
                                        onSaved: (val) {
                                          _AddResult.feedback = val;
                                          print(_AddResult.feedback);
                                        },
                                      ),
                                    ),


                                    Container(
                                      margin: EdgeInsets.only(left:8.0,),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: <Widget>[
                                          Container(
                                            child: file ==null
                                                ? new Text("No attachment!")
                                                : new Text("Uploaded attachment"),
                                          ),
                                          Container(

                                            child:  Row(

                                              children: <Widget>[
                                                RaisedButton(
                                               color: myColor,
                                                child: Icon(Icons.image, color: Colors.white,),
                                                  // onPressed: getImageGallery,
                                                ),
                                                RaisedButton(
                                                    color: myColor,

                                                  child: Icon(Icons.camera_alt,color: Colors.white,),
                                                  // onPressed: getImageCamera,
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

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),


                          Align(
                            child: SizedBox(
//                              width: 600,
                              child: ElevatedButton(

                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(45, 87, 163, 1),
//                            onPrimary: Color.fromRGBO(32, 87, 163, 1),


                                  ),
                                  onPressed: () {
//                                   Validate returns true if the form is valid, or false
//                                   otherwise.
                                    if (_formKey.currentState.validate()) {
                                      showLoaderDialog(context);
                                      _submitForm();

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
                         SizedBox(height: 20.0,)





//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 16.0),
//                         child: RaisedButton(
//                           onPressed: () {
//                             setState(() {
//                               _text.text.isEmpty ? _validate = true : _validate = false;
//                             });
//
//// Validate returns true if the form is valid, or false
//// otherwise.
//
////                          if (_formKey.currentState.validate()) {
////                            Scaffold.of(context)
////                                .showSnackBar(SnackBar(content: Text('Processing Data')));
////                          }
//                           },
//                           child: Text('Submit'),
  //                         ),
//                       ),


                        ],
                      ),

                    ),

                  )
                ],
              ),
            ),
//            MyDialog(
//              state: _dialogState,
//            ),
//            FailureDialog(
//              state: _f_dialogState,
//            )

          ],
        ),
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
    _AddResult.userId = u_id.toString();
    int jbId = prefs.getInt('jobId');
    _AddResult.job_id= jbId.toString() ;
    int disId = prefs.getInt('districtID');
    _AddResult.district_id=disId.toString();
    print(_AddResult.userId.toString());
//    _AddResult.Maplocation = MapAddress;
//    print(_AddResult.Maplocation);


//    _AddResult.name = widget.EconomicDetail.name.toString();
    form.save();
//    print(_AddResult.toMap());

//    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenn = ( prefs.getString('token'));
    String token = 'Bearer '+ tokenn;

    final uri = 'https://backend.dev-ssep.tk/api/survey';
//    _onLoading();
    http.Response response = await http.post(
        Uri.parse(uri), headers: { 'Content-type': 'application/json',
      'Accept': 'application/json', HttpHeaders.authorizationHeader: token },body: (json.encode(_AddResult.toMap())),
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
    print(_AddResult.toMap());



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
                            MaterialPageRoute(builder: (context) => Btl_Record_List()),
                                  (Route<dynamic> route) => false
                          );

                        },
                        child: Text(
                          "Back to BTL records",
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

//   Future getImageGallery() async{
// //    var imageFile = await ImagePicker.pickVideo(source: ImageSource.gallery);
//     File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery,);
//     List<int> imageBytes = imageFile.readAsBytesSync();
//     file = base64.encode(imageBytes);
//     String fi = "jpg,"+ file;
//
//     setState(() {
// //      _video = imageFile;
//       _AddResult.attachment= fi;
//     });
//   }

//   Future getImageCamera() async{
//     var videoFile = await ImagePicker.pickImage(source: ImageSource.camera);
//     List<int> videoBytes = videoFile.readAsBytesSync();
//     file = base64.encode(videoBytes);
//     String fi = "jpg,"+file;
//
//     setState(()  {
// //      _video = imageFile;
//       _AddResult.attachment= fi;
//     });
//   }
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {},
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future uploadVideo(File videoFile) async{
//    var uri = Uri.parse("http://192.168.1.1/ABC/uploadVideo.php");
    var uri = Uri.parse("https://orangeroomdigital.com/sscp/public/api/survey",);

    var request = new MultipartRequest("POST", uri);

    var multipartFile = await MultipartFile.fromPath("File:", videoFile.path);
    request.files.add(multipartFile);
    StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    if(response.statusCode==200){
      print("Video uploaded");
    }else{
      print("Video upload failed");
    }
  }

//  void onTakePictureButtonPressed() {
//    takePicture().then((String filePath) {
//      if (mounted) {
//        setState(() {
//          imagePath = filePath;
//          videoController?.dispose();
//          videoController = null;
//        });
//
//        // initiate file upload
//        Upload(File(filePath));
//
//        if (filePath != null) showInSnackBar('Picture saved to $filePath');
//      }
//    });
//  }

  upload(File imageFile) async {
    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("http://ip:8082/composer/predict");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
   getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//    String posi  = position.toString();
    Coordinates coordinates = Coordinates(position.latitude,position.longitude);
    var location = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//    print(location);
    var first = location.first;

//    MapAddress = first.addressLine;
    setState(() {
      Latitude = position.latitude.toString();
      Longitude = position.longitude.toString();
      MapAddress=first.addressLine;

    });
//    print("${first.addressLine}");
   print(MapAddress);
  }
}
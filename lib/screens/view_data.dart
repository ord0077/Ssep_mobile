import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssepnew/CustomAppBar.dart';
import 'package:ssepnew/models/BtlModel.dart';
import 'package:ssepnew/models/viewDataModel.dart';
import 'package:ssepnew/screens/btl_records.dart';
import 'package:ssepnew/themes.dart';


class SingleJobRecord extends StatefulWidget {

//  final List<Survey> EconomicDetail;

//  const EconomicScreen({Key key, @required this.EconomicDetail}) : super(key: key);


  @override
  _SingleJobRecord createState() => _SingleJobRecord();
}

class _SingleJobRecord extends State<SingleJobRecord> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String Value_name;
  String userName = '';
  Future<SurveyRecordModel> SurveyRecord;
//  SurveyRecordModel survey;
//
//  _SingleJobRecord(this.survey);
  var survey  = SurveyRecordModel();
  List family;




  @override
  void initState() {
    setState(() {
      getData();
      fetchname();
      FetchData();
      SurveyRecord = getData();

    });
    super.initState();
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
  Future<SurveyRecordModel> getData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenn = ( prefs.getString('token'));
    int job_id = ( prefs.getInt('jobId'));


    String token = 'Bearer '+ tokenn;
//    final apiUrl = 'https://orangeroomdigital.com/sscp/public/api/btl_records';
    final apiUrl ='https://backend.dev-ssep.tk/api/survey_by_job/'+ job_id.toString();


    var result = await http.get(
      Uri.parse(apiUrl), headers: { 'Content-type': 'application/json',
      'Accept': 'application/json',HttpHeaders.authorizationHeader: token},);
    var response = json.decode(result.body);

setState(() {
  family = response["fms"];

});
    print (family[0]["gender"]);
//    List<Fm> records = [];
//    records = response['fms'];
    List<District> dis = [];

//    print("${_btlModel.data[0].taskTitle}");
    return SurveyRecordModel.fromMap(response) ;

  }


  @override
  Widget build(BuildContext context) {
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

                                    userName?? '' ,
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

                        ),




                      ]
                  )
              ),

            ],
          )
      ),
      ///working on scrolling
      body: Container(
        child: FutureBuilder<SurveyRecordModel>(

          future: SurveyRecord,
          builder: (BuildContext context, AsyncSnapshot  snapshot) {

            if( snapshot.connectionState == ConnectionState.waiting)
              return Center(
                  child:SpinKitFadingCircle(
                    color: myColor,
                    size: 70.0,)

              );
            else if(snapshot.hasError){
              return Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[
                        Text("Problem in fetching data ..!",  style: TextStyle(height: 2, fontSize:20),),
                        Text("Try again later",  style: TextStyle(height: 2, fontSize: 20),),

                      ],
                    ),
                  )
              );
            }
            else {
              if (snapshot.hasData) {
                survey  = snapshot.data;
//              final f = new DateFormat('yyyy-MM-dd');

//              print(_p_address(snapshot.data[0]));
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(

                        height:70,
                        width: double.infinity,
                        child: Center(
                          child:  Text(
                            'Survey Detail',
                            style: TextStyle(fontSize: 25, color: myColor,fontWeight: FontWeight.w500,
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
                          autovalidate: false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: new EdgeInsets.only(top: 20.0,),

                                child:  Text(
                                  'Household : ',
                                  style: TextStyle(fontSize: 20, color: myColor,
                                  ),
                                ),
                              ),
                              Divider(
                                  color: Colors.black
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Name Head of Household",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),


                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.name ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        )


                                      ],
                                    ),
                                  ),

                                ],
                              ),

                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Address",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.address ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        )


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Phone number",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.pn?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        )


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Dwelling owned or rented",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.or?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        )


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Length of time in dwelling",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.lot?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        )


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Number of rooms",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.rooms?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        )


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 30.0),
                                child:  Text(
                                  'Attachment',
                                  style: TextStyle(fontSize: 20, color: myColor,
                                  ),
                                ),
                              ),
                              Divider(
                                  color: Colors.black
                              ),
                              Row(
                                children: <Widget>[

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 0.0),
                                            height: 300.0,
                                            width: 300.0,
                                            child: Image.network(snapshot.data.attachment ?? ''),
//                                            child: Text(snapshot.data.attachment,style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),



                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 20.0),
                                child:  Text(
                                  'Composition of household',
                                  style: TextStyle(fontSize: 20, color: myColor,
                                  ),
                                ),
                              ),
                              Divider(
                                  color: Colors.black
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Family",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),

                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        ConstrainedBox(
//                                          margin: const EdgeInsets.only( right: 20.0),
//                                          height: 100.0,
                                          constraints: BoxConstraints(maxHeight: 200, minHeight: 56.0),

                                          child:new ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,

                                            itemCount: family== null? 0 :family.length,
                                            itemBuilder: _itemBuilder,
                                          ),
                                        ),



                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Divider(
                                  color: Colors.black
                              ),
                              Row(
                                children: <Widget>[

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Read Write",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.nprw ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        )


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Distance",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.distance ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        )


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Occupation",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.occupation ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        )


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Growth Income",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.gi ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        )


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Expenditures",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.expenditures ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        )


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 20.0),
                                child:  Text(
                                  'For farm households',
                                  style: TextStyle(fontSize: 20, color: myColor,
                                  ),
                                ),
                              ),
                              Divider(
                                  color: Colors.black
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Farm Size",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.farmSize ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Container(
                                padding: new EdgeInsets.only(top: 20.0,),

                                child:  Text(
                                  'Average bill and kWh',
                                  style: TextStyle(fontSize: 20, color: myColor,
                                  ),
                                ),
                              ),
                              Divider(
                                  color: Colors.black
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Amount",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.amount ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Price kwh",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.priceKwh ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Peak Hours",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.peakHours ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Reliability",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.reliability ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 30.0),
                                child:  Text(
                                  'Appliance Stock',
                                  style: TextStyle(fontSize: 20, color: myColor,
                                  ),
                                ),
                              ),
                              Divider(
                                  color: Colors.black
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Appliances",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child: Text("Quantity",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child: Text("Hours used per day",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                        ),

                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Fan",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.fan ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.fanHours ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("AC",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.ac ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.acHours ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Computers",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.computers ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.computerHours ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Refrigerator",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.refrigerator ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.refrigeratorHours ?? '' ),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Savers",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.savers ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.saverHours ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Machine",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.machine ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.machineHours ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("TV",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.tv ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.tvHours ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Other",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.other ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.otherHours ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 30.0),
                                child:  Text(
                                  'Feedback',
                                  style: TextStyle(fontSize: 20, color: myColor,
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Divider(
                                            color: Colors.black
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text(snapshot.data.feedback ?? 'Empty',style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,
                                              maxLines: 5,),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),




                                ],
                              ),
                              Container(
                                padding: new EdgeInsets.only(top: 20.0,),

                                child:  Text(
                                  'Location',
                                  style: TextStyle(fontSize: 20, color: myColor,
                                  ),
                                ),
                              ),
                              Divider(
                                  color: Colors.black
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Latitude",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.map_lat ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Longitude",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.map_long ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            margin: const EdgeInsets.only( left: 20.0),

                                            child: Text("Map Location",style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),

                                        ),
                                        Divider(
                                            color: Colors.black
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          margin: const EdgeInsets.only( right: 20.0),

                                          child:Text(snapshot.data.map_location ?? ''),
                                        ),
                                        Divider(
                                            color: Colors.black
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),


                              Center(
                                child:  InkWell(
                                  child:   Container(
                                      margin: const EdgeInsets.only(top: 60.0,bottom: 40.0),

                                      height: 50,
                                      width: 230,
//                             padding: EdgeInsets.all(12.0),

//                             padding: const EdgeInsets.symmetric(vertical: 16.0),///

//                           padding: EdgeInsets.fromLTRB(200, 0, 200, 0),
//                           margin: EdgeInsets.only(top: 230.0),
                                      child: RaisedButton(

                                        textColor: Colors.white,
                                        color: myColor,
                                        child: Text('Back'),
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(builder: (context) => Btl_Record_List()),
                                                  (Route<dynamic> route) => false
                                          );


//                                    _scaffoldKey.currentState.showSnackBar(new SnackBar(content:Row(
//                                      children: <Widget>[
//                                        new CircularProgressIndicator(),
//                                        new Text("  Signing-In...")
//                                      ],
//                                    ), ));


//                                    uploadVideo(_video);
//                             _submit();
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) =>  SelectOption ()),
//                             );


//                        signIn(nameController.text,passwordController.text);
//                          print(nameController.text);
//                          print(passwordController.text);
                                        },
                                      )

                                  ),

                                ),
                              ),



                            ],
                          ),

                        ),

                      )
                    ],
                  ),
                );
              }

              else {
                return Center(child: SpinKitFadingCircle(
                  color: myColor,
                  size: 70.0,)
                );
              }
            }
          },
        ),
      ),

        );

  }
Widget _itemBuilder(BuildContext context, int index ){
    return Card(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center ,//Center Row contents vertically,
          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,

          children: <Widget>[
          Text( family[index]['gender'] ?? ''),
          Text(" age of "),
          Text(family[index]['age'] ?? ''),
        ],
      )
    );
}

}
class VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 30.0,
      width: 1.0,
      color: Colors.white30,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}
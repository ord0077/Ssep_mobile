
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'package:ssepnew/CustomAppBar.dart';
import 'file:///C:/Users/user/AndroidStudioProjects/ssep_new/lib/screens/LoginScreen.dart';
import 'package:ssepnew/consts.dart';
import 'package:ssepnew/dbHelper/dbHelperClass.dart';
import 'package:ssepnew/models/BtlModel.dart';
import 'package:ssepnew/screens/beneficiary_form.dart';
import 'package:ssepnew/screens/btl_activity.dart';
//import 'package:ssepnew/dbHelper/dbHelperClass.dart';
import 'package:ssepnew/screens/economic.dart';
import 'package:ssepnew/screens/field_activity.dart';
import 'package:ssepnew/screens/view_data.dart';
import 'package:ssepnew/themes.dart';

//class DBProvider {
//  DBProvider._();
//  static final DBProvider db = DBProvider._();
//}


class Btl_Record_List extends StatefulWidget {

//  final List<Survey> EconomicDetail;

//  const EconomicScreen({Key key, @required this.EconomicDetail}) : super(key: key);


  @override
  _EconomicScreen createState() => _EconomicScreen();
}

class _EconomicScreen extends State<Btl_Record_List> {
  List data;
  Datum _datum;
  Future<List<Datum>> _datumlList;
  String userName = '';
  String St = "";
  String St2 = "";
  var dbHelper;
  bool isUpdating;

  @override
  void initState(){
//    this.getData();
    FetchData();
    _datumlList = getData();
    dbHelper = DBHelper();
    isUpdating = false;
  }


//  static Database _database;
//
//  Future<Database> get database async {
//    if (_database != null)
//      return _database;
//
//    // if _database is null we instantiate it
//    _database = await initDB();
//    return _database;
//  }
//  ///
//  initDB() async {
//    Directory documentsDirectory = await getApplicationDocumentsDirectory();
//    String path = join(documentsDirectory.path, "TestDB.db");
//    return await openDatabase(path, version: 1, onOpen: (db) {
//    }, onCreate: (Database db, int version) async {
//      await db.execute("CREATE TABLE Client ("
//          "id INTEGER PRIMARY KEY,"
//          "name TEXT,"
//          "district TEXT,"
//          "status TEXT"
//          ")");
//    });
//  }


  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();


  Future<List<Datum>> getData() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenn = ( prefs.getString('token'));
    int id = (prefs.getInt(('user_id')));

    String token = 'Bearer '+ tokenn;
//    final apiUrl = 'https://orangeroomdigital.com/sscp/public/api/btl_records';
    final apiUrl ='https://backend.dev-ssep.tk/api/btl_records/'+ id.toString();
    List<Datum> records = [];

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        var result = await http.get(
          apiUrl, headers: { 'Content-type': 'application/json',
          'Accept': 'application/json',HttpHeaders.authorizationHeader: token},);


        var response = json.decode(result.body)['data'];
//        print(response);
//        List<Datum> data = [];
//        data= response;
//        dbHelper.save(data);
        List<District> dis = [];


        for (var u in response) {
          Datum Item = Datum( id: u['id'],taskTitle: u['task_title'],district: District(district: u['district']['district']) ,status: Status(status: u['status']['status']), statusId: u['status_id'], districtId: u['district_id'], createdByUser: User(name: u['created_by_user']['name']));

          records.add(Item);
//          List<Datum> data = [];
//          data= records;
//          dbHelper.save(Item);
        print(records);
//      dis.add(d);

        }

        print("DbData");

//        dbHelper.save(records);

        print("DbData");

      }
    } on SocketException catch (_) {

      print('not connected');
    }
//    print("${_btlModel.data[0].taskTitle}");
      return records ;



//    var result = await http.get(
//        Uri.encodeFull("https://orangeroomdigital.com/sscp/public/api/job"),
//        headers: {
//          "Accept": "application/json"
//        });
//    Map<String, dynamic> map = json.decode(response.body);
//    List<dynamic> data = map["data"];
//
//    this.setState(() {
//      data = data;
//    });
//
//    print(data[1]["status"]["status"]);
//
//    return "Success!";
  }

  FetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    setState(() {
      userName = (prefs.getString('user_name') ?? '');
    });
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: Text('Are you sure ?'),
        content: Text('You want to Logout ?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              print("you choose no");
              Navigator.of(context).pop(false);
            },
            child: Text('No',style: TextStyle( fontSize: 17,color: myColor), ),
          ),
          FlatButton(
            onPressed: () async {
//              SystemChannels.platform.invokeMethod('SystemNavigator.pop');

              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove(userKey);
              await Future.delayed(Duration(seconds: 1));

              Navigator.of(context).pushAndRemoveUntil(
                // the new route
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen(),
                  ),

                  // this function should return true when we're done removing routes
                  // but because we want to remove all other screens, we make it
                  // always return false
                      (Route<dynamic> route) => false
              );
            },
            child: Text('Yes', style: TextStyle( fontSize: 17,color:myColor)),
          ),
        ],
      ),
    ) ??
        false;
  }
  DateTime backbuttonpressedTime;

//  Future<bool> onWillPop() async {
//    DateTime currentTime = DateTime.now();
//    //Statement 1 Or statement2
//    bool backButton = backbuttonpressedTime == null ||
//        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);
//    if (backButton) {
//      backbuttonpressedTime = currentTime;
//      Fluttertoast.showToast(
//          msg: "Double Click to exit app",
//          backgroundColor: Colors.black,
//          textColor: Colors.white);
//      return false;
//    }
//    return true;
//  }



//  Future<bool> _onBackPressed() {
//    return showDialog(
//      context: context,
//      builder: (context) => new AlertDialog(
//        title: new Text('Are you sure?'),
//        content: new Text('Do you want to exit an App'),
//        actions: <Widget>[
//          new GestureDetector(
//            onTap: () => Navigator.of(context).pop(false),
//            child: Text("NO"),
//          ),
//          SizedBox(height: 16),
//          new GestureDetector(
//            onTap: () =>  Navigator.pop(context)
//            ,
//            child: Text("YES"),
//          ),
//        ],
//      ),
//    ) ??
//        false;
//  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
//      appBar: new AppBar( centerTitle: true,
//          title: new Text("BTL Records"), backgroundColor: Color.fromRGBO(0, 150, 136, 1),
//          leading: new Container(),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.exit_to_app,
//              color: Colors.white,
//              size: 35.0,
//            ),
//            onPressed: () {
//              // do something
//              _exitApp(context);
//            },
//          )
//        ],
//
//
//      ),
      appBar: CustomAppBar(   height: 200,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(
                  height: 100.0,
                  padding: const EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0,bottom: 8.0,),



                  child: Row(
                      children: [

                        Text('',style: TextStyle( fontSize: 17,color: Colors.white),),

                        Spacer(),
                        Container(
                            child: Row(
                              children: <Widget>[
                                Text('Logged in user : ',style: TextStyle( fontSize: 17,color: Colors.white),),
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
                                ),
                                Container(
                                  child:IconButton(
                                    icon: Icon(
                                      Icons.exit_to_app,
                                      color: Colors.white,
                                      size: 35.0,
                                    ),
                                    onPressed: () {
                                      // do something
                                      _exitApp(context);
                                    },
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

                        Text('BTL Records : ',style: TextStyle( fontSize: 30,color: Colors.white),),
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

                        Spacer(),
                        Container(
                            child:  RaisedButton(
                              child: Text("REFRESH"),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  _datumlList =
                                      getData();                            });
                              },
                            )
                        ),


                      ]
                  )
              ),

            ],
          )

      ),

      body: Container(
//        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width ,
//          color: Color.fromRGBO(246,246,246, 1),
        child: FutureBuilder<List<Datum>>(

          future: _datumlList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
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
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                List<Datum> data = snapshot.data;
//              final f = new DateFormat('yyyy-MM-dd');

//              print(_p_address(snapshot.data[0]));
                return Row( // a dirty trick to make the DataTable fit width
                    children: <Widget>[
                      Expanded(
                        child:ListView(
                    children: [
                      SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                                dividerColor: myColor),
                            child: DataTable(
                              sortColumnIndex: 0,
                              showCheckboxColumn: false,
                              columnSpacing: 10,

                              horizontalMargin: 10,
//                                dataRowHeight: 100.0,
                              headingRowColor: MaterialStateColor.resolveWith((states) { return myColor;}),
                              columns: [
//                                  DataColumn(
//
//                                      label: Text("ID", style: TextStyle(
//                                          fontWeight: FontWeight.bold,
//                                          fontSize: 19),),
//                                      numeric: false,
//                                      tooltip: "Next"
//                                  ),
                                DataColumn(
                                    label: Text("Name", style: TextStyle(
                                      fontWeight: FontWeight.bold,color: Colors.white,
                                      fontSize: 14,),),
                                    numeric: false,
                                    tooltip: "Next"
                                ),
                                DataColumn(
                                    label: Text("District", style: TextStyle(
                                        fontWeight: FontWeight.bold,color: Colors.white,
                                        fontSize: 14),),
                                    numeric: false,
                                    tooltip: "Next"
                                ),
                                DataColumn(
                                  label: Text("Status", style: TextStyle(
                                      fontWeight: FontWeight.bold,color: Colors.white,
                                      fontSize: 14),),
                                  numeric: false,
                                  tooltip: "Previous",
                                ),
                                DataColumn(
                                  label: Text("Call center", style: TextStyle(
                                      fontWeight: FontWeight.bold,color: Colors.white,
                                      fontSize: 14),),
                                  numeric: false,
                                  tooltip: "Previous",
                                ),
                                DataColumn(
                                  label: Text("Beneficiary form", style: TextStyle(
                                      fontWeight: FontWeight.bold,color: Colors.white,
                                      fontSize:  14),),
                                  numeric: false,
                                  tooltip: "Previous",
                                ),
                                DataColumn(
                                  label: Text("Field activity", style: TextStyle(
                                      fontWeight: FontWeight.bold,color: Colors.white,
                                      fontSize:  14),),
                                  numeric: false,
                                  tooltip: "Previous",
                                ),
                              ],
                              rows: data
                                  .map(
                                    (sale) =>

                                    DataRow(
//                                          onSelectChanged: (
//                                              bool selected) async {
//
//
//                                            if (selected && sale.statusId == 1 || sale.statusId == 2 || sale.statusId == 3 || sale.statusId == 6 || sale.statusId == 9) {
//
//                                              SharedPreferences prefs = await SharedPreferences
//                                                  .getInstance();
//                                              prefs.setInt('jobId', sale.id);
//                                              prefs.setString(
//                                                  'task_title', sale.taskTitle);
//                                              prefs.setInt('districtID',
//                                                  sale.districtId);
//
//                                              Navigator.push(
//                                                  context, MaterialPageRoute(
//                                                  builder: (context) => EconomicScreen()));
//                                            }
//                                            else if( selected && sale.statusId == 7)
//                                            {
//                                              SharedPreferences prefs = await SharedPreferences
//                                                  .getInstance();
//                                              prefs.setInt('jobId', sale.id);
//                                              prefs.setString(
//                                                  'task_title', sale.taskTitle);
//                                              prefs.setInt('districtID',
//                                                  sale.districtId);
//                                              Navigator.push(
//                                                  context, MaterialPageRoute(
//                                                  builder: (context) =>
//                                                      SingleJobRecord()));
//                                            }
//                                          },


                                        cells: [

//                                            DataCell(
//                                              Text(sale.id.toString(), style: TextStyle(
//
//                                                  fontSize: 15),),
//
//                                            ),
                                          DataCell(
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxWidth: 150.0,
                                                  minWidth: 30.0
                                              ),
                                              child:
                                              Container(
//                                                  width: 100.0,,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Container(

                                                        child: Flexible(
                                                          child: Text(sale.taskTitle, maxLines:3,softWrap: false,overflow: TextOverflow.ellipsis,style: TextStyle(

                                                              fontSize: 14),),
                                                        ),

                                                      ),

                                                      Container(
//                                                          margin: const EdgeInsets.only(left: 10.0),

                                                          decoration: new BoxDecoration(
                                                              color: Colors.lightGreen,
                                                              borderRadius: new BorderRadius.only(
                                                                  topLeft: const Radius.circular(20.0),
                                                                  topRight: const Radius.circular(20.0),
                                                                  bottomLeft: const Radius.circular(20.0),
                                                                  bottomRight: const Radius.circular(20.0)
                                                              )
                                                          ),
//                                                            padding: const EdgeInsets.only(left: 10.0,top: 10.0,right: 10.0,bottom: 10.0,),
                                                          child:  Text(((){
                                                            if(sale.statusId== 1){
                                                              return "  New  ";
                                                            }
                                                            else{
                                                              return "";
                                                            }
                                                          })(), style: TextStyle(

                                                              fontSize: 14, color: Colors.white),)
                                                      )
                                                    ],
                                                  )
                                              ),
                                            ),

                                          ),
                                          DataCell(
                                              Text(sale.district.district, style: TextStyle(

                                                  fontSize: 14),)
                                          ),
                                          DataCell(
                                            Text(sale.status.status, style: TextStyle(

                                                fontSize: 14),),

                                          ),
//                                              if(sale.statusId == 1)
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child:ElevatedButton(

                                                  child: Text("Add"),
                                                  onPressed: (){
                                                    Navigator.push(
                                                        context, MaterialPageRoute(
                                                        builder: (context) => BtlActivityScreen()));

                                                  },
                                                )
                                            ),

//                                                Container(
//                                                    decoration: new BoxDecoration(
//                                                        color: Colors.black54,
//                                                        borderRadius: new BorderRadius.only(
//                                                            topLeft: const Radius.circular(20.0),
//                                                            topRight: const Radius.circular(20.0),
//                                                            bottomLeft: const Radius.circular(20.0),
//                                                            bottomRight: const Radius.circular(20.0)
//                                                        )
//                                                    ),
//                                                    padding: const EdgeInsets.only(left: 10.0,top: 10.0,right: 10.0,bottom: 10.0,),
//                                                    child:  Text(((){
//                                                      if(sale.statusId== 1){
//                                                        return "ADD";
//                                                      }
//                                                      return "VIEW";
//                                                    })(), style: TextStyle(
//
//                                                        fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),)
//
                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child:  ElevatedButton(

                                                  child: Text("Add"),
                                                  onPressed: (){
                                                    Navigator.push(
                                                        context, MaterialPageRoute(
                                                        builder: (context) => BeneficiaryForm()));

                                                  },
                                                )
                                            ),

                                          ),
                                          DataCell(
                                            Container(
                                                alignment: Alignment.center,
                                                child:  ElevatedButton(

                                                  child: Text("Add"),
                                                  onPressed: () async {

                                              SharedPreferences prefs = await SharedPreferences
                                                  .getInstance();
                                              prefs.setInt('jobId', sale.id);
                                              prefs.setString('task_title', sale.taskTitle);
                                              prefs.setString('createdBy', sale.createdByUser.name);
                                                    Navigator.push(
                                                        context, MaterialPageRoute(
                                                        builder: (context) => FieldActivityScreen()));

                                                  },
                                                )
                                            ),

                                          ),

                                        ]),
                              )
                                  .toList(),
                            ),
                          )

                      ),
                  ],
                )

                      ),
                    ]
                );
              }

              else {
                return Center(child: SpinKitFadingCircle(
                  color:myColor,
                  size: 70.0,)
                );
              }
            }
          },


        ),
      ),




    );

  }
}

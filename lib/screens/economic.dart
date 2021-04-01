
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
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssepnew/CustomAppBar.dart';
import 'package:ssepnew/models/SurveyModel.dart';
import 'package:ssepnew/screens/purchased.dart';
import 'package:ssepnew/themes.dart';





class EconomicScreen extends StatefulWidget {

//  final List<Survey> EconomicDetail;

//  const EconomicScreen({Key key, @required this.EconomicDetail}) : super(key: key);


  @override
  _EconomicScreen createState() => _EconomicScreen();
}

class _EconomicScreen extends State<EconomicScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
String _character ;
String userName = '';
int LengthValue = 5 ;
String gender ='Male' ;
int DChoice;
  final _text = TextEditingController();
final _AddResult = Survey();
//List<Survey> EconomicDetail;
  final List<String> names = <String>[];
//////  final List<String> age = <String>[];
  String _gender = 'Male';
  String _age = '1';
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
     List<Fm> Fmembers = [];
  bool _validateage = false;
  String Value_name;



  @override
  void dispose() {
    ageController.dispose();
    super.dispose();
  }

  FetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    setState(() {
      userName = (prefs.getString('user_name') ?? '');
    });
  }




  @override
  void initState() {
    setState(() {
      FetchData();
      fetchname();
      LengthValue = 5;
      gender = 'Male';
      _character= 'Owned';
      _AddResult.or = _character;
      _AddResult.lot = LengthValue.toString();


    });
    super.initState();
  }
  void addItemToList(){
    setState(() {
//      names.insert(0,_age);
//      age.insert(0, ageController.text);
//      Fmembers.add(Fm(gender: _gender, age: _age));
      Fmembers.insert(0, Fm(gender: _gender,age: ageController.text));
      _AddResult.fms = Fmembers ;
      print(_AddResult.fms.toString());

    });
  }
  void deleteItem() {
    setState((){
//      Fmembers.removeWhere((element,[index]) => element==element );
//      Fmembers.remove(Fm(gender: _gender,age: ageController.text));
    });
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



  bool _validate = false;


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

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

                                    userName??'default value' ,
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
        child: SingleChildScrollView(
           child: Column(
             children: <Widget>[
               Container(

                 height:70,
                 width: double.infinity,
                 child: Center(
                   child:  Text(
                     'Economic and Demographic Background',
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
                       Row(
                         children: <Widget>[
                           Expanded(
                             child: Column(
                               children: <Widget>[
                                 Container(
                                   margin: const EdgeInsets.only( right: 20.0),

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
                                       labelText: 'Name Head of Household',
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
                                     onSaved: (val) {
                                       _AddResult.name = val;
                                       print(_AddResult.name);
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

                                     margin: const EdgeInsets.only( right: 20.0),

                                     child:TextFormField(
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
                                       onSaved: (val) {
                                         _AddResult.address = val;
                                         print(_AddResult.address);
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
                                   margin: const EdgeInsets.only( right: 20.0),

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
                                       labelText: 'Phone Number',
                                       hintStyle: TextStyle(color: Colors.grey),

                                     ),
                                     keyboardType: TextInputType.number,
                                     inputFormatters: <TextInputFormatter>[
                                       WhitelistingTextInputFormatter.digitsOnly,
                                       LengthLimitingTextInputFormatter(15)

                                     ],
                                     validator: (val) {
                                       if (val.isEmpty) {
                                         return 'Field is required';
                                       }
                                       return null;
                                     },

                                     onSaved: (val) {
                                       _AddResult.pn = val.toString();
                                       print(_AddResult.pn);
                                     },
                                   ),
                                 ),

                               ],
                             ),
                           ),
                         ],
                       ),
                       Row(
                         children: <Widget>[
                           Expanded(
                             child:Container(
//                               margin: const EdgeInsets.only(right: 40.0),

                               child: Column(
                                 children: <Widget>[
//                                 new Padding(
//                                   padding: new EdgeInsets.all(8.0),
//                                 ),
                                   Container(
                                     padding: new EdgeInsets.only(top: 20.0,),
                                     child: Text(
                                       'Dwelling owened or rented',
                                       style: new TextStyle(
//                                     fontWeight: FontWeight.bold,
                                         color: Colors.grey,
                                         fontSize: 18.0,
                                       ),
                                     ),
                                   ),

                                   new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: <Widget>[
                                       new Radio(
                                         value: 'Owned',
                                         groupValue: _character,
                                         activeColor: myColor,

                                         onChanged:  ( value) {
                                           setState(() {
                                             _character = value;
                                             _AddResult.or = _character;
                                             print(_character);
                                           });
                                         },
                                       ),
                                       new Text(
                                         'Owned',
                                         style: new TextStyle(fontSize: 16.0),
                                       ),
                                       new Radio(
                                         value: 'Rent',
                                         groupValue: _character,
                                         activeColor: myColor,

                                         onChanged: ( value) {
                                           setState(() {
                                             _character = value;
                                             _AddResult.or = _character;
                                             print(_character);

                                           });
                                         },
                                       ),

                                       new Text(
                                         'Rent',
                                         style: new TextStyle(
                                           fontSize: 16.0,
                                         ),
                                       ),

                                     ],
                                   ),
                                 ],
                               ),
                             ),

                           ),
                           Expanded(
                             child: Container(
//                               margin: const EdgeInsets.only(right: 45.0),

                               child: Column(
                                 children: <Widget>[
//                                 new Padding(
//                                   padding: new EdgeInsets.all(8.0),
//                                 ),
                                   Container(
                                     padding: new EdgeInsets.only(top: 20.0),
                                     child: new Text(
                                       'Length of time in dwelling',
                                       style: new TextStyle(
                                         color: Colors.grey,

                                         fontSize: 18.0,
                                       ),
                                     ) ,
                                   ),

                                   new Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: <Widget>[
                                       new Radio(
                                         value: 5,
                                         groupValue: LengthValue,
                                         activeColor: myColor,

                                         onChanged:  ( value) {
                                           setState(() {
                                             LengthValue = value;
                                             _AddResult.lot =LengthValue.toString();
                                             print(LengthValue);
                                           });
                                         },
                                       ),
                                       new Text(
                                         '5',
                                         style: new TextStyle(fontSize: 16.0),
                                       ),
                                       new Radio(
                                         value: 10,
                                         groupValue: LengthValue,
                                         activeColor:myColor,

                                         onChanged: ( value) {
                                           setState(() {
                                             LengthValue = value;
                                             _AddResult.lot =LengthValue.toString();

                                             print(LengthValue);
                                           });
                                         },
                                       ),
                                       new Text(
                                         '10',
                                         style: new TextStyle(
                                           fontSize: 16.0,
                                         ),
                                       ),
                                       new Radio(
                                         value: 20,
                                         groupValue: LengthValue,
                                         activeColor: myColor,

                                         onChanged: ( value) {
                                           setState(() {
                                             LengthValue = value;
                                             _AddResult.lot =LengthValue.toString();

                                             print(LengthValue);
                                           });
                                         },
                                       ),
                                       new Text(
                                         '20',
                                         style: new TextStyle(
                                           fontSize: 16.0,
                                         ),
                                       ),

                                     ],
                                   ),
                                 ],
                               ),
                             ),

                           ),
                           Expanded(
                             child: Container(
//                               margin: const EdgeInsets.only(right: 110.0),
                               child: Column(
                                 children: <Widget>[
//                                 new Padding(
//                                   padding: new EdgeInsets.all(8.0),
//                                 ),
                                   Container(
                                     width: 150,
                                     child: TextFormField(
                                       controller: _text,
                                       style: TextStyle(color: Colors.grey),

                                       decoration: new InputDecoration(
//                            errorText: _validate ? 'Value Can\'t Be Empty' : null,

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
                                         labelText: 'Number of Rooms',
                                         hintStyle: TextStyle(color: Colors.grey),

                                       ),
                                       keyboardType: TextInputType.number,
                                       inputFormatters: <TextInputFormatter>[
                                         WhitelistingTextInputFormatter.digitsOnly
                                       ],
                                       onSaved: (val) {
                                         _AddResult.rooms = val.toString();
                                         print(_AddResult.rooms);
                                       },
//                          validator: (value) {
//                            if (value.isEmpty) {
//                              return 'Please enter some text';
//                            }
//                            return null;
//                          },
                                     ),
                                   ),


                                 ],
                               ),
                             ),

                           )
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

                       Container(
                         padding: const EdgeInsets.only(top: 15.0),

                         child:  Text(
                           'Not Including yourself, what are the gender and age of the people living in your home more than 50% of the time ?',
                           style: TextStyle(fontSize: 14, color: Colors.black,
                           ),
                         ),
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: <Widget>[
                           new Radio(
                             value: 'Male',
                             groupValue: gender,
                             activeColor: myColor,
                             onChanged:  (value) {
                               setState(() {
                                 gender = value;
                                 _gender = gender;
                                 print(gender);
                               });
                             },
                           ),
                           new Text(
                             'Male',
                             style: new TextStyle(fontSize: 16.0),
                           ),
                           new Radio(
                             value: 'Female',
                             groupValue: gender,
                             activeColor: myColor,
                             onChanged: ( value) {
                               setState(() {
                                 gender = value;
                                 _gender = gender;
                                 print(gender);

                               });
                             },
                           ),
                           new Text(
                             'Female',
                             style: new TextStyle(
                               fontSize: 16.0,
                             ),
                           ),
                           Container(
                             width: 50.0,
                             padding: const EdgeInsets.only(left: 10.0),

                             child:   TextField(
                      controller: ageController,
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
//                                 labelText: 'Age',
                                 hintText: "Age",
                                 hintStyle: TextStyle(color: Colors.grey),
                                 errorText: _validateage ? '' : null,

                               ),

                               keyboardType: TextInputType.number,
                               inputFormatters: <TextInputFormatter>[
                                 WhitelistingTextInputFormatter.digitsOnly,
                                 LengthLimitingTextInputFormatter(2)

                               ],

//                               onSaved: (val) {
//                                 _age = val.toString();
//                                 print(_age);
//                               },
                             ),
                           ),
                           Container(
                             margin: const EdgeInsets.only(left: 20.0),
                             width: 30.0,
                           height: 30.0,

                           child: FloatingActionButton(

                               onPressed: () {
                                 setState(() {
                                   ageController.text.isEmpty ? _validateage = true : _validateage = false;
                                 });

                                 // Add your onPressed code here!
                                 if(ageController.text.isNotEmpty && ageController.text != 0 && ageController.text != 00 ) {

                                   addItemToList();
                                 }
                                 },
                               child: Icon(Icons.add , color: Colors.white,),
                               backgroundColor:myColor,
                               splashColor: Colors.white.withOpacity(0.25),


                           ),
                           )




                         ],
                       ),
                       new Row(
                         children: <Widget>[
                           Expanded(
                             child: SizedBox(
                               height: 40.0,
                               child: new ListView.builder(
                                 scrollDirection: Axis.horizontal,
                                 itemCount: Fmembers.length,
                                 itemBuilder: (BuildContext ctxt, int index) {
                                 final  member = Fmembers[index];
//                                   return new Text( '${member.gender} ${member.age}');
                                 return Container(
                                       height: 25,
                                       margin: EdgeInsets.all(0),
                                 child: Row(
                                    children: <Widget>[
                                      Text('|     ${member.gender}  age of  ${member.age} ',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      IconButton(
                                        padding: const EdgeInsets.only(bottom: 3.0),
                                        iconSize: 18,
                                        icon: Icon(Icons.remove_circle , color: Colors.red,),
                                        onPressed: (){
                                          setState(() {
                                            Fmembers.removeAt(index);
                                          });
//                                          deleteItem();
                                        },
                                      ),

                                    ],
                                  ),
//                                   color: member.gender >=10? Colors.blue[400]:
//                                   msgCount[index]>3? Colors.blue[100]: Colors.grey,
//                                   child: Center(
//                                   ),
                                 );


                                 },
                               ),
                             ),
                           ),
                           new IconButton(
                             icon: Icon(Icons.arrow_right),
                             onPressed: () {},
                           ),
                         ],
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       ),

                       Container(
//                         padding: const EdgeInsets.only(top: 20.0),

                         child:  Text(
                           'Number of people who can read and write ?',
                           style: TextStyle(fontSize: 14, color: Colors.black,
                           ),
                         ),
                       ),
                       Container(
                         width: 30.0,

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
//                          labelText: 'Age',
                             hintText: "1",
                             hintStyle: TextStyle(color: Colors.grey),

                           ),
                           keyboardType: TextInputType.number,
                           inputFormatters: <TextInputFormatter>[
                             WhitelistingTextInputFormatter.digitsOnly
                           ],
                           onSaved: (val) {
                             _AddResult.nprw = val.toString();
                             print(_AddResult.nprw);
                           },
                         ),
                       ),
                       Container(
                         padding: const EdgeInsets.only(top: 10.0),

                         child:  Text(
                           'Distance of household from transport network ?',
                           style: TextStyle(fontSize: 14, color: Colors.black,
                           ),
                         ),
                       ),
                       Container(
                         width: 50.0,

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
//                          labelText: 'Age',
                             hintText: "1 KM",
                             hintStyle: TextStyle(color: Colors.grey),

                           ),
                           keyboardType: TextInputType.number,
                           inputFormatters: <TextInputFormatter>[
                             WhitelistingTextInputFormatter.digitsOnly
                           ],
                           onSaved: (val) {
                             _AddResult.distance = val.toString();
                             print(_AddResult.distance);
                           },
                         ),
                       ),
                       Container(
                         padding: const EdgeInsets.only(top: 10.0),

                         child:  Text(
                           'Occupation of head of household',
                           style: TextStyle(fontSize: 14, color: Colors.black,
                           ),
                         ),
                       ),
                       Container(
                         width: 200.0,

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
//                          labelText: 'Age',
//                             hintText: "1",
                             hintStyle: TextStyle(color: Colors.grey),

                           ),

                           onSaved: (val) {
                             _AddResult.occupation = val;
                             print(_AddResult.occupation);
                           },
                         ),
                       ),
                       Container(
                         padding: const EdgeInsets.only(top: 10.0),

                         child:  Text(
                           'Gross Household Income',
                           style: TextStyle(fontSize: 14, color: Colors.black,
                           ),
                         ),
                       ),
                       Container(
                         width: 200.0,

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
//                          labelText: 'Age',
//                             hintText: "1",
                             hintStyle: TextStyle(color: Colors.grey),

                           ),
                           keyboardType: TextInputType.number,
                           inputFormatters: <TextInputFormatter>[
                             WhitelistingTextInputFormatter.digitsOnly
                           ],
                           onSaved: (val) {
                             _AddResult.gi = val.toString();
                             print(_AddResult.gi);
                           },
                         ),
                       ),
                       Container(
                         padding: const EdgeInsets.only(top: 10.0),

                         child:  Text(
                           'Family expenditures',
                           style: TextStyle(fontSize: 14, color: Colors.black,
                           ),
                         ),
                       ),
                       Container(
                         width: 200.0,

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
//                          labelText: 'Age',
//                             hintText: "1",
                             hintStyle: TextStyle(color: Colors.grey),

                           ),
                           onSaved: (val) {
                             _AddResult.expenditures = val;
                             print(_AddResult.expenditures);
                           },
                         ),
                       ),


                       Container(
                         padding: const EdgeInsets.only(top: 20.0),
                         child:  Text(
                           'For farm households',
                           style: TextStyle(fontSize: 20, color: myColor,
                           ),
                         ),
                       ),
                       Container(
                         padding: const EdgeInsets.only(top: 20.0),

                         child:  Text(
                           'Size of farm',
                           style: TextStyle(fontSize: 14, color: Colors.black,
                           ),
                         ),
                       ),
                       Container(
                         width: 200.0,

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
//                          labelText: 'Age',
//                             hintText: "1",
                             hintStyle: TextStyle(color: Colors.grey),

                           ),
                           keyboardType: TextInputType.number,
                           inputFormatters: <TextInputFormatter>[
                             WhitelistingTextInputFormatter.digitsOnly
                           ],
                           onSaved: (val) {
                             _AddResult.farmSize = val.toString();
                             print(_AddResult.farmSize);
                           },
                         ),
                       ),


                     Center(
                       child:  InkWell(
                         child:   Container(
                             margin: const EdgeInsets.only(top: 20.0),

                             height: 50,
                             width: 230,
//                             padding: EdgeInsets.all(12.0),

//                             padding: const EdgeInsets.symmetric(vertical: 16.0),///

//                           padding: EdgeInsets.fromLTRB(200, 0, 200, 0),
//                           margin: EdgeInsets.only(top: 230.0),
                             child: RaisedButton(

                               textColor: Colors.white,
                               color: myColor,
                               child: Text('Next'),
                               onPressed: ( )
                               {setState(() {
                               });
                               _submitForm();

//                               Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (BuildContext context) =>  PurchasedScreen (),settings: RouteSettings( arguments: _AddResult)),
//                             );

                               },
                             )
                         ),

                       ),
                     ),





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
            ),
//      drawer: CustomerDrawer(),

    );
}

  Future<void> _submitForm() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {

//      String a= _fbKey.currentState.value.toString();
//      _formResult.supporterType = a;
//      _AddResult.userId = 101.toString();

      form.save();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) =>  PurchasedScreen (),settings: RouteSettings( arguments: _AddResult)),
      );
//      print(_AddResult.toMap());

//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      String tokenn = (prefs.getString('token'));
//      String token = 'Bearer ' + tokenn;
//
//      final uri = 'https://orangeroomdigital.com/sscp/public/api/survey';
//
//
//      http.Response response = await http.post(
//        uri, headers: { 'Content-type': 'application/json',
//        'Accept': 'application/json', HttpHeaders.authorizationHeader: token},
//        body: (json.encode(_AddResult.toMap())),
//      );
//      print(response.body);
//      print(_AddResult.toMap());
//
//
//      print('Data saved');
//      print(_AddResult);
//    }
    }
  }




}
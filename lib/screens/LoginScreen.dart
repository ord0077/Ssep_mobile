//
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'file:///C:/Users/user/AndroidStudioProjects/ssep_new/lib/screens/btl_records.dart';
//
//
//class LoginPage extends StatefulWidget {
//  @override
//  _State createState() => _State();
//}
//class _State extends State<LoginPage> {
//  TextEditingController nameController = new TextEditingController();
//  TextEditingController passwordController = new TextEditingController();
//  bool _isLoading = false;
//
//  @override
//  Widget build(BuildContext context) {
//    final logo = Hero(
//      tag: 'hero',
//      child: CircleAvatar(
//        backgroundColor: Colors.transparent,
//        radius: 48.0,
//        child: Image.asset('assets/Sindh_logo.png'),
//      ),
//    );
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('Sindh TB Notification'),
//        ),
//
//        body: Padding(
//            padding: EdgeInsets.all(10),
//
//            child: ListView(
//
//              children: <Widget>[
//                Container(
//
//                    alignment: Alignment.center,
//                    padding: EdgeInsets.all(10),
//
//                    child: Column(
//                      children: <Widget>[
//                        Image.asset(
//                          'assets/Sindh_logo.png',
//                          width: 200,
//                          height: 400,
//                        ),
//                      ],
//                    )),
//
//
//                Container(
//
//                    alignment: Alignment.center,
//                    padding: EdgeInsets.all(10),
//
//                    child:  Column(
//                      children: <Widget>[
//                        Text(
//                          'Sindh TB Notification System',
//                          style: TextStyle(
//                              color: Colors.blue,
//                              fontWeight: FontWeight.w500,
//                              fontSize: 25),
//                        ),
//                        Text(
//                          'Sindh TB Notification System',
//                          style: TextStyle(
//                              color: Colors.blue,
//                              fontWeight: FontWeight.w500,
//                              fontSize: 25),
//                        ),
//                        Text(
//                          'Sindh TB Notification System',
//                          style: TextStyle(
//                              color: Colors.blue,
//                              fontWeight: FontWeight.w500,
//                              fontSize: 25),
//                         )
//
//
//                      ],
//                    )
//                   ),
//                Container(
//                    alignment: Alignment.center,
//                    padding: EdgeInsets.fromLTRB(250, 0, 250, 0),
//                    child: Text(
//                      'Login',
//                      style: TextStyle(fontSize: 20),
//                    )),
//                Container(
//                  padding: EdgeInsets.fromLTRB(250, 0, 250, 0),
//                  child: TextField(
//                    controller: nameController,
//                    decoration: InputDecoration(
//                      border: OutlineInputBorder(),
//                      labelText: 'Email',
//                    ),
//                  ),
//                ),
//                Container(
//                  padding: EdgeInsets.fromLTRB(250, 0, 250, 0),
//                  child: TextField(
//                    obscureText: true,
//                    controller: passwordController,
//                    decoration: InputDecoration(
//                      border: OutlineInputBorder(),
//                      labelText: 'Password',
//                    ),
//                  ),
//                ),
//                FlatButton(
//                  onPressed: () {
//                    //forgot password screen
//                  },
//                  textColor: Colors.blue,
//                  child: Text('Forgot Password'),
//                ),
//
//
//                Container(
//                    height: 50,
//                    padding: EdgeInsets.fromLTRB(250, 0, 250, 0),
//                    child: RaisedButton(
//
//                      textColor: Colors.white,
//                      color: Colors.blue,
//                      child: Text('Login'),
//                      onPressed: () {
//                        setState(() {
//                          _isLoading = true;
//                        });
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => UserList()),
//                        );
////                        signIn(nameController.text,passwordController.text);
//                        print(nameController.text);
//                        print(passwordController.text);
//                      },
//                    ))
//
//
////                Container(
////                    child: Row(
////                      children: <Widget>[
////                        Text('Does not have account?'),
////                        FlatButton(
////                          textColor: Colors.blue,
////                          child: Text(
////                            'Sign in',
////                            style: TextStyle(fontSize: 20),
////                          ),
////                          onPressed: () {
////                            //signup screen
////                          },
////                        )
////                      ],
////                      mainAxisAlignment: MainAxisAlignment.center,
////                    ))
//              ],
//            )));
//  }
//}


//  signIn (String email, password) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    Map data = {
//      'email': email,
//      'password': pass
//    };
//    var jsonResponse = null;
//    var response = await http.post("YOUR_BASE_URL", body: data);
//    if(response.statusCode == 200) {
//      jsonResponse = json.decode(response.body);
//      if(jsonResponse != null) {
//        setState(() {
//          _isLoading = false;
//        });
//        sharedPreferences.setString("token", jsonResponse['token']);
//        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
//      }
//    }
//    else {
//      setState(() {
//        _isLoading = false;
//      });
//      print(response.body);
//    }
//  },

import 'package:ssepnew/consts.dart';
import 'package:ssepnew/forgotpassword.dart';
import 'package:ssepnew/models/loginModel.dart';
import 'file:///C:/Users/user/AndroidStudioProjects/ssep_new/lib/repositories/loginRepository.dart';
import 'package:ssepnew/themes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final LoginRepository _login = LoginRepository();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
 var _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loginIsTapped = false;

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
//        resizeToAvoidBottomInset: false,
        body: Builder(
            builder: (context) {
//              return Stack(
//                children: <Widget>[
//                  Column(
//                    children: <Widget>[
//                      Center(
//                      child: Padding(
//                          padding: const EdgeInsets.only(top: 50.0),
//                          child: Container(
//                            child: Image.asset(
//                              'assets/Solar_Logo.png',
////                            fit: BoxFit.cover,
//                              width: 400,
//                              height: 300,
//                            ),
//                          ),
//                        ),
//                      ),
//
//                                Container(
//                                    width: 600,
//                                    height: 150,
//                                    padding: EdgeInsets.all(10.0),
////                                color: Color.fromRGBO(0, 0, 100, 1),
////                      padding: const EdgeInsets.only(top: 20.0),
//
//                                    alignment: Alignment.center,
////                      padding: EdgeInsets.all(10),
//
//                                    child:  Column(
//                                      children: <Widget>[
//
//
//                                        Text(
//                                          'Sindh Solar Energy Project',
//                                          style: TextStyle(
//                                              color: myColor,
//                                              fontWeight: FontWeight.w400,
//                                              fontSize: 40),
//                                        ),
//                                        Text(
//                                          'BTL Activity Tracker',
//                                          style: TextStyle(
//                                              color: myColor,
//                                              fontWeight: FontWeight.w400,
//                                              fontSize: 40),
//                                        ),
//
//
//
//                                      ],
//                                    )
//                                ),
//                      Expanded(
//                       child: Container(
//                          width: MediaQuery.of(context).size.width,
//                        height: MediaQuery.of(context).size.height,
//                         color: myColor,
//                         child: Column(
//                           mainAxisAlignment:MainAxisAlignment.center,
//                           children: <Widget>[
//                            Container(
//                              child:FractionallySizedBox(
//                                  widthFactor: 0.4,
//                                  child:Column(
//                                      children: <Widget> [
//                                        Align(
//                                          alignment: Alignment.centerLeft,
//                                          child: Text(
//                                            'Login',
//                                            style: TextStyle(
//                                              color: Colors.white,
//                                              fontWeight: FontWeight.w400,
//                                              fontSize: 28,),
//
//
//                                          ),
//                                        ),
//                                        SizedBox(height: 10),
//
//                                        Align(
//                                          alignment: Alignment.centerLeft,
//                                          child: Text(
//                                            'Please login to your account.',
//                                            style: TextStyle(
//                                                color: Colors.white70,
//                                                fontWeight: FontWeight.w300,
//                                                fontSize: 22),
//                                          ),
//                                        ),
//                                        SizedBox(height: 15.0),
//                                        new Container(
//                                          child: new TextField(
//                                            controller: emailController,
//                                            style: TextStyle(color: Colors.white),
//
//                                            decoration: new InputDecoration(
//
//                                              labelStyle: TextStyle(
//                                                  color: Colors.white
//                                              ),
//                                              errorStyle: TextStyle(
//                                                  color: Colors.red
//                                              ),
//                                                enabledBorder: UnderlineInputBorder(
//                                                  borderSide: BorderSide(color: Colors.white70),
//                                                ),
//                                                focusedBorder: UnderlineInputBorder(
//                                                  borderSide: BorderSide(color: Colors.white),
//                                                ),
//                                                border: UnderlineInputBorder(
//                                                  borderSide: BorderSide(color: Colors.red),
//                                                ),
//                                                prefixIcon: Icon(Icons.person_outline,color: Colors.white),
//                                                labelText: 'Email',
//                                              hintText: "Enter your email",
//                                              hintStyle: TextStyle(color: Colors.white70),
//
//                                            ),
//                                          ),
//                                        ),
//                                        SizedBox(height: 15.0,),
//                                        new Container(
//                                          child: Theme(
//                                            child: new TextField(
//                                              obscureText: true,
//                                              controller: passwordController,
//                                              style: TextStyle(color: Colors.white),
//                                              decoration: new InputDecoration(
//
//                                                labelStyle: TextStyle(
//                                                    color: Colors.white
//                                                ),
//                                                errorStyle: TextStyle(
//                                                    color: Colors.red
//                                                ),
//                                                enabledBorder: UnderlineInputBorder(
//                                                  borderSide: BorderSide(color: Colors.white70),
//                                                ),
//                                                focusedBorder: UnderlineInputBorder(
//                                                  borderSide: BorderSide(color: Colors.white),
//                                                ),
//                                                border: UnderlineInputBorder(
//                                                  borderSide: BorderSide(color: Colors.red),
//                                                ),
//
//                                                prefixIcon: Icon(Icons.lock_outline,color: Colors.white),
//                                                labelText: 'Password',
//
//                                                hintText: "Enter your password",
//                                                hintStyle: TextStyle(color: Colors.white70),
//
//                                              ),
//                                              autofocus: true,
//                                            ),
//                                            data: Theme.of(context).copyWith(primaryColor: Colors.white),
//              ),
//
//                                        ),
//                                        SizedBox(height: 15.0,),
//
//                                       // Forgot password
//
//                                        // SizedBox(height: 8.0,),
//
//                                         GestureDetector(
//                                           child: Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Text(
//                                               "Forgot Password?",
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                           onTap: (){
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
//                                             );
//                                           },
//                                         ),
//                                        SizedBox(height: 16.0,),
//
//
//                                        // Button
//                                        InkWell(
//                                          child: Container(
//                                            height: 55.0,
//                                            padding: EdgeInsets.all(12.0),
//                                            color: Colors.white,
//                                            child: Center(
//                                              child: loginIsTapped? Center(
//                                                  child: SizedBox(
//                                                    width: 20.0,
//                                                    height: 20.0,
//                                                    child: CircularProgressIndicator(
//                                                      backgroundColor: myColor,
//                                                      valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
//                                                      strokeWidth: 3.0,
//                                                    ),
//                                                  )
//                                              ):Text(
//                                                "LOGIN",
//                                                style: TextStyle(
//                                                  color: myColor,
//                                                    fontWeight: FontWeight.w600,
//                                                    fontSize: 17,
//                                                ),
//                                              ),
//                                            ),
//                                          ),
//
//                                          onTap: () async {
//
//                                            if (emailController.text == "" || passwordController.text == ""){
//                                              _showToast(context, 'One or more feild(s) are empty');
//                                            } else{
//
//                                              setState(() {
//                                                loginIsTapped = loginIsTapped? false:true;
//                                              });
//
//                                              // String _email = "customer2@ord.com";
//                                              // String _password = "secret";
//                                              String _email = emailController.text;
//                                              String _password = passwordController.text;
//
//
//
//                                              Future<LoginModel> loginResponse = _login.login(_email, _password);
//
//                                              loginResponse.then((loginModel) async {
//                                                  SharedPreferences userData = await SharedPreferences.getInstance();
//                                                  String userJSON = jsonEncode(loginModel);
//                                                  userData.setString('token', loginModel.token.toString());
//                                                  userData.setInt('user_id', loginModel.user.id);
//                                                  userData.setString('user_name', loginModel.user.name.toString());
//                                                  var tokenn = userData.getString('token');
//                                                  print(tokenn);
//
//                                                  userData.remove(userKey);
//                                                  userData.setString(
//                                                      userKey, userJSON);
//                                                  String text = loginModel.token
//                                                      .toString();
//                                                  print(loginModel.user.userType
//                                                      .toLowerCase());
//                                                  switch(loginModel.user.userType){
//                                                    case "User":
////                                          Navigator.pushReplacementNamed(context, '/btl_records');
//                                                    Navigator.pushReplacementNamed(context, '/dashboard');
//                                          break;
//                                                    default:
//                                                      _showToast(context, 'Some error occurred please try again later');
//
//                                                  }
////                                                  Navigator.push(context,
////                                                    MaterialPageRoute(
////                                                        builder: (context) =>
////                                                            Btl_Record_List()),);
//
//                                              }).catchError((error){
//                                                _showToast(context, error);
//
//                                              }).whenComplete((){
//                                                setState(() {
//                                                  loginIsTapped = false;
//
//                                                });
//                                              });
//
//                                            }
//                                          },
//
//                                        ),
//                                      ]
//                                  )
//
//
//                              ),
//                            ),
//                           ],
//                         ),
//                        ),
//                      ),
//
//
//
//
////                      Container(
////                        color: Colors.amber,
////                        child: Row(
////                          mainAxisAlignment: MainAxisAlignment.center,
////
////                          children: <Widget>[
////                            Column(
//////                                  mainAxisAlignment: MainAxisAlignment.center,
////                              mainAxisSize: MainAxisSize.max,
////                              crossAxisAlignment: CrossAxisAlignment.center,
////                              children: <Widget>[
////                                Container(
////                                  margin: const EdgeInsets.only(top: 40.0),
////                                  child: Image.asset(
////                                    'assets/Sindh_logo.png',
////                                    width: 200,
////                                    height: 300,
////
////                                  ),
////                                ),
////                                Container(
////                                    width: 600,
////                                    height: 150,
////                                    padding: EdgeInsets.all(10.0),
//////                                color: Color.fromRGBO(0, 0, 100, 1),
//////                      padding: const EdgeInsets.only(top: 20.0),
////
////                                    alignment: Alignment.center,
//////                      padding: EdgeInsets.all(10),
////
////                                    child:  Column(
////                                      children: <Widget>[
////
////
////                                        Text(
////                                          'Sindh Solar Energy Project',
////                                          style: TextStyle(
////                                              color: Color.fromRGBO(0, 150, 136, 1),
////                                              fontWeight: FontWeight.w400,
////                                              fontSize: 40),
////                                        ),
////                                        Text(
////                                          'BTL Activity Tracker',
////                                          style: TextStyle(
////                                              color: Color.fromRGBO(0, 150, 136, 1),
////                                              fontWeight: FontWeight.w400,
////                                              fontSize: 40),
////                                        ),
////
////
////
////                                      ],
////                                    )
////                                ),
////
////                              ],
////                            )
////                          ],
////                        ),
////
////
////                      ),
////                      Container(
////                          color: Colors.blue,
////                          child:  Row(
////
////                            children: <Widget>[
////                              Column(
////                                children: <Widget>[
////
////
////
//////                            Container(
//////                              child:FractionallySizedBox(
//////                                  widthFactor: 0.6,
//////                                  child:Column(
//////                                      children: <Widget> [
//////
//////                                        Text(
//////                                          'Login',
//////                                          style: TextStyle(
//////                                            color: Colors.black,
//////                                            fontWeight: FontWeight.w500,
//////                                            fontSize: 28,),
//////
//////                                        ), Text(
//////                                          'please login to your account',
//////                                          style: TextStyle(
//////                                              color: Colors.grey,
//////                                              fontWeight: FontWeight.w500,
//////                                              fontSize: 22),
//////                                        ),
//////                                        InputBox(
//////                                          hint: "Email",
//////                                          icon: Icons.person_outline,
//////                                          isPassword: false,
//////                                          textController: emailController,
//////                                        ),
//////
//////                                        SizedBox(height: 8.0),
//////
//////                                        // Input textfields for password
//////                                        InputBox(
//////                                          hint: "Password",
//////                                          icon: Icons.lock_outline,
//////                                          isPassword: true,
//////                                          textController: passwordController,
//////                                        ),
//////                                        SizedBox(height: 8.0,),
//////
//////
//////                                        // Button
//////                                        InkWell(
//////                                          child: Container(
//////                                            padding: EdgeInsets.all(12.0),
//////                                            color: Color.fromRGBO(0, 0, 100, 1),
//////                                            child: Center(
//////                                              child: loginIsTapped? Center(
//////                                                  child: SizedBox(
//////                                                    width: 20.0,
//////                                                    height: 20.0,
//////                                                    child: CircularProgressIndicator(
//////                                                      backgroundColor: Colors.white,
//////                                                      valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
//////                                                      strokeWidth: 3.0,
//////                                                    ),
//////                                                  )
//////                                              ):Text(
//////                                                "Login",
//////                                                style: TextStyle(
//////                                                  color: Colors.white,
//////                                                ),
//////                                              ),
//////                                            ),
//////                                          ),
//////
//////                                          onTap: () async {
//////
////////
////////                                            }
//////                                          },
//////
//////                                        ),
//////                                      ]
//////                                  )
//////
//////
//////                              ),
//////                            ),
////
////                                ],
////                              )
////                            ],
////                          )
////                      )
//                    ],
//                  )
//
//
//
//
//
////                  Center(
////
////                    child: SingleChildScrollView(
////                      child: Container(
////                        margin: const EdgeInsets.only(top: 0.0),
////
////                        color: Colors.white,
////                        child: Column(
//////                          mainAxisAlignment: MainAxisAlignment.center,
//////                          mainAxisSize: MainAxisSize.max,
//////                          crossAxisAlignment: CrossAxisAlignment.center,
////                          children: <Widget>[
////                            Container(
////
////                              child: Image.asset(
////                                'assets/Sindh_logo.png',
////                                width: 200,
////                                height: 300,
////
////                              ),
////                            ),
////
////
//////                            SizedBox(height: 16.0,),
////                            Container(
////                                width: 600,
////                                height: 150,
////                                padding: EdgeInsets.all(16.0),
////                                color: Color.fromRGBO(0, 0, 100, 1),
//////                      padding: const EdgeInsets.only(top: 20.0),
////
////                                alignment: Alignment.center,
//////                      padding: EdgeInsets.all(10),
////
////                                child:  Column(
////                                  children: <Widget>[
////
////
////                                    Text(
////                                      'Sindh TB Notification System',
////                                      style: TextStyle(
////                                          color: Colors.white,
////                                          fontWeight: FontWeight.w500,
////                                          fontSize: 40),
////                                    ),
////                                    Text(
////                                      'Directorate of TB Control Programme',
////                                      style: TextStyle(
////                                          color: Colors.white,
////                                          fontWeight: FontWeight.w500,
////                                          fontSize: 25),
////                                    ),
////                                    Text(
////                                      'ptp_sindh@yahoo.com',
////                                      style: TextStyle(
////                                          color: Colors.white,
////                                          fontWeight: FontWeight.w500,
////                                          fontSize: 22),
////                                    )
////
////
////                                  ],
////                                )
////                            ),
////                            SizedBox(height: 100.0,),
////
////                            // Logo image of login screen
////
////                            Container(
////                              child:FractionallySizedBox(
////                                  widthFactor: 0.6,
////                                  child:Column(
////                                      children: <Widget> [
////
////                                        Text(
////                                          'Login',
////                                          style: TextStyle(
////                                            color: Colors.black,
////                                            fontWeight: FontWeight.w500,
////                                            fontSize: 28,),
////
////                                        ), Text(
////                                          'please login to your account',
////                                          style: TextStyle(
////                                              color: Colors.grey,
////                                              fontWeight: FontWeight.w500,
////                                              fontSize: 22),
////                                        ),
////                                        InputBox(
////                                          hint: "Email",
////                                          icon: Icons.person_outline,
////                                          isPassword: false,
////                                          textController: emailController,
////                                        ),
////
////                                        SizedBox(height: 8.0),
////
////                                        // Input textfields for password
////                                        InputBox(
////                                          hint: "Password",
////                                          icon: Icons.lock_outline,
////                                          isPassword: true,
////                                          textController: passwordController,
////                                        ),
////                                        SizedBox(height: 8.0,),
////
////
////                                        // Button
////                                        InkWell(
////                                          child: Container(
////                                            padding: EdgeInsets.all(12.0),
////                                            color: Color.fromRGBO(0, 0, 100, 1),
////                                            child: Center(
////                                              child: loginIsTapped? Center(
////                                                  child: SizedBox(
////                                                    width: 20.0,
////                                                    height: 20.0,
////                                                    child: CircularProgressIndicator(
////                                                      backgroundColor: Colors.white,
////                                                      valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
////                                                      strokeWidth: 3.0,
////                                                    ),
////                                                  )
////                                              ):Text(
////                                                "Login",
////                                                style: TextStyle(
////                                                  color: Colors.white,
////                                                ),
////                                              ),
////                                            ),
////                                          ),
////
////                                          onTap: () async {
////
//////                                            if (emailController.text == "" || passwordController.text == ""){
//////                                              _showToast(context, 'One or more feild(s) are empty');
//////                                            } else{
//////
//////                                              setState(() {
//////                                                loginIsTapped = loginIsTapped? false:true;
//////                                              });
//////
//////                                              // String _email = "customer2@ord.com";
//////                                              // String _password = "secret";
//////                                              String _email = emailController.text;
//////                                              String _password = passwordController.text;
//////
//////
//////
//////                                              Future<LoginModel> loginResponse = _login.login(_email, _password);
//////
//////                                              loginResponse.then((loginModel) async {
//////
//////                                                SharedPreferences userData = await SharedPreferences.getInstance();
//////                                                String userJSON = jsonEncode(loginModel);
//////                                                userData.setString('token', loginModel.token.toString());
//////                                                var tokenn = userData.getString('token');
//////                                                print(tokenn);
//////
////////                                      WidgetsFlutterBinding.ensureInitialized();ha
////////                                      SharedPreferences prefs = await SharedPreferences.getInstance();
////////                                      var token = prefs.getString('token');
////////                                      print(token);
//////
//////                                                userData.remove(userKey);
//////                                                userData.setString(userKey, userJSON);
//////                                                String text = loginModel.token.toString();
//////                                                print(loginModel.user.userType.toLowerCase());
//////
//////                                                switch (loginModel.user.userType.toLowerCase()) {
//////                                                  case "field officer":
//////                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => TBCases_List(app:text)),);
//////
////////                                          Navigator.push(
////////                                                   context,
////////                                             MaterialPageRoute(builder: (context) =>  UserList()),
////////                                                  );
//////                                                    break;
//////
//////                                                  case "driver":
//////                                                    Navigator.pushReplacementNamed(
//////                                                      context,
//////                                                      '/driver',
//////                                                    );
//////                                                    break;
//////
//////                                                  case "maintenance":
//////                                                    Navigator.pushReplacementNamed(
//////                                                      context,
//////                                                      '/maintenance',
//////                                                    );
//////                                                    break;
//////
//////                                                  case "cold storage":
//////                                                    Navigator.pushReplacementNamed(
//////                                                      context,
//////                                                      '/coldstorage',
//////                                                    );
//////                                                    break;
//////                                                  default:
//////                                                    _showToast(context, 'Some error occurred please try again later');
//////                                                }
//////                                              }).catchError((error){
//////                                                _showToast(context, error);
//////
//////                                              }).whenComplete((){
//////                                                setState(() {
//////                                                  loginIsTapped = false;
//////
//////                                                });
//////                                              });
//////
//////                                            }
////                                          },
////
////                                        ),
////                                      ]
////                                  )
////
////
////                              ),
////                            ),
////                            // Input textfields for email
////
////                            // Forgot password
////
////                            // SizedBox(height: 8.0,),
////
////                            // GestureDetector(
////                            //   child: Align(
////                            //     alignment: Alignment.centerRight,
////                            //     child: Text(
////                            //       "Forgot Password?",
////                            //       style: TextStyle(
////                            //         color: Theme.of(context).accentColor,
////                            //       ),
////                            //     ),
////                            //   ),
////                            //   onTap: (){
////                            //     Navigator.push(
////                            //       context,
////                            //       MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
////                            //     );
////                            //   },
////                            // ),
////
////
////
////                          ],
////
////                        ),
////                      ),
//////                      ),
////                    ),
////                  ),
//                ],
//              );
              return new Stack(
                children: <Widget>[
                  // The containers in the background
//                  new Column(
//                    children: <Widget>[
//                      new Container(
//                        height: MediaQuery.of(context).size.height * .50,
//                        color: Colors.blue,
//                      ),
//                      new Container(
//                        height: MediaQuery.of(context).size.height * .50,
//                        color: Colors.white,
//                      )
//                    ],
//                  ),

                  Center(
                    child: FractionallySizedBox(
                      widthFactor: 0.6,
                      child: SingleChildScrollView(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              // Logo image of login screen
                              Image.asset(
                                'assets/Solar_Logo.png',
                              ),

                              SizedBox(height: 16.0,),

                              new Container(

                                child: Theme(
                                  child:

                                  new TextField(
                                    controller: emailController,
                                    style: TextStyle(color: Colors.blue),

                                    decoration: new InputDecoration(


                                      labelStyle: TextStyle(
                                          color: Colors.blue
                                      ),
                                      errorStyle: TextStyle(
                                          color: Colors.red
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.red),
                                      ),
                                      prefixIcon: Icon(Icons.person_outline,color: Colors.blue),
                                      labelText: 'Email',
                                      hintText: "Enter your email",
                                      hintStyle: TextStyle(color: Colors.blue),

                                    ),
                                  ),
                                  data: Theme.of(context).copyWith(primaryColor: Colors.blue),
                                ),
                              ),
                              SizedBox(height: 8.0,),
                              new Container(
//                                child: Theme(
                                child:
                                new TextField(
                                  obscureText: true,
                                  controller: passwordController,
                                  style: TextStyle(color: Colors.blue),
                                  decoration: new InputDecoration(

                                    labelStyle: TextStyle(
                                        color: Colors.blue
                                    ),
                                    errorStyle: TextStyle(
                                        color: Colors.red
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),

                                    prefixIcon: Icon(Icons.lock_outline,color: Colors.blue),
                                    labelText: 'Password',

                                    hintText: "Enter your password",
                                    hintStyle: TextStyle(color: Colors.blue),

                                  ),
                                  autofocus: true,
                                ),
//                                  data: Theme.of(context).copyWith(primaryColor: Colors.blue),
//                                ),

                              ),

                              // Forgot password
                              SizedBox(height: 16.0,),
//                              GestureDetector(
//                                child: Align(
//                                  alignment: Alignment.centerRight,
//                                  child: Text(
//                                    "Forgot Password?",
//                                    style: TextStyle(
//                                      color: Colors.blue,
//                                    ),
//                                  ),
//                                ),
//                                onTap: (){
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
//                                  );
//                                },
//                              ),

                              SizedBox(height: 16.0,),

                              // Button
                              InkWell(
                                child: Container(
                                  height: 55.0,
                                  padding: EdgeInsets.all(12.0),
                                  color: Colors.blue,
                                  child: Center(
                                    child: loginIsTapped? Center(
                                        child: SizedBox(
                                          width: 20.0,
                                          height: 20.0,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.white,

                                            valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
                                            strokeWidth: 3.0,
                                          ),
                                        )
                                    ):Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),

                                onTap: () async {

                                  if (emailController.text == "" || passwordController.text == ""){
                                    _showToast(context, 'One or more feild(s) are empty');
                                  } else{

                                    setState(() {
                                      loginIsTapped = loginIsTapped? false:true;
                                    });

                                    // String _email = "customer2@ord.com";
                                    // String _password = "secret";
                                    String _email = emailController.text;
                                    String _password = passwordController.text;



                                    Future<LoginModel> loginResponse = _login.login(_email, _password);

                                    loginResponse.then((loginModel) async {
                                      SharedPreferences userData = await SharedPreferences.getInstance();
                                      String userJSON = jsonEncode(loginModel);
                                      userData.setString('token', loginModel.token.toString());
                                      userData.setInt('user_id', loginModel.user.id);
                                      userData.setString('user_name', loginModel.user.name.toString());
                                      var tokenn = userData.getString('token');
                                      print(tokenn);

                                      userData.remove(userKey);
                                      userData.setString(
                                          userKey, userJSON);
                                      String text = loginModel.token
                                          .toString();
                                      print(loginModel.user.userType
                                          .toLowerCase());

                                      switch(loginModel.user.userType){
                                        case "User":
                                          Navigator.pushReplacementNamed(context, '/btl_records');
//                                                  Navigator.pushReplacementNamed(context, '/dashboard');
                                          break;
                                        default:
                                          _showToast(context, 'Some error occurred please try again later');

                                      }
//                                                  Navigator.push(context,
//                                                    MaterialPageRoute(
//                                                        builder: (context) =>
//                                                            Btl_Record_List()),);

                                    }).catchError((error){
                                      _showToast(context, error);

                                    }).whenComplete((){
                                      setState(() {
                                        loginIsTapped = false;

                                      });
                                    });

                                  }
                                },

                              ),
                            ],

                          ),
                        ),
                      ),
                    ),
                  ),
                  //here code



                ],
              );

            }
        )

    );
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }
}

//class InputBox extends StatelessWidget {
//  const InputBox({
//    Key key,
//    @required this.textController, this.hint, this.icon, this.isPassword,
//  }) : super(key: key);
//
//  final TextEditingController textController;
//  final String hint;
//  final IconData icon;
//  final bool isPassword;
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: EdgeInsets.symmetric(horizontal: 4.0),
//      decoration: BoxDecoration(
//        border: Border.all(color: Colors.black),
//      ),
//      child: Row(
//        children: <Widget>[
//
//          Padding(
//            padding: const EdgeInsets.all(4.0),
//            child: Icon(
//              icon,
//            ),
//          ),
//
//          Flexible(
//            child: TextField(
//              enableInteractiveSelection: false,
//              autofocus: false,
//              autocorrect: false,
//              obscureText: isPassword,
//              controller: textController,
//              decoration: InputDecoration(
//                border: InputBorder.none,
//                hintText: hint,
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}

//class TextField extends StatelessWidget {
//  const TextField({
//    Key key,
//    @required this.textController, this.hint, this.icon, this.isPassword, this.decoration, this.style,
//  }) : super(key: key);
//
//  final TextEditingController textController;
//  final String hint;
//  final IconData icon;
//  final bool isPassword;
//  final InputDecoration decoration;
//  final TextStyle style;
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: EdgeInsets.symmetric(horizontal: 4.0),
//      decoration: BoxDecoration(
////        border: Border.all(color: Colors.black),
//      ),
//      child: Row(
//        children: <Widget>[
//
////          Padding(
////            padding: const EdgeInsets.all(4.0),
////            child: Icon(
////              icon,
////            ),
////          ),
//
//          Flexible(
//            child: TextField(
//              style: Theme.of(context).textTheme.headline6,
//              textController: textController,
//              decoration: InputDecoration(
//                border: InputBorder.none,
//                hintText: hint,
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
import 'dart:convert';
import 'dart:io';
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssepnew/consts.dart';
import 'package:ssepnew/models/loginModel.dart';
import 'package:ssepnew/screens/LoginScreen.dart';
import 'package:ssepnew/screens/btl_records.dart';
import 'package:ssepnew/screens/welcomePage.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  await FlutterDownloader.initialize(
      debug: false); // set true to enable printing logs to console
  await Permission.storage.request();


  runApp(new  MyAppForms());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    FlutterStatusbarcolor.setStatusBarColor(Colors.grey);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return new MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }

  //   @override
  // Widget build(BuildContext context) {
  //   final textTheme = Theme.of(context).textTheme;
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //       textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
  //         bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
  //       ),
  //     ),
  //     debugShowCheckedModeBanner: false,
  //     home: WelcomePage(),
  //   );
  // }
}

class MyAppForms extends StatelessWidget {

  Future<SharedPreferences> sharedPreferences() async => await SharedPreferences.getInstance();
  bool isLogged = false;
  String route = '/login';

  @override
  Widget build(BuildContext context) {

    return new FutureBuilder<SharedPreferences>(
        future: sharedPreferences(),
        builder: (context, snapshot) {

          if (snapshot.hasData && snapshot !=null){

            isLogged = snapshot.data.containsKey(userKey);

            if (isLogged){
              Map userMap = jsonDecode(snapshot.data.getString(userKey));
              LoginModel userData = LoginModel.fromJson(userMap);

              switch (userData.user.userType) {
                case "User":
                  route = '/btl_records';
                  break;


                default:
                  route = '/login';



              }
            }

            return MaterialApp(

              title: 'SSEP',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColorLight: Colors.black,
                accentColor: Color(0xFFF9F8F4),
                buttonColor: Color(0xFF333333),
                backgroundColor: Color(0xFFF9F8F4),
                // appBarTheme: ,

                iconTheme: IconThemeData(
                  color: Colors.black,
                ),

                tabBarTheme: TabBarTheme(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black26,
                  labelPadding: EdgeInsets.only(top: 32.0),
                  indicator: ShapeDecoration(
                    shape: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, style: BorderStyle.solid),
                    ),
                  ),
                ),
                scaffoldBackgroundColor: Color(0xFFF9F8F4),

                textTheme: TextTheme(
                  headline: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              routes: <String, WidgetBuilder>{
                '/login'  : (BuildContext context) => new WelcomePage(),
                '/btl_records' : (BuildContext context) => new Btl_Record_List(),


//                '/customer' : (BuildContext context) => new AddUser(),

//                '/customer/order_history' : (BuildContext context) => new OrderHistory(),
//                '/customer/maintainance_history' : (BuildContext context) => new MaintainanceHistoryScreen(),
//                '/coldstorage' : (BuildContext context) => new AssignedOrderScreen(),
//                '/coldstorage/order_history' : (BuildContext context) => new ColdStorageHistoryScreen(),
//                '/driver' : (BuildContext context) => new DriverScreen(),
//                '/driver/order_history' : (BuildContext context) => new DriverHistoryScreen(),
//                '/maintenance' : (BuildContext context) => new MaintainaceScreen(),
//                '/maintenance/history' : (BuildContext context) => new MaintenanceManHistory(),
              },

              initialRoute: route,
              // initialRoute: isLogged? '/customer' : '/login',
              // home: LoginScreen(),
            );
          } else {
            return Container(height: 0,width: 0,);
            // return Scaffold(
            //   body: Container(
            //     color: Color(0xFFCCCCCC),
            //     child: Center(
            //       child: Text(
            //         'WELCOME BACK',
            //         style: TextStyle(
            //           fontSize: 32.0,
            //           color: Colors.black,
            //         ),
            //       ),
            //     ),
            //   ),
            // );
          }
        }
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


import 'package:google_fonts/google_fonts.dart';
import 'package:ssepnew/consts.dart';
import 'package:ssepnew/main.dart';
import 'package:ssepnew/screens/Dashboard_web.dart';
import 'package:ssepnew/screens/LoginScreen.dart';
import 'package:ssepnew/screens/check_internet.dart';
import 'package:ssepnew/themes.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  String _url = "http://ssep.pk/login";
  int checkInt = 0;
  bool isActive;

  var options = InAppBrowserClassOptions(
      crossPlatform:
      InAppBrowserOptions(toolbarTopBackgroundColor: Colors.blue),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true,
          cacheEnabled: true,
          transparentBackground: true,
        ),
      ));

  @override
  void initState() {
    super.initState();
    Future<int> a = CheckInternet().checkInternetConnection();
    a.then((value) {
      if (value == 0) {
        setState(() {
          checkInt = 0;
        });
        print('No internet connect');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No internet connection!'),
        ));
      } else {
        setState(() {
          checkInt = 1;
        });
        print('Internet connected');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Connected to the internet'),
        ));
      }
    });
  }


  Widget btn_fieldOfficer() {
    return  Material(
        color:  Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
    child:InkWell(
      splashColor: themeYellow,
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(5)),
        //     boxShadow: <BoxShadow>[
        //       BoxShadow(
        //           color: Color(0xffdf8e33).withAlpha(100),
        //           offset: Offset(2, 4),
        //           blurRadius: 8,
        //           spreadRadius: 2)
        //     ],
        //     ),
        child: Text(
          'Login with field Officer',
          style: TextStyle(fontSize: 20, color: themeblue),
        ),

      ),
    )
        );
  }

  Widget btn_OtherUser() {
    return Material(
      color: themeblue,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      child:InkWell(
        splashColor: themeYellow,
        onTap: () {

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => WebExampleTwo(url: _url),
              ));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // boxShadow: <BoxShadow>[
            //   BoxShadow(
            //       color: Color(0xffdf8e33).withAlpha(100),
            //       offset: Offset(2, 4),
            //       blurRadius: 8,
            //       spreadRadius: 2)
            // ],
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.white, width: 2),

          ),
          child: Text(
            'Login with Other Users',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      )
    );

  }



  Widget _logo() {
    return  Container(
      child:SizedBox(
        width: MediaQuery.of(context).size.width/2,
        child:Image.asset(
          'assets/Solar_Logo.png',
        ),
      )

    );

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFFFFF), Color(0xFFB2B3B6)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _logo(),
              SizedBox(
                height: 80,
              ),
              btn_fieldOfficer(),
              SizedBox(
                height: 20,
              ),
              btn_OtherUser(),
              // SizedBox(
              //   height: 50,
              // ),
              InkWell(
                onTap: () {}, // needed
                child: Ink( // use Ink
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    )
    ) ;
  }
}

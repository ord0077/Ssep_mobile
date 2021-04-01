import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  
  final emailController = TextEditingController();
  
  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Forgot Password",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      
      body: Builder(
        builder: (context) {
          return Stack(
            children: <Widget>[
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.6,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Text(
                          "Instructions on how to reset your password will be sent onto the entered email address.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),

                        ),
                        
                        SizedBox(height: 16.0,),

                        // Input textfields for email
                        TextField(
                          controller: emailController,
                          style: TextStyle(color: Colors.white),

                          decoration: new InputDecoration(

                            labelStyle: TextStyle(
                                color: Colors.white
                            ),
                            errorStyle: TextStyle(
                                color: Colors.red
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            prefixIcon: Icon(Icons.person_outline,color: Colors.white),
                            labelText: 'Email',
                            hintText: "Enter your email",
                            hintStyle: TextStyle(color: Colors.white70),

                          ),
                        ),
                        
                        SizedBox(height: 16.0,),

                        // Button
                        InkWell(
                          child: Container(
                            height: 55.0,

                            padding: EdgeInsets.all(12.0),
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                "Send",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17
                                ),
                              ),
                            ),
                          ),

                          onTap: (){
                            
                            if (emailController.text == "")
                              _showToast(context);
                            else
                              print("Email: ${emailController.text}");
                          },

                        ),

                      ],

                    ),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('No email address entered'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
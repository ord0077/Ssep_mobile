import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DialogState {
  LOADING,
  COMPLETED,
  DISMISSED,
}
enum F_DialogState {
  LOADING,
  Failed,
  DISMISSED,
}
class MyDialog extends StatelessWidget {
  final DialogState state;
  MyDialog({this.state});

  @override
  Widget build(BuildContext context) {
    return state == DialogState.DISMISSED
        ? Container()
        : AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      content: Container(
        width: 250.0,
        height: 100.0,
        child: state == DialogState.LOADING
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Exporting...",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  color: Color(0xFF5B6978),
                ),
              ),
            )
          ],
        )
            : Center(
          child: Text('Data has been successfully uploaded'),

        ),
      ),

    );
  }

}



class FailureDialog extends StatelessWidget {
  final  F_DialogState state;
  FailureDialog({this.state});

  @override
  Widget build(BuildContext context) {
    return state == F_DialogState.DISMISSED
        ? Container()
        : AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      content: Container(
        width: 250.0,
        height: 100.0,
       child:  Center(
          child: Text('Failed to Load Data'),
        ),
      ),
    );

  }
}
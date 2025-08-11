import 'package:flutter/material.dart';

class Loading {
  static bool isShow = false;
  static show(BuildContext context) {
    if(!isShow){
      isShow=true;
    }
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  static hide(BuildContext context){
    if(isShow){
      Navigator.pop(context);
      isShow=false;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ZBToast {

  static show(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black.withAlpha(200),
        textColor: Colors.white,
        fontSize: 30.0);
  }

  static hiden(){
    Fluttertoast.cancel();
  }

  //使用有问题
  static flutterShow(String text ,BuildContext context,) {
    Scaffold.of(context).showSnackBar(SnackBar(content:Text(text)));
  }
}

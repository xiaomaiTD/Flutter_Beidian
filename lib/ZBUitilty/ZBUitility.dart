// Step 7 (Final): Change the app's theme

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class ZBDevice {


    static Size size(BuildContext context) {
      return  MediaQuery.of(context).size;
    }

    static double width(BuildContext context) {
      return ZBDevice.size(context).width;
    }
    
     static double height(BuildContext context) {
      return ZBDevice.size(context).height;
    }

    static double scaleHeight(double value,BuildContext context) {
      return ZBDevice.width(context) / 750 * value;
    }
  
}

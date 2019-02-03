// Step 7 (Final): Change the app's theme

import 'package:flutter/material.dart';
import 'ZBUIKit/ZBTabbar.dart';

// void main() {
//   runApp(BDHomeWidget());
// }

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Flutter bottomNavigationBar',
      theme:ThemeData.light(),
      home:ZBTabBarWidget()
    );
  }
}
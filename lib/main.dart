import 'package:flutter/material.dart';
import 'base/BRMaterialApp.dart';
import 'config/BRColor.dart';
import 'widgets/WidgetHomeBottomBar.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new BRMaterialApp().getAppTheme(new WidgetHomeBottomBar());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_app/screens/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MaterialApp(
    home: MyHome(),
    debugShowCheckedModeBanner: false,
  ));
}

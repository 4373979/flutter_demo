import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/home/home_page.dart';
import 'package:flutter_demo/pages/login/login.dart';


Map<String, WidgetBuilder> routes() => {
    '/login': (context) => LoginPage(),
  };

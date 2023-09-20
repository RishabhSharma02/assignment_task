import 'package:assign_task/views/fill_name.dart';
import 'package:assign_task/views/admin_user.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return  RoleScreen();
              },
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Image.asset("assets/logo.jpg",
                  width: 84, height: 88, fit: BoxFit.cover),
            ),
            Image.asset("assets/SchoolPen2.png", fit: BoxFit.cover),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: CircularProgressIndicator(
                color: Color(0xff9163D7),
              ),
            )
          ],
        ),
      ),
    );
  }
}

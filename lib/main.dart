import 'package:flutter/material.dart';
import 'package:googlemap/HomePage.dart';
import 'package:googlemap/convert_latlong_to_address.dart';
import 'package:googlemap/get_current_location.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home : GetCurrentLocation(),
    );
  }
}

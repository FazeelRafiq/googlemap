import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(30.191702, 71.443865),
    zoom: 14,
  );

   List<Marker> _markers = <Marker>[];
   List<Marker> _list = <Marker>[
     Marker(markerId: MarkerId('1'),
     position: LatLng(30.191702, 71.443865),
       infoWindow: InfoWindow(
         title: 'My Position'
       )
     ),
     Marker(markerId: MarkerId('2'),
     position: LatLng(31.191702, 73.443865),
       infoWindow: InfoWindow(
         title: 'My 2nd Position'
       )
     )
   ];

   void initState (){
     super.initState();
     _markers.addAll(_list);
   }


   @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(_markers),
          initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
        },
        mapType: MapType.normal,
        compassEnabled: true,
        myLocationEnabled: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(

        backgroundColor: Colors.white,
        onPressed:  () async{
        GoogleMapController controller  = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(30.191702, 71.443865,

        ),
        zoom: 14,
        ))
        );

        },
      child: Icon(Icons.location_searching,color: Colors.black),
      ),
    );
  }
}

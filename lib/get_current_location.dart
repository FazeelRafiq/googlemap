
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GetCurrentLocation extends StatefulWidget {
  const GetCurrentLocation({Key? key}) : super(key: key);

  @override
  State<GetCurrentLocation> createState() => _GetCurrentLocationState();
}

class _GetCurrentLocationState extends State<GetCurrentLocation> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePixel = CameraPosition(
    target: LatLng(33.6844, 73.0749),
    zoom: 14,
  );

  static const Marker _initialMarker = Marker(
    markerId: MarkerId('1'),
    position: LatLng(33.6844, 73.0749),
    infoWindow: InfoWindow(title: 'Title of Marker'),
  );

  List<Marker> _markers = [_initialMarker];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: false,
        desiredAccuracy: LocationAccuracy.best,
      );
      print('Current Location: ${position.latitude}, ${position.longitude}');

      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('2'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: InfoWindow(title: 'My Current Location'),
          ),
        );
      });

      _moveCameraToUserLocation(position.latitude, position.longitude);
    } catch (error) {
      print('Error fetching location: $error');
    }
  }


  Future<void> _loadData() async {
    await _getUserLocation();
  }

  void _moveCameraToUserLocation(double latitude, double longitude) {
    _controller.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newLatLng(LatLng(latitude, longitude)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
        centerTitle: true,
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: _kGooglePixel,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: _getUserLocation,
        child: Icon(Icons.location_searching, color: Colors.black),
      ),
    );
  }
}

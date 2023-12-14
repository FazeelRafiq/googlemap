import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
class LatLongAdress extends StatefulWidget {
  const LatLongAdress({super.key});

  @override
  State<LatLongAdress> createState() => _LatLongAdressState();
}

class _LatLongAdressState extends State<LatLongAdress> {
  String stAdress = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latlong to Address'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAdress),
          GestureDetector(
            onTap: () async{
              final query = "1600 Amphiteatre Parkway, Mountain View";
              var addresses = await Geocoder.local.findAddressesFromQuery(query);
              var second = addresses.first;
              print("${second.featureName} : ${second.coordinates}");

              final cordinates = new Coordinates(30.192362773335745, 71.44309820000001);
              var address = await Geocoder.local.findAddressesFromCoordinates(cordinates);
              var first = address.first;
              print("Address : "+first.featureName.toString()+first.addressLine.toString());
              setState(() {
                stAdress = first.featureName.toString()+" "+first.addressLine.toString();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green
                ),
                child: Text('Convert Latlong to Address'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

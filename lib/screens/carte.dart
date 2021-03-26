import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lorem_ipsum/widgets.dart';

class Carteclass extends StatefulWidget {
  @override
  _CarteclassState createState() => _CarteclassState();
}

class _CarteclassState extends State<Carteclass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Map"),
      // ),
      body: Stack(
        children: [
          FutureWidget<Position>(
            future: Geolocator.getCurrentPosition(),
            builder: (context, data) => GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(data.latitude, data.longitude),
                zoom: 8,
              ),
              markers: {
                Marker(
                  markerId: MarkerId(
                    "myPos",
                  ),
                  position: LatLng(data.latitude, data.longitude),
                ),
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              8,
              MediaQuery.of(context).viewPadding.top + 8,
              8,
              0,
            ),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "Map",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

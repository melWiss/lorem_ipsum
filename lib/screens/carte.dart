import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lorem_ipsum/fire.dart';
import 'package:lorem_ipsum/models/user.dart';
import 'package:lorem_ipsum/widgets.dart';

class Carteclass extends StatefulWidget {
  @override
  _CarteclassState createState() => _CarteclassState();
}

class _CarteclassState extends State<Carteclass> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> mrks;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureWidget<Set<Marker>>(
            future: qawini.getFriendsPositions(),
            builder: (context, markers) {
              return StreamWidget<Position>(
                stream: Geolocator.getPositionStream(),
                builder: (context, position) {
                  markers.add(
                    Marker(
                      markerId: MarkerId(
                        "myPos",
                      ),
                      position: LatLng(position.latitude, position.longitude),
                    ),
                  );
                  mrks = markers;
                  print(markers);
                  qawini.updateUserPosition(
                      GeoPoint(position.latitude, position.longitude));
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 8,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      if (!_controller.isCompleted)
                        _controller.complete(controller);
                    },
                    markers: markers,
                  );
                },
              );
            },
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              8,
              MediaQuery.of(context).viewPadding.top + 8,
              8,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Material(
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
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  child: FutureWidget<Profile>(
                    future: qawini.getUserData(),
                    builder: (context, profile) {
                      List l = profile.emergencyUsers;
                      return ListView.builder(
                        itemCount: l.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: InkWell(
                              onTap: () {
                                var p = mrks.where((element) =>
                                    element.markerId.value == l[index]['uid']);
                                _controller.future.then((c) {
                                  c.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: LatLng(
                                          p.first.position.latitude,
                                          p.first.position.longitude,
                                        ),
                                        zoom: 14,
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: Card(
                                child: Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width * .3,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.person),
                                        Text(
                                          l[index]['nickname'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lorem_ipsum/models/temoignage.dart';
import 'package:lorem_ipsum/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:telephony/telephony.dart';

class QawiniFirebase {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  QawiniFirebase();

  /// this function let's user to login to his account.
  Future signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  /// this function let's user to create a new account.
  Future registerWithEmailAndPassword(
      String email, String password, Profile profile) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var ref = firestore.collection("users").doc(userCredential.user.uid);
      profile.uid = userCredential.user.uid;
      profile.emergencyNumbers = [];
      await ref.set(profile.toMap());
      await signInWithEmail(email, password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  /// this function let's user to sign out form the app.
  logOut() {
    auth.signOut();
  }

  /// this function gets user data from the cloud.
  Future<Profile> getUserData({String uid}) async {
    var ref = firestore.collection("users").doc(uid ?? auth.currentUser.uid);
    var data = await ref.get();
    return Profile.fromMap(data.data());
  }

  /// this function gets user data as a stream.
  Stream<Profile> getUserDataStream({String uid}) async* {
    var ref = firestore.collection("users").doc(uid ?? auth.currentUser.uid);
    var snaps = ref.snapshots();
    await for (var snap in snaps) {
      var user = Profile.fromMap(snap.data());
      yield user;
    }
  }

  /// update the user data
  Future updateUserData(Profile profile) async {
    var ref = firestore.collection("users").doc(profile.uid);
    await ref.update(profile.toMap());
  }

  /// add an emergency number
  Future addEmergencyNumber(String number) async {
    var user = await getUserData();
    user.emergencyNumbers = user.emergencyNumbers ?? [];
    user.emergencyNumbers.add(number);
    await updateUserData(user);
  }

  /// fetch Testimonies in a Stream format
  Stream<List<Testimony>> streamTestemonies() async* {
    var ref = firestore.collection("testimonies").snapshots();
    await for (var snap in ref) {
      List<Testimony> testies =
          List<Testimony>.generate(snap.docs.length, (index) {
        return Testimony.fromMap(snap.docs[index].data());
      });
      yield testies;
    }
  }

  /// share a testimony with the community
  Future shareTestimony(bool anonym, String text) async {
    var ref = firestore.collection("testimonies").doc();
    var profile = await getUserData();
    Testimony testimony = Testimony(
      text: text,
      uid: profile.uid,
      nickname: profile.nickname,
      anonymous: anonym,
      dateTime: DateTime.now(),
    );
    await ref.set(testimony.toMap());
  }

  /// this function makes relation between two users through the qr code scan
  Future makeRelation(String frienduid) async {
    var me = await getUserData();
    var friend = await getUserData(uid: frienduid);
    me.emergencyUsers = me.emergencyUsers ?? [];
    friend.emergencyUsers = friend.emergencyUsers ?? [];
    me.emergencyUsers.add({
      'uid': frienduid,
      'nickname': friend.nickname,
    });
    friend.emergencyUsers.add({
      'uid': me.uid,
      'nickname': me.nickname,
    });
    await updateUserData(me);
    await updateUserData(friend);
  }

  /// this function notifies all subscribed users to this current user that he is in danger.
  Future saveMe() async {
    const baseUrl = 'https://boiling-sands-07802.herokuapp.com/notify';
    var user = await getUserData();
    var response = await http.post(
      baseUrl,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "topic": auth.currentUser.uid,
          "notification": {
            "title": "Save Me!",
            "body": "${user.nickname} is in danger!",
          },
        },
      ),
    );
    print(response);
    var location = await Geolocator.getCurrentPosition();
    var mapsUrl = "https://www.google.com/maps/dir/?api=1&destination=";
    Telephony telephony = Telephony.instance;
    user.emergencyNumbers.forEach((element) {
      telephony.sendSms(
          to: element,
          message:
              "Help me I'm in danger! my location is $mapsUrl${location.latitude},${location.longitude}");
    });
  }

  /// this function updates user position in the database.
  Future<void> updateUserPosition(GeoPoint geoPoint) async {
    var ref = firestore.collection("positions").doc(auth.currentUser.uid);
    try {
      await ref.update(<String, dynamic>{
        "position": geoPoint,
        "uid": auth.currentUser.uid,
      });
    } catch (e) {
      await ref.set(<String, dynamic>{
        "position": geoPoint,
        "uid": auth.currentUser.uid,
      });
    }
  }

  /// this function get friend's locations in the map
  Future<Set<Marker>> getFriendsPositions() async {
    Set<Marker> markers = {};
    var user = await getUserData();
    try {
      var l = [];
      user.emergencyUsers.forEach((element) {
        l.add(element['uid']);
      });
      var ref = await firestore
          .collection("positions")
          .where("uid", whereIn: l)
          .get();
      ref.docs.forEach((element) {
        markers.add(
          Marker(
            markerId: MarkerId(element.id),
            position: LatLng(
              (element.data()['position'] as GeoPoint).latitude,
              (element.data()['position'] as GeoPoint).longitude,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRose,
            ),
          ),
        );
      });
      return markers;
    } catch (e) {
      throw e;
    }
  }
}

var qawini = QawiniFirebase();

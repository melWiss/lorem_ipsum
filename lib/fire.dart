import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lorem_ipsum/models/temoignage.dart';
import 'package:lorem_ipsum/models/user.dart';

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
}

var qawini = QawiniFirebase();

import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String uid;
  String nickname;
  String email;
  List emergencyNumbers;
  DateTime birthday;

  Profile({
    this.birthday,
    this.nickname,
    this.email,
    this.uid,
    this.emergencyNumbers,
  });

  Profile.fromMap(Map<String, dynamic> map) {
    this.birthday = map['birthday'].toDate();
    this.nickname = map['nickname'];
    this.email = map['email'];
    this.uid = map['uid'];
    this.emergencyNumbers = map['emergencyNumbers'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'nickname': this.nickname,
      'email': this.email,
      'birthday': Timestamp.fromDate(this.birthday),
      'emergencyNumbers': this.emergencyNumbers,
    };
  }
}

// Profile user = Profile(
//   birthday: DateTime.utc(1997, 2, 2),
//   nickname: "biba",
//   uid: "someuserid123654789",
//   email: "hamamamal@ggg.com",
//   emrgencyNumbers: [
//     "25616567",
//     "93184370",
//     "99001250",
//     "41220320",
//     "28616567",
//   ],
// );

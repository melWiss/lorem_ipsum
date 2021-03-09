class User {
  String uid;
  String nickname;
  String imgUrl;
  List<String> emrgencyNumbers;
  DateTime birthday;

  User({
    this.birthday,
    this.imgUrl,
    this.nickname,
    this.uid,
    this.emrgencyNumbers,
  });

  User.fromMap(Map<String, dynamic> map) {
    this.birthday = map['birthday'];
    this.imgUrl = map['imgUrl'];
    this.nickname = map['nickname'];
    this.uid = map['uid'];
    this.emrgencyNumbers = map['emergencyNumbers'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'nickname': this.nickname,
      'imgUrl': this.imgUrl,
      'birthday': this.birthday,
      'emrgencyNumbers': this.emrgencyNumbers,
    };
  }
}

User user = User(
  imgUrl:
      'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
  birthday: DateTime.utc(1997, 2, 2),
  nickname: "biba",
  uid: "someuserid123654789",
  emrgencyNumbers: [
    "25616567",
    "93184370",
    "99001250",
    "41220320",
    "28616567",
  ],
);

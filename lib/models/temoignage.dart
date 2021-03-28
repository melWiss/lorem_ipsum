import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Testimony {
  String uid;
  String nickname;
  String text;
  bool anonymous;
  DateTime dateTime;

  Testimony(
      {this.anonymous, this.text, this.uid, this.nickname, this.dateTime});

  Testimony.fromMap(Map<String, dynamic> map) {
    this.anonymous = map['anonymous'];
    this.text = map['text'];
    this.uid = map['uid'];
    this.nickname = map['nickname'];
    this.dateTime = map['dateTime'].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'nickname': this.nickname,
      'text': this.text,
      'anonymous': this.anonymous,
      'dateTime': Timestamp.fromDate(this.dateTime),
    };
  }
}

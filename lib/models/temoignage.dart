import 'package:lorem_ipsum/temoignage.dart';

class TemoignageModel {
  String uid;
  String text;
  bool anonymous;

  TemoignageModel({this.anonymous, this.text, this.uid});

  TemoignageModel.fromMap(Map<String, dynamic> map) {
    this.anonymous = map['anonymous'];
    this.text = map['text'];
    this.uid = map['uid'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'text': this.text,
      'anonymous': this.anonymous,
    };
  }
}

List<TemoignageModel> temoignages = List<TemoignageModel>.generate(
  10,
  (index) => TemoignageModel(
    anonymous: true,
    text:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce tempus tristique ornare. Nulla pulvinar non massa sit amet porttitor. Fusce sagittis nisi leo, at auctor metus facilisis eu. Sed id sem ut dui varius faucibus a tempus diam. Vivamus scelerisque ex egestas efficitur dignissim. Nunc maximus felis vitae mollis efficitur. Proin in eros sagittis, convallis sapien viverra, semper metus. Donec accumsan, metus vulputate volutpat ultrices, risus nibh imperdiet enim, ut viverra augue tellus id augue. Proin nec lectus ullamcorper, suscipit augue ut, faucibus enim. Curabitur eget cursus nisl. Nam quis interdum eros, eget pellentesque urna. $index',
    uid: 'user001',
  ),
);

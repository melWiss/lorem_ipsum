import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lorem_ipsum/fire.dart';
import 'package:lorem_ipsum/models/user.dart';
import 'package:lorem_ipsum/widgets.dart';

class Registrationscreen extends StatefulWidget {
  @override
  _RegistrationscreenState createState() => _RegistrationscreenState();
}

class _RegistrationscreenState extends State<Registrationscreen> {
  DateTime dateTime = DateTime.now();
  String nickname = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  Profile profile = Profile();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: mq.viewPadding.top,
            ),
            child: BannerLogo(),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Material(
                color: Colors.pink[100],
                elevation: 100,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Registration',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Nickname',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => nickname = value,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => email = value,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                          ),
                          obscureText: true,
                          onChanged: (value) => password = value,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'confirm password',
                          ),
                          obscureText: true,
                          onChanged: (value) => confirmPassword = value,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Text(
                                  'Pick your age:',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              OutlinedButton(
                                child: Text(
                                  dateTime.toString().substring(0, 10),
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () async {
                                  dateTime = await showDatePicker(
                                      context: context,
                                      initialDate: dateTime,
                                      firstDate: DateTime(1970),
                                      lastDate: DateTime(2100));
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                child: !loading
                                    ? Text("submit")
                                    : CircularProgressIndicator(),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white, // background
                                  onPrimary: Colors.pink[900], // foreground
                                ),
                                onPressed: () {
                                  if (!loading &&
                                      nickname.isNotEmpty &&
                                      email.isNotEmpty &&
                                      password.isNotEmpty &&
                                      password == confirmPassword) {
                                    print("registring...");
                                    profile.nickname = nickname;
                                    profile.birthday = dateTime;
                                    profile.email = email;
                                    qawini
                                        .registerWithEmailAndPassword(
                                            email, password, profile)
                                        .whenComplete(() => setState(() {
                                              loading = false;
                                              Navigator.of(context).pop();
                                            }))
                                        .catchError((err) {
                                      print(err.toString());
                                      setState(() {
                                        loading = false;
                                      });
                                    });
                                    setState(() {
                                      loading = true;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

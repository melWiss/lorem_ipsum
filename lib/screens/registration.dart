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
      backgroundColor: Colors.white,
      body: BackgroundWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QawiniLogo(
              mq: mq,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Material(
                clipBehavior: Clip.antiAlias,
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Colors.purple,
                      Colors.pink,
                      Colors.orangeAccent,
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Register",
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
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
                      ElevatedButton(
                        child: !loading
                            ? Text("submit")
                            : CircularProgressIndicator(),
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
                  padding: EdgeInsets.all(20),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Go Back"),
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lorem_ipsum/fire.dart';
import 'package:lorem_ipsum/widgets.dart';
import 'registration.dart';

class Loginscreen extends StatefulWidget {
  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  String email = "";
  String password = "";
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
          Padding(
            padding: EdgeInsets.fromLTRB(50, 100, 50, 10),
            child: Material(
              color: Colors.pink[100],
              elevation: 100,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                child: Column(
                  children: [
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: !loading
                                ? Text("Sign In")
                                : CircularProgressIndicator(),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white, // background
                              onPrimary: Colors.pink[900], // foreground
                            ),
                            onPressed: () async {
                              if (!loading &&
                                  email.isNotEmpty &&
                                  password.isNotEmpty) {
                                qawini
                                    .signInWithEmail(email, password)
                                    .whenComplete(() => setState(() {
                                          loading = false;
                                        }))
                                    .catchError((onError) {
                                  setState(() {
                                    print(onError.toString());
                                    loading = false;
                                  });
                                });
                                setState(() {
                                  loading = true;
                                });
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Registrationscreen();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "create account",
                              ),
                              style:
                                  TextButton.styleFrom(primary: Colors.black87),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                padding: EdgeInsets.all(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

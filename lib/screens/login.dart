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
                    children: [
                      Text(
                        "Sign In",
                        style: Theme.of(context).textTheme.headline4,
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
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: !loading
                                ? Text("Sign In")
                                : CircularProgressIndicator(),
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
                          ElevatedButton(
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
                              "Register",
                            ),
                          ),
                          ElevatedButton(
                            child: Text("Reset Password"),
                            onPressed: () {
                              qawini.passwordReset(email).whenComplete(() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Password reset mail has been sent.",
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

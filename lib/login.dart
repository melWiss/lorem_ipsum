import 'package:flutter/material.dart';
import 'package:lorem_ipsum/registration.dart';

class Loginscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Placeholder(
            fallbackHeight: 100,
            strokeWidth: 5,
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
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("Sign In"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white, // background
                              onPrimary: Colors.pink[900], // foreground
                            ),
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

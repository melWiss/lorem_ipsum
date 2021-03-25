import 'package:flutter/material.dart';

class Emergencyclass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: InkWell(
                onTap: () {},
                child: Material(
                  elevation: 4,
                  color: Colors.pink,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 80,
                    ),
                    child: Text(
                      "help me",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              child: Text(
                "Emergency call",
                style: TextStyle(fontSize: 40, color: Colors.black),
              ),
              padding: EdgeInsets.all(20),
            )
          ],
        ),
      ),
      backgroundColor: Colors.pink.shade100,
    );
  }
}

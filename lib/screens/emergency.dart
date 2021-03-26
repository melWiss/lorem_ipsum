import 'package:flutter/material.dart';

class Emergencyclass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency"),
      ),
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
                      vertical: 75,
                    ),
                    child: Text(
                      "help me",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              child: Text(
                "Emergency call",
                style: Theme.of(context).textTheme.headline4,
              ),
              padding: EdgeInsets.all(20),
            )
          ],
        ),
      ),
    );
  }
}

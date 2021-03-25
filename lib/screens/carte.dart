import 'package:flutter/material.dart';

class Carteclass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink.shade100,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Placeholder(
                fallbackHeight: 600,
              )
            ],
          ),
        ));
  }
}

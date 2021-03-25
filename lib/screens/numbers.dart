import 'package:flutter/material.dart';
import 'package:lorem_ipsum/widgets.dart';

class Numberscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Placeholder(
            //   fallbackHeight: 100,
            //   strokeWidth: 5,
            // ),
            Padding(
              padding: EdgeInsets.only(top: mq.viewPadding.top),
              child: BannerLogo(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 20, 50, 10),
              child: Material(
                color: Colors.pink[100],
                elevation: 100,
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.pink.shade200,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Put Your Emergency Numbres',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Number n°:1',
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Number n°:2',
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Number n°=3',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text("Save"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.pink[100], // background
                              onPrimary: Colors.pink.shade300, // foreground
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

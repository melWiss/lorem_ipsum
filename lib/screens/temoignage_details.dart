import 'package:flutter/material.dart';
import 'package:lorem_ipsum/models/temoignage.dart';

class TemoignageDetails extends StatelessWidget {
  final TemoignageModel temoignage;
  TemoignageDetails({@required this.temoignage});
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 4,
                // color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 8,
                              left: 8,
                              bottom: 8,
                              right: 20,
                            ),
                            child: Icon(
                              Icons.person,
                              color: mq.platformBrightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          Text(
                            'Anonymous',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                      Text(
                        temoignage.text,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

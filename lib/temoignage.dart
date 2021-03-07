import 'package:flutter/material.dart';
import 'package:lorem_ipsum/models/temoignage.dart';
import 'package:lorem_ipsum/temoignage_details.dart';

class Temoignage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: temoignages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) =>
                    TemoignageDetails(temoignage: temoignages[index]),
              );
            },
            child: Material(
              elevation: 4,
              color: Colors.white,
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
                          child: Icon(Icons.person),
                        ),
                        Text(
                          'Anonymous',
                          style: TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                    Text(
                      temoignages[index].text,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 3,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

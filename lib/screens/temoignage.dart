import 'package:flutter/material.dart';
import 'package:lorem_ipsum/fire.dart';
import 'package:lorem_ipsum/models/temoignage.dart';
import 'package:lorem_ipsum/widgets.dart';
import 'temoignage_details.dart';

class Temoignage extends StatelessWidget {
  bool anonym = false;
  String testimonyField = "";
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Testimony"),
      ),
      body: StreamWidget<List<Testimony>>(
        stream: qawini.streamTestemonies(),
        builder: (context, data) => data.length > 0
            ? ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              TemoignageDetails(temoignage: data[index]),
                        );
                      },
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
                                      color: mq.platformBrightness ==
                                              Brightness.light
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  Text(
                                    data[index].anonymous
                                        ? 'Anonymous'
                                        : data[index].nickname,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ],
                              ),
                              Text(
                                data[index].text,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 3,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  "No testimonies available.",
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Share",
        ),
        icon: Icon(Icons.sms),
        onPressed: () {
          qawiniSheet(
            context,
            StatefulBuilder(
              builder: (context, setState) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Share a Testimony",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Divider(
                      thickness: 3,
                      indent: mq.size.width * .15,
                      endIndent: mq.size.width * .15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Write your testimony here",
                      ),
                      onChanged: (v) => testimonyField = v,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text("Anonymous"),
                              Switch(
                                value: anonym,
                                onChanged: (v) {
                                  setState(() {
                                    anonym = v;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            child: Text("Share"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              qawini.shareTestimony(anonym, testimonyField);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

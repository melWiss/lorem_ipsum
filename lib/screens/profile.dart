import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lorem_ipsum/assets.dart';
import 'package:lorem_ipsum/fire.dart';
import 'package:lorem_ipsum/models/user.dart';
import 'package:lorem_ipsum/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  String number = "";
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return StreamWidget<Profile>(
      stream: qawini.getUserDataStream(),
      builder: (context, user) {
        qawini.messaging.subscribeToTopic(user.uid);
        if (user.emergencyUsers != null)
          user.emergencyUsers.forEach((element) {
            qawini.messaging.subscribeToTopic(element['uid']);
          });
        return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: qawini.logOut,
              )
            ],
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipOval(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              color: mq.platformBrightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                              child: ClipOval(
                                child: Container(
                                  color:
                                      mq.platformBrightness == Brightness.light
                                          ? Colors.white
                                          : Colors.black,
                                  padding: EdgeInsets.all(16),
                                  child: Image.asset(
                                    mq.platformBrightness == Brightness.light
                                        ? 'assets/logo_dark.png'
                                        : 'assets/logo_light.png',
                                    height: mq.size.height * .2,
                                    width: mq.size.height * .2,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          user.nickname,
                          style: Assets.title,
                        ),
                        Text(
                          "Age: ${(DateTime.now().difference(user.birthday).inDays ~/ 366)}",
                          style: Assets.subTitle,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Column(
                      children: [
                        TabBar(
                          controller: tabController,
                          tabs: [
                            Tab(
                              text: "Numbers",
                            ),
                            Tab(
                              text: "Contacts",
                            ),
                            Tab(
                              text: "QR Me",
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              user.emergencyNumbers != null
                                  ? ListView.builder(
                                      itemCount: user.emergencyNumbers.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          trailing: Icon(Icons.phone),
                                          title: Text(
                                            user.emergencyNumbers[index],
                                            // textAlign: TextAlign.center,
                                            style: Assets.subTitle,
                                          ),
                                        );
                                      },
                                    )
                                  : Container(),
                              user.emergencyUsers != null
                                  ? ListView.builder(
                                      itemCount: user.emergencyUsers.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(
                                            user.emergencyUsers[index]
                                                ['nickname'],
                                            style: Assets.subTitle,
                                          ),
                                          trailing: Icon(Icons.person),
                                        );
                                      },
                                    )
                                  : Container(),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: SingleChildScrollView(
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            clipBehavior: Clip.antiAlias,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "QR Me",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4,
                                                  ),
                                                  QrImage(
                                                    backgroundColor:
                                                        Colors.white,
                                                    data: user.uid,
                                                    size: 250,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: QrImage(
                                  backgroundColor: Colors.white,
                                  data: user.uid,
                                  size: 200,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: Text("Number/Scan"),
            icon: Icon(Icons.add),
            onPressed: () {
              qawiniSheet(
                context,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text("Scan a Q'awini user QR Code"),
                      leading: Icon(Icons.add),
                      trailing: Icon(Icons.camera_alt),
                      onTap: () async {
                        String frienduid =
                            await FlutterBarcodeScanner.scanBarcode(
                                "#ff6666", "Cancel", true, ScanMode.QR);
                        qawini.makeRelation(frienduid);
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: Text("Add an Emergency Number"),
                      leading: Icon(Icons.add),
                      trailing: Icon(Icons.phone),
                      onTap: () {
                        qawiniSheet(
                          context,
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Add an emergency number:",
                                  style: Assets.subTitle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Divider(
                                indent: MediaQuery.of(context).size.width * .15,
                                endIndent:
                                    MediaQuery.of(context).size.width * .15,
                                thickness: 3,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    // hintText: 'Emergency Number',
                                    labelText: 'Emergency Number',
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.numberWithOptions(
                                    signed: false,
                                    decimal: true,
                                  ),
                                  onChanged: (v) {
                                    number = v;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    user.emergencyNumbers =
                                        user.emergencyNumbers ?? [];
                                    user.emergencyNumbers.add(number);
                                    qawini.addEmergencyNumber(number);
                                    Navigator.of(context).pop();
                                    setState(() {
                                      number = "";
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Submit",
                                      // style: Assets.subTitle,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

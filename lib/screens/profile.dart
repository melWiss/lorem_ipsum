import 'package:flutter/material.dart';
import 'package:lorem_ipsum/assets.dart';
import 'package:lorem_ipsum/fire.dart';
import 'package:lorem_ipsum/models/user.dart';
import 'package:lorem_ipsum/widgets.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String number = "";

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return StreamWidget<Profile>(
      stream: qawini.getUserDataStream(),
      builder: (context, user) => Scaffold(
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
                        color: mq.platformBrightness == Brightness.light
                            ? Colors.white
                            : Colors.black,
                        padding: EdgeInsets.all(12),
                        child: Image.asset(
                          mq.platformBrightness == Brightness.light
                              ? 'assets/logo_dark.png'
                              : 'assets/logo_light.png',
                          height: 150,
                          width: 150,
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
              Text(
                "Emergency Numbers:",
                style: Assets.subTitle,
              ),
              Divider(
                indent: MediaQuery.of(context).size.width * .15,
                endIndent: MediaQuery.of(context).size.width * .15,
                thickness: 3,
                color: Colors.black,
              ),
              user.emergencyNumbers != null
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: user.emergencyNumbers.length,
                        itemBuilder: (context, index) {
                          return Text(
                            user.emergencyNumbers[index],
                            textAlign: TextAlign.center,
                            style: Assets.subTitle,
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: Container(
                        width: mq.size.width,
                        child: Text(
                          "No emergency numbers found.",
                          style: Assets.subTitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Emergency Number"),
          icon: Icon(Icons.add),
          onPressed: () {
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
                      endIndent: MediaQuery.of(context).size.width * .15,
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
                          user.emergencyNumbers = user.emergencyNumbers ?? [];
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
                ));
          },
        ),
      ),
    );
  }
}

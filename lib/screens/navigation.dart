import 'package:flutter/material.dart';
import 'package:lorem_ipsum/fire.dart';
import 'package:lorem_ipsum/screens/settings.dart';
import 'carte.dart';
import 'emergency.dart';
import 'hbiba.dart';
import 'profile.dart';
import 'temoignage.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: mq.platformBrightness == Brightness.light
                ? [
                    Colors.white,
                    Colors.white,
                  ]
                : [
                    Colors.black,
                    Colors.black87,
                  ],
          ),
        ),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple,
                    Colors.pink,
                    Colors.orangeAccent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: NavigationRail(
                    leading: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).viewPadding.top,
                      ),
                      // child: Icon(
                      //   Icons.favorite,
                      //   size: 50,
                      //   color: Colors.white,
                      //   //color: Colors.black54,
                      // ),
                      child: Image.asset(
                        mq.platformBrightness == Brightness.light
                            ? 'assets/logo_light.png'
                            : 'assets/logo_dark.png',
                        height: 60,
                        width: 60,
                      ),
                    ),
                    selectedIndex: index,
                    onDestinationSelected: (i) {
                      setState(() {
                        index = i;
                      });
                    },
                    unselectedIconTheme: IconThemeData(
                      color: mq.platformBrightness == Brightness.light
                          ? Colors.black54
                          : Colors.white,
                    ),
                    selectedIconTheme: IconThemeData(
                      color: mq.platformBrightness == Brightness.light
                          ? Colors.white
                          : Colors.black87,
                    ),
                    labelType: NavigationRailLabelType.selected,
                    unselectedLabelTextStyle: TextStyle(
                      color: mq.platformBrightness == Brightness.light
                          ? Colors.black54
                          : Colors.white,
                    ),
                    selectedLabelTextStyle: TextStyle(
                      color: mq.platformBrightness == Brightness.light
                          ? Colors.white
                          : Colors.black87,
                    ),
                    backgroundColor: Colors.transparent,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.person_outlined),
                        selectedIcon: Icon(Icons.person),
                        label: Text("Profile"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.help_outlined),
                        selectedIcon: Icon(Icons.help),
                        label: Text("Emergency"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.chat_outlined),
                        selectedIcon: Icon(Icons.chat),
                        label: Text("Hbiba"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.forum_outlined),
                        selectedIcon: Icon(Icons.forum),
                        label: Text("Testimony"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.map_outlined),
                        selectedIcon: Icon(Icons.map),
                        label: Text("Carte"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.settings_outlined),
                        selectedIcon: Icon(Icons.settings),
                        label: Text("Settings"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: index,
                children: [
                  ProfileScreen(),
                  Emergencyclass(),
                  HabibaScreen(),
                  Temoignage(),
                  Carteclass(),
                  SettingsScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

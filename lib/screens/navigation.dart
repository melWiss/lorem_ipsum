import 'package:flutter/material.dart';
import 'package:lorem_ipsum/fire.dart';
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: qawini.logOut,
          ),
        ],
      ),
      backgroundColor: Colors.pink.shade100,
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: NavigationRail(
            selectedIndex: index,
            extended: true,
            onDestinationSelected: (value) {
              Navigator.of(context).pop();
              setState(() {
                index = value;
              });
            },
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Material(
                color: Colors.white,
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      "Q'awini",
                      style: TextStyle(fontSize: 25, color: Colors.pink),
                    ),
                  ),
                ),
              ),
            ),
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
                label: Text("Talk with Hbiba"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.forum_outlined),
                selectedIcon: Icon(Icons.forum),
                label: Text("Other Experiences"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.map_outlined),
                selectedIcon: Icon(Icons.map),
                label: Text("Carte"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.more_horiz_outlined),
                selectedIcon: Icon(Icons.more_horiz),
                label: Text("About"),
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: index,
        children: [
          ProfileScreen(),
          Emergencyclass(),
          HabibaScreen(),
          Temoignage(),
          Carteclass(),
          Container(
            height: 50,
            width: 50,
            color: Colors.teal,
          ),
        ],
      ),
    );
  }
}
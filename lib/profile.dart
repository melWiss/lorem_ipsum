import 'package:flutter/material.dart';
import 'package:lorem_ipsum/assets.dart';
import 'package:lorem_ipsum/models/user.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String number = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Assets.secondary,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.black,
                  child: ClipOval(
                    child: Stack(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          child: Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 48,
                            ),
                          ),
                        ),
                        Image.network(
                          user.imgUrl,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ],
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
            Expanded(
              child: ListView.builder(
                itemCount: user.emrgencyNumbers.length,
                itemBuilder: (context, index) {
                  return Text(
                    user.emrgencyNumbers[index],
                    textAlign: TextAlign.center,
                    style: Assets.subTitle,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Emergency Number"),
        icon: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Add an emergency number:",
                      style: Assets.subTitle,
                    ),
                  ),
                  Divider(
                    indent: MediaQuery.of(context).size.width * .15,
                    endIndent: MediaQuery.of(context).size.width * .15,
                    thickness: 3,
                    color: Colors.black,
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
                        user.emrgencyNumbers.add(number);
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
              );
            },
          );
        },
      ),
    );
  }
}

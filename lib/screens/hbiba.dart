import 'package:flutter/material.dart';
import 'package:lorem_ipsum/assets.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HabibaScreen extends StatefulWidget {
  @override
  _HabibaScreenState createState() => _HabibaScreenState();
}

class _HabibaScreenState extends State<HabibaScreen> {
  final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
  String message = "";
  List<String> messages = [];
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Hbiba"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  else if (snapshot.hasData) {
                    messages.insert(0, snapshot.data);
                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(messages[index]),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      height: 40,
                      width: 40,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(50),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: EdgeInsets.all(0.5),
                child: TextField(
                  controller: textEditingController,
                  onChanged: (v) {
                    message = v;
                  },
                  onSubmitted: (value) {
                    channel.sink.add(message);
                    messages.insert(0, message);
                    setState(() {
                      message = "";
                      textEditingController.clear();
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        channel.sink.add(message);
                        messages.insert(0, message);
                        setState(() {
                          message = "";
                          textEditingController.clear();
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

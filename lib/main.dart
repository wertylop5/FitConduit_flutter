import "package:flutter/material.dart";

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FitConduit",
      theme: ThemeData.dark(),
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  State createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String _popupValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fit Conduit"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                _popupValue = value;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                child: Text("About"),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Cables"),
            ListView(
              shrinkWrap: true,
            ),
            RaisedButton(
              onPressed: (){},
              child: Text("Button"),
            ),
            FlatButton(
              onPressed: (){},
              child: Text("BUTTON"),
            ),
          ],
        ),
      ),
    );
  }
}


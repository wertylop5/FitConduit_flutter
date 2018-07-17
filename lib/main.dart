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
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Cables",
              textScaleFactor: 1.5,
            ),
            Container(
              height: 300.0,
              child: ListView(),
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Text("ADD A NEW CABLE"),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text("ADD A NEW UNNAMED CABLE"),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    right: 15.0,
                  ),
                  child: Text("Select conduit type"),
                ),
                DropdownButton<String>(
                  onChanged: (String value) {},
                  items: <DropdownMenuItem<String>>[
                    DropdownMenuItem<String>(
                      child: Text("Conduit 1"),
                    ),
                    DropdownMenuItem<String>(
                      child: Text("Conduit 2"),
                    ),
                  ],
                ),
              ],
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("Calculate"),
            ),
            Text(
              "Results",
              textScaleFactor: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}


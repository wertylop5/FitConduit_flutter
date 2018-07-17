import "package:flutter/material.dart";
import "util/enums.dart";

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
  ConduitType _selectedConduit;

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
                DropdownButton<ConduitType>(
                  onChanged: (ConduitType value) {
                    setState(() {
                      _selectedConduit = value;
                    });
                  },
                  items: ConduitType.values
                      .map<DropdownMenuItem<ConduitType>>(
                          (ConduitType item) => DropdownMenuItem<ConduitType>(
                                child: Text(getConduitString(item)),
                                value: item,
                              ))
                      .toList(),
                  value: _selectedConduit,
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

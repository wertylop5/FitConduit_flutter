import "package:flutter/material.dart";
import "package:sqflite/sqflite.dart";

import "util/enums.dart";
import "util/db.dart";
import "view/cableRow.dart";
import "about.dart";

const PATH_ABOUT = "/about";

void main() {
  
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FitConduit",
      theme: ThemeData.dark(),
      home: HomeWidget(),
      routes: <String, WidgetBuilder>{
        PATH_ABOUT: (BuildContext context) => AboutWidget(),
      },
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  State createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  ConduitType _selectedConduit;
  
  //enabled when all cables are loaded
  bool _buttonsEnabled = true;

  void _openRoute(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Database>(
      future: dbOpen(),
      builder: (BuildContext context,
          AsyncSnapshot<Database> snapshot) => Scaffold(
        appBar: AppBar(
          title: Text("Fit Conduit"),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String value) {
                _openRoute(context, value);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      child: Text("About"),
                      value: PATH_ABOUT,
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
                height: 240.0,
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: ListView(
                  children: <Widget>[
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                    CableRow(),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: _buttonsEnabled ?
                      null :
                      () {},
                    child: Text("ADD A NEW CABLE"),
                  ),
                  FlatButton(
                    onPressed: _buttonsEnabled ?
                      null :
                      () {},
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
                onPressed: _buttonsEnabled ?
                      null :
                      () {},
                child: Text("Calculate"),
              ),
              Text(
                "Results",
                textScaleFactor: 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import "package:flutter/material.dart";
import "package:sqflite/sqflite.dart";

import "model/cable.dart";
import "model/conduit.dart";
import "util/enums.dart";
import "util/db.dart";
import "view/about.dart";
import "view/addCable.dart";
import "view/cableRow.dart";
import "view/defaultAppBar.dart";

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
        RoutePaths.PATH_ABOUT:
          (BuildContext context) => AboutWidget(),
        /*
        PATH_ADD_CABLE:
          (BuildContext context) => AddCableWidget(),
        PATH_ADD_CABLE_UNNAMED: 
          (BuildContext context) => AddCableUnnamedWidget(),
        */
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
  Database _db;
  List<Cable> _cables;
  List<Conduit> _conduits;
  List<CableRow> _createdCables = [];
  
  //enabled when all cables are loaded
  bool _buttonsEnabled = true;
  
  void createButtonAction(BuildContext context) async {
    /*
       form:
       {
        "cable": <Cable>,
        "amount": <int>
       }
    */
    Map createdCable = await Navigator.push(
      context,
      new MaterialPageRoute(
        maintainState: true,
        builder:
          (BuildContext context) =>
            AddCableWidget(_cables, null),
      ),
    );
    
    setState(() {
      _createdCables.add(CableRow(
        _createdCables.length,
        createdCable["cable"],
        createdCable["amount"]
      ));
    });
  }
  

  @override
  Widget build(BuildContext context) {
    //FutureBuilder<Database> base = null;
    
    return FutureBuilder<Database>(
      //writing like this so we don't need
      //to manually create a Future object
      future: dbOpen(context).then((db) async {
        print("db");
        setState(() async {
          _db = db;
          _cables = await getCables(db);
          _conduits = await getConduits(db);
        });
        return db;
      }),
      builder: (BuildContext context,
          AsyncSnapshot<Database> snapshot) => Scaffold(
        appBar: getAppbar(context, RoutePaths.PATH_ROOT),
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
                child: ListView.builder(
                  itemCount: _createdCables.length,
                  //itemExtent: 50.0,
                  itemBuilder: (BuildContext context,
                    int index) {
                    return _createdCables[index];
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: snapshot.connectionState
                      == ConnectionState.done ?
                          () async {
                            print(_createdCables.length);
                            /*
                               form:
                               {
                                "cable": <Cable>,
                                "amount": <int>
                               }
                            */
                            Map createdCable =
                              await Navigator.push(
                              context,
                              new MaterialPageRoute(
                                maintainState: true,
                                builder:
                                  (BuildContext context) =>
                                    AddCableWidget(_cables, true),
                              ),
                            );
                            
                            if (createdCable != null) {
                              setState(() {
                                 _createdCables.add(
                                   CableRow(
                                    _createdCables.length,
                                    createdCable["cable"],
                                    createdCable["amount"]
                                ));
                              });
                            }
                          } :
                          null,
                    child: Text("ADD A NEW CABLE"),
                  ),
                  FlatButton(
                    onPressed: snapshot.connectionState
                      == ConnectionState.done ?
                          //can't factor this out :/
                          () async {
                            print(_createdCables.length);
                            /*
                               form:
                               {
                                "cable": <Cable>,
                                "amount": <int>
                               }
                            */
                            Map createdCable =
                              await Navigator.push(
                              context,
                              new MaterialPageRoute(
                                maintainState: true,
                                builder:
                                  (BuildContext context) =>
                                    AddCableWidget(_cables, false),
                              ),
                            );
                            
                            if (createdCable != null) {
                              setState(() {
                                 _createdCables.add(
                                   CableRow(
                                    _createdCables.length,
                                    createdCable["cable"],
                                    createdCable["amount"]
                                ));
                              });
                            }
                          } :
                          null,
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
                onPressed: snapshot.connectionState
                  == ConnectionState.done ?
                      () {} :
                      null,
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

import "dart:math";

import "package:flutter/material.dart";
import "package:sqflite/sqflite.dart";

import "model/cable.dart";
import "model/cableRow.dart";
import "model/conduit.dart";
import "util/enums.dart";
import "util/db.dart";
import "view/about.dart";
import "view/addCable.dart";
import "view/cableRowWidget.dart";
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
  ConduitType _selectedConduitType;
  Database _db;
  List<Cable> _cables;
  List<Conduit> _conduits;
  List<CableRowWidget> _createdCables = [];
  
  //data shown in results
  int _totalCables;
  double _cableArea;
  String _chosenConduit;
  Conduit _minConduit;

  FlatButton _makeAddButton(AsyncSnapshot snapshot,
      bool cableKnown) {
    return FlatButton(
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
                      AddCableWidget(_cables, cableKnown),
                ),
              );
              
              if (createdCable != null) {
                setState(() {
                  _createdCables.add(
                     CableRowWidget(
                       CableRow(
                        _createdCables.length,
                        createdCable["cable"],
                        createdCable["amount"]
                     ))
                  );
                });
              }
            } :
            null,
      child: Text(
        cableKnown ? 
        "ADD A NEW CABLE" :
        "ADD A NEW UNNAMED CABLE",
      ),
    );
  }
  
  void _calculate(BuildContext context) {
    const List<double> fillType = [0.0, 0.53, 0.31, 0.4];
    int tempCount = 0;
    double tempArea = 0.0;
    String tempChosenConduit = "";
    
    if (_selectedConduitType == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          "No conduit selected",
        ),
      ));  
      return;
    }
    
    CableRow elem;
    //get total wire count and area
    _createdCables.forEach((CableRowWidget row) {
      elem = row.getRow;
      if (elem.getAmount != 0) {
        tempCount += elem.getAmount;
        tempArea += _xarea(elem.getCable.getOd) *
          elem.getAmount;
      }
    });
    
    if (tempCount <= 0) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          "No cables inputted",
        ),
      ));  
      return;
    }
    
    //format the conduit chosen string
    tempChosenConduit +=
      getConduitString(_selectedConduitType);
    if (tempCount == 1) {
      tempChosenConduit += " 53% max fill";
    }
    else if (tempCount == 2) {
      tempChosenConduit += " 31% max fill";
    }
    else if (tempCount > 2) {
      tempChosenConduit += " 40% max fill";
    }
     
    //find the minimum conduit needed
    Conduit curConduit;
    for (int x = 0; x < _conduits.length; x++) {
      curConduit = _conduits[x]; 
      if (curConduit.getType == _selectedConduitType &&
          curConduit.getArea *
            fillType[min<int>(tempCount, 3)] > tempArea) {
        
        setState(() {
          _totalCables = tempCount;
          _cableArea = tempArea;
          _chosenConduit = tempChosenConduit;
          _minConduit = curConduit;
        });
        
        return;
      }
    }
    
    setState(() {
      _totalCables = null;
      _cableArea = null;
      _chosenConduit = null;
      _minConduit = null;
    });
    
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "Total cable area exceeded largest available conduit. Try reducing the amount.",
      ),
      duration: Duration(
        seconds: 3,
      ),
    ));  
  }

  double _xarea(double diameter) {
    return pi * diameter * (diameter / 4);
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
                  _makeAddButton(snapshot, true),
                  _makeAddButton(snapshot, false),
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
                        _selectedConduitType = value;
                      });
                    },
                    items: ConduitType.values
                        .map<DropdownMenuItem<ConduitType>>(
                            (ConduitType item) => DropdownMenuItem<ConduitType>(
                                  child: Text(getConduitString(item)),
                                  value: item,
                                ))
                        .toList(),
                    value: _selectedConduitType,
                  ),
                ],
              ),
              Builder(
                builder: (BuildContext context) => 
                  RaisedButton(
                  onPressed: snapshot.connectionState
                    == ConnectionState.done ?
                        () { _calculate(context); } :
                        null,
                  child: Text("Calculate"),
                ),
              ),
              Text(
                "Results",
                textScaleFactor: 1.5,
              ),
              Text(
                "Total amount of cable: $_totalCables",
              ),
              Text(
                "Total area of cables: $_cableArea",
              ),
              Text(
                "Conduit type chosen: $_chosenConduit",
              ),
              Text(
                """
Minumum conduit size: ${_minConduit?.getName} (area: ${_minConduit?.getArea})""",
              ),
              Text(
                """Conduit fill percent: ${_minConduit != null ? (_cableArea / _minConduit?.getArea) : null}""",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

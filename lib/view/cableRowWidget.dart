import "package:flutter/material.dart";

import "../model/cable.dart";
import "../model/cableRow.dart";
import "../util/enums.dart";

/*
  A widget used to represent a cable in the listview
*/

class CableRowWidget extends StatefulWidget {
  final CableRow _row;

  CableRowWidget(this._row);
  
  CableRow get getRow => _row;
  
  @override
  State createState() => _CableRowState(_row);
}

class _CableRowState extends State<CableRowWidget> {
  CableRow _row;

  _CableRowState(this._row);

  int get getAmount => _row.getAmount;
  Cable get getCable => _row.getCable;
  
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CableOptions>(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<CableOptions>>[
          PopupMenuItem(
            value: CableOptions.EDIT,
            child: Text("Edit"),
          ),
          PopupMenuItem(
            value: CableOptions.DELETE,
            child: Text("Delete"),
          ),
        ];
      },
      onSelected: (CableOptions value) {
        switch(value) {
          case CableOptions.EDIT:
          break;

          case CableOptions.DELETE:
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                AlertDialog(
                  title: Text(
                    "Delete cable ${_row.getNum}?",
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        "Cancel",
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        "Delete",
                      ),
                      onPressed: () {
                        
                      },
                    ),
                  ],
                ),
            );
          break;
        }
      },
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  right: 15.0,
                ),
                child: Text(
                  "Cable ${_row.getNum}",
                  textScaleFactor: 1.4,
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    _row.getCable.getName != null ? 
                    "${_row.getCable.getName}" :
                    "od: ${_row.getCable.getOd}",
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Amount: ${_row.getAmount}",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


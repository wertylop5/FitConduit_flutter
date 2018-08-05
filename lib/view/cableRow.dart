import "package:flutter/material.dart";

import "../model/cable.dart";

/*
  A widget used to represent a cable in the listview
*/

class CableRow extends StatefulWidget {
  final int _cableNum;//what position it is in the listview
  final Cable _cable;
  final int _cableAmount;

  CableRow(this._cableNum, this._cable, this._cableAmount);
  
  @override
  State createState() => _CableRowState(
      _cableNum,
      _cable,
      _cableAmount);
}

class _CableRowState extends State<CableRow> {
  int _cableNum;
  Cable _cable;
  int _cableAmount;

  _CableRowState(this._cableNum,
      this._cable, this._cableAmount);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        print("long pressed item");
      },
      onTap: () {
        print("tapped item");
      },
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
                "Cable $_cableNum",
                textScaleFactor: 1.4,
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  "${_cable.getName}",
                ),
              ),
            ),
            Container(
              child: Text(
                "Amount: $_cableAmount",
              ),
            ),
          ],
        ),
      ),
    );
  }
}


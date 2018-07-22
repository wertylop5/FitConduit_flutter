import "package:flutter/material.dart";

/*
  A widget used to represent a cable in the listview
*/

class CableRow extends StatefulWidget {
  @override
  State createState() => _CableRowState();
}

class _CableRowState extends State<CableRow> {
  int _cableNum;
  String _name;
  //Cable _cable;
  
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
                "Cable 10",
                textScaleFactor: 1.4,
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  "Cable name",
                ),
              ),
            ),
            Container(
              child: Text(
                "Amount: 10",
              ),
            ),
          ],
        ),
      ),
    );
  }
}


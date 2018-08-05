import "package:flutter/material.dart";

import "../model/cable.dart";
import "../model/conduit.dart";
import "../util/enums.dart";
import "../view/defaultAppBar.dart";

class AddCableWidget extends StatefulWidget {
  final List<Cable> _cables;
  final List<Conduit> _conduits;
  
  AddCableWidget(this._cables, this._conduits);
  
  @override
  State createState() => _AddCableWidgetState(
      _cables,
      _conduits);
}

class _AddCableWidgetState extends State<AddCableWidget> {
  List<Cable> _cables;
  List<Conduit> _conduits;
  int _optionSelected = 0;
  int _cableAmount = 0;
  
  _AddCableWidgetState(this._cables, this._conduits);

  List<DropdownMenuItem<int>> _makeMenuItems() {
    List<DropdownMenuItem<int>> res = [];
    for (int x = 0; x < _cables.length; x++) {
      res.add(DropdownMenuItem<int>(
        value: x,
        child: Text("${_cables[x].getName}"),
      ));
    }
    return res;
  }

  List<SimpleDialogOption> _makeDialogOptions(
      BuildContext context) {
    List<SimpleDialogOption> res = [];
    for (int x = 0; x < _cables.length; x++) {
      res.add(SimpleDialogOption(
        onPressed: () {Navigator.pop(context, x);},
        child: Text("${_cables[x].getName}"),
      ));
    }
    return res;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(context, RoutePaths.PATH_ADD_CABLE),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              """
Selected cable: ${_cables[_optionSelected].getName}
"""
            ),
            FlatButton(
              onPressed: () async {
                int selected = await showDialog<int>(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: Text("Select a cable"),
                      children:
                        _makeDialogOptions(context),
                    );
                  },
                );
                
                if (selected != null) {
                  setState(() {
                    _optionSelected = selected;
                  });
                }
              },
              child: Text("Click to select"),
            ),
            /*
            Slider(
              value: _cableAmount,
              min: 0.0,
              max: 10.0,
              divisions: 10,
              label: "$_cableAmount",
              onChanged: (double value) {
                setState(() {
                  _cableAmount = value;
                });
              },
            ),
            */
            TextField(
              keyboardType: TextInputType.number,
              maxLines: 1,
              maxLength: 2,
              onChanged: (String value) {
                int amount = int.parse(value);
                print(amount);
                setState(() {
                  _cableAmount = amount;
                });
              },
            ),
            Text("cables: $_cableAmount"),
            RaisedButton(
              child: Text("Create"),
              onPressed: () {
                Navigator.pop(
                  context,
                  {
                    "cable": _cables[_optionSelected],
                    "amount": _cableAmount
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


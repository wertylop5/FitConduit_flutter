import "package:flutter/material.dart";

import "../model/cable.dart";
import "../model/cableRow.dart";
import "../model/conduit.dart";
import "../util/enums.dart";
import "../view/defaultAppBar.dart";

class AddCableWidget extends StatefulWidget {
  final List<Cable> _cables;
  final bool _cableKnown;
  final CableRow _editTarget;
  
  AddCableWidget(this._cables,
      this._cableKnown, [this._editTarget]);
  
  @override
  State createState() => _AddCableWidgetState(
      _cables,
      _cableKnown,
      _editTarget);
}

class _AddCableWidgetState extends State<AddCableWidget> {
  List<Cable> _cables;
  int _optionSelected = 0;
  int _cableAmount = 0;
  bool _cableKnown;
  double _manualOd;
  CableRow _editTarget;
  
  _AddCableWidgetState(this._cables,
      this._cableKnown, this._editTarget);

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
            _cableKnown ? 
              """
Selected cable: ${_cables[_optionSelected].getName}
"""         :
            "Enter od:"
            ),
            _cableKnown ? 
            //show list of cables
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
            ) :
            //show od entry field
            TextField(
              keyboardType: TextInputType.number,
              maxLines: 1,
              onChanged: (String value) {
                setState(() {
                  _manualOd = double.parse(value);
                });
              },
            ),
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
                    "cable": _cableKnown ?
                      _cables[_optionSelected] :
                      Cable(_manualOd),
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


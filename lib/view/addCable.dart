import "package:flutter/material.dart";

import "../model/cable.dart";
import "../model/conduit.dart";
import "../util/enums.dart";
import "../view/defaultAppBar.dart";

class AddCableWidget extends StatefulWidget {
  List<Cable> _cables;
  List<Conduit> _conduits;
  
  AddCableWidget(this._cables, this._conduits);
  
  @override
  State createState() => _AddCableWidgetState(
      _cables,
      _conduits);
}

class _AddCableWidgetState extends State<AddCableWidget> {
  List<Cable> _cables;
  List<Conduit> _conduits;
  int _optionSelected;
  
  _AddCableWidgetState(this._cables, this._conduits);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(context, RoutePaths.PATH_ADD_CABLE),
      body: Container(
        child: Text("Hello"),
      ),
    );
  }
}


import "package:flutter/material.dart";

import "../model/cable.dart";

class AddCableWidget extends StatefulWidget {
  List<Cable> _cables;
  
  AddCableWidget(this._cables);
  
  @override
  State createState() => _AddCableWidgetState(_cables);
}

class _AddCableWidgetState extends State<AddCableWidget> {
  List<Cable> _cables;
  int _optionSelected;
  
  _AddCableWidgetState(this._cables);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),//refactoring not possible?
      body: Container(
        child: Text("Hello"),
      ),
    );
  }
}


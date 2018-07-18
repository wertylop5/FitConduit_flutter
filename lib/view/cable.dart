import "package:flutter/material.dart";

class Cable extends StatefulWidget {
  @override
  State createState() => _CableState();
}

class _CableState extends State<Cable> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text("First"),
        Text("second"),
      ],
    );
  }
}


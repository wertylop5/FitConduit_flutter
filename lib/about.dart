import "package:flutter/material.dart";

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("About text"),
        ],
      ),
    );
  }
}

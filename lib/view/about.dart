import "package:flutter/material.dart";

import "../util/enums.dart";
import "defaultAppBar.dart";

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(context, RoutePaths.PATH_ABOUT),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("About text"),
        ],
      ),
    );
  }
}

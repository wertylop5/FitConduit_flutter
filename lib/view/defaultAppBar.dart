import "package:flutter/material.dart";

import "../util/enums.dart";

AppBar getAppbar(BuildContext context, String curRoute) {
  PopupMenuButton<String> button;
  if (curRoute != RoutePaths.PATH_ABOUT) {
    button = PopupMenuButton<String>(
      onSelected: (String value) {
        Navigator.pushNamed(context,
            RoutePaths.PATH_ABOUT);
      },
      itemBuilder: (BuildContext context) =>
        <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            child: Text("About"),
            value: RoutePaths.PATH_ABOUT,
          ),
        ],
    );
  }
  
  return AppBar(
    title: Text("Fit Conduit"),
    actions: button == null ? null : <Widget>[
      button,
    ],
  );
}


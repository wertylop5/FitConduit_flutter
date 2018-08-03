enum ConduitType {
  RMC, EMT
}

class RoutePaths {
  static const String PATH_ABOUT =
    "/about";
  static const String PATH_ADD_CABLE =
    "/add-cable";
  static const String PATH_ADD_CABLE_UNNAMED =
    "/add-cable-unnamed";
  static const String PATH_ROOT =
    "/";
}

String getConduitString(ConduitType type) {
  switch(type) {
    case ConduitType.RMC:
      return "RMC";
    case ConduitType.EMT:
      return "EMT";
  }
}


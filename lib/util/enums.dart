enum ConduitType {
  RMC, EMT
}

String getConduitString(ConduitType type) {
  switch(type) {
    case ConduitType.RMC:
      return "RMC";
    case ConduitType.EMT:
      return "EMT";
  }
}


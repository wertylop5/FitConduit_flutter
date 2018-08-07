import "../util/enums.dart";

class Conduit {
  final ConduitType _type;
  final String _name;
  final double _area;

  Conduit(this._type, this._name, this._area);
  
  ConduitType get getType => _type;
  String get getName => _name;
  double get getArea => _area;
}

import "../model/cable.dart";

class CableRow {
  int _cableNum;//what position it is in the listview
  Cable _cable;
  int _cableAmount;
  
  CableRow(this._cableNum, this._cable, this._cableAmount);
  
  int get getNum => _cableNum;
  int get getAmount => _cableAmount;
  Cable get getCable => _cable;
}

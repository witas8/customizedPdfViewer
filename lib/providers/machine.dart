import 'package:flutter/foundation.dart';
import 'package:pdfx_viewer/utils/constants.dart';

class MachineModelProvider with ChangeNotifier {
  String _name = Constants.appBarTitle;
  String _url = "";
  String get name => _name;
  String get url => _url;

  void setValues(String chosenName, String chosenUrl) {
    _name = chosenName;
    _url = chosenUrl;
    notifyListeners();
  }
}

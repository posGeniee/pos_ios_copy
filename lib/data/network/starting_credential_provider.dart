import 'package:dummy_app/data/models/starting_credentials/get_location.dart';
import 'package:dummy_app/data/models/starting_credentials/get_terminal.dart';
import 'package:flutter/cupertino.dart';

class CredentialProvider with ChangeNotifier{

  String _baseUrlUpdated = '';
  List<GetLocationDatum> _locationsList = [];
  List<GetTerminalDatum> _terminalsList = [];
  // String _locationsListFirstItem = '';

  String get baseUrlUpdatedGetter {
    return _baseUrlUpdated;
  }

  baseUrlUpdatedSetter(String baseUrl){
    _baseUrlUpdated = baseUrl;
    notifyListeners();
  }

  locationsListSetter(String locationsList) {
    _locationsList = getLocationsModelFromMap(locationsList).data!;
    notifyListeners();
  }

  List<GetLocationDatum> get locationsListGetter {
    if (_locationsList == null) {
      return [];
    }
    return _locationsList;
  }

  terminalsListSetter(String terminalsList) {
    _terminalsList = getTerminalModelFromMap(terminalsList).data!;
    notifyListeners();
  }

  List<GetTerminalDatum> get terminalsListGetter {
    if (_terminalsList == null) {
      return [];
    }
    return _terminalsList;
  }
}
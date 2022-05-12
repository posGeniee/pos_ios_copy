import 'package:dummy_app/data/models/maintainance/customer_list_model.dart';
import 'package:dummy_app/data/models/maintainance/machines/machine_list_model.dart';
import 'package:flutter/cupertino.dart';

class MaintainanceProvider with ChangeNotifier {
  List<MachineListModelDatum> _usedForMainScreen = [];
  List<MachineListModelDatum> _selectedListModelDatum = [];
  CustomerListModelDatum _selectedCustomerListModelDatum =
      CustomerListModelDatum(id: 0, fullName: 'Enter the Assigned Customer');

  CustomerListModelDatum get selectedCustomerListModelDatumGetter {
    return _selectedCustomerListModelDatum;
  }

  emptySelectedCustomerListModelDatumSetter() {
    _selectedCustomerListModelDatum =
        CustomerListModelDatum(id: 0, fullName: 'Enter the Assigned Customer');
  }

  addSelectedCustomerListModelDatumSetter(CustomerListModelDatum setter) {
    _selectedCustomerListModelDatum = setter;
    notifyListeners();
  }

  List<MachineListModelDatum> get selectedListModelDatumGetter {
    return _selectedListModelDatum;
  }

  List<MachineListModelDatum> get usedForMainScreenListModelDatumGetter {
    return _usedForMainScreen;
  }

  addSelectedListModelDatumSetter(MachineListModelDatum listModelDatum) {
    _selectedListModelDatum.add(listModelDatum);
    notifyListeners();
  }

  addUseForMainScreebListModelDatumSetter(
      List<MachineListModelDatum> listModelDatum) {
    _usedForMainScreen = [];
    _usedForMainScreen.addAll(listModelDatum);
    notifyListeners();
  }

  addIndividualForMainScreebListModelDatumSetter(
      MachineListModelDatum listModelDatum) {
    _usedForMainScreen.insert(0, listModelDatum);
    print('This is Working  ${listModelDatum.name}');
    notifyListeners();
  }

  removeIndividualForMainScreebListModelDatumSetter(
      MachineListModelDatum listModelDatum) {
    _usedForMainScreen.removeWhere((element) {
      return element.id == listModelDatum.id;
    });
    notifyListeners();
  }

  updateIndividualForMainScreebListModelDatumSetter(
      MachineListModelDatum listModelDatum) {
    _usedForMainScreen.where((element) {
      if (element.id == listModelDatum.id) {
        element.name = listModelDatum.name;
        element.number = listModelDatum.number;
        element.temperature = listModelDatum.temperature;
        element.isSelected = false;
        element.displayUrl = listModelDatum.displayUrl;
        notifyListeners();
      }
      notifyListeners();
      return element.id == listModelDatum.id;
    }).toList();

    notifyListeners();
  }

  removeSelectedListModelDatumSetter(MachineListModelDatum listModelDatum) {
    _selectedListModelDatum
        .removeWhere((element) => element.id == listModelDatum.id);
    notifyListeners();
  }

  emptySelectedListModelDatumSetter() {
    _selectedListModelDatum = [];
    // notifyListeners();
  }
}

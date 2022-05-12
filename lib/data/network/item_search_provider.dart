import 'package:dummy_app/data/models/item%20search%20model/department_model.dart';
import 'package:dummy_app/data/models/item%20search%20model/mix_match_group_model.dart';
import 'package:dummy_app/data/models/item%20search%20model/plu_group_model.dart';
import 'package:dummy_app/data/models/item%20search%20model/sales_of_7_15_30_days.dart';
import 'package:dummy_app/data/models/item%20search%20model/search_products_with_plu_group&mixMatchModel.dart';
import 'package:dummy_app/data/models/item%20search%20model/search_result_by_barcode_or_name_model.dart';
import 'package:dummy_app/data/models/item%20search%20model/search_vendor_model.dart';
import 'package:dummy_app/data/models/item%20search%20model/vendor_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/item_search_api_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ItemSearchProvider with ChangeNotifier {
  late List<DatumofMixMatchGroup>? _mixMatchGroupListModel = [];

  int _mixMatchGroupListPage = 1;
  int _pluGroupListPage = 1;
  int _pluGroupProducts = 1;
  DatumVendor _selectedVendor = DatumVendor(supplier: '', id: 0);
  DatumDepartment _selectedDepartment =
      DatumDepartment(name: 'Please Select Department', id: 0);

  late List<DatumPluGroupList>? _pluGroupListApi = [];

  late List<DatumSearchProductsWithPluGroupMixMatch>?
      _searchProductsWithPluGroupMixMatchModel = [];
  late SearchResultByBarCodeOrNameModel _searchResultByBarCodeOrNameModel;
  late SearchVendorModel _searchVendorModel;

  late GetSalesof7D15D30DModel _getSalesof7D15D30DModel;

  List<DatumofMixMatchGroup>? get mixMatchGroupListGetter {
    return _mixMatchGroupListModel;
  }

  List<DatumPluGroupList>? get pluGroupListGetter {
    return _pluGroupListApi;
  }

  List<DatumSearchProductsWithPluGroupMixMatch>?
      get searchProductsWithPluGroupMixMatchGetter {
    return _searchProductsWithPluGroupMixMatchModel;
  }

  SearchResultByBarCodeOrNameModel get searchResultByBarCodeOrNameGetter {
    return _searchResultByBarCodeOrNameModel;
  }

  SearchVendorModel get searchVendorGetter {
    return _searchVendorModel;
  }

  DatumVendor get vendorSelectedGetter {
    return _selectedVendor;
  }

  DatumDepartment get departmentSelectedGetter {
    return _selectedDepartment;
  }

  GetSalesof7D15D30DModel get getSalesof7D15D30DGetter {
    return _getSalesof7D15D30DModel;
  }

//Change SelectedDepartment
  changeselectedDepartment(DatumDepartment datumDepartment) {
    _selectedDepartment = datumDepartment;
    notifyListeners();
  }

  changeselectedVendor(DatumVendor datumVendor) {
    _selectedVendor = datumVendor;
    notifyListeners();
  }

  //Get MixMatchGroupList
  mixMatchGroupListcall(String locationId, String token) async {
    final responseString = await ItemSearchApiFuncion()
        .mixMatchGroupList(_mixMatchGroupListPage, locationId, token);

    if (mixMatchGroupListModelFromMap(responseString).message!.data!.isEmpty) {
      return 'No Data Found';
    } else {
      if (mixMatchGroupListGetter!.isEmpty) {
        _mixMatchGroupListPage = _mixMatchGroupListPage + 1;
        final jsonToModel = mixMatchGroupListModelFromMap(responseString);
        _mixMatchGroupListModel = jsonToModel.message!.data;
        notifyListeners();
        print("This is the String Returning $responseString");
      } else if (mixMatchGroupListGetter!.isNotEmpty &&
          responseString.runtimeType == String) {
        final newList =
            mixMatchGroupListModelFromMap(responseString).message!.data;
        _mixMatchGroupListPage = _mixMatchGroupListPage + 1;
        _mixMatchGroupListModel!.addAll(newList!);
        notifyListeners();
      }
    }
  }

//Remove the Data
  removesearchProductsWithPluGroup() {
    _searchProductsWithPluGroupMixMatchModel!.clear();
  }

  //Get Plu Group Api
  pluGroupListCall(String locationId,String token) async {
    // final String responseString = await ItemSearchApiFuncion().pluGroupById();
    // print("This is the String Returning $responseString");

    final responseString =
        await ItemSearchApiFuncion().itemSearchPluGroup(locationId, token);
    print("This is the String of Data --- $responseString");

    if (searchProductsWithPluGroupMixMatchModelFromMap(responseString)
        .message!
        .data!
        .isEmpty) {
      print(
          "This is the Length --- ${_searchProductsWithPluGroupMixMatchModel!.length}");

      return 'No Data Found';
    } else {
      print(
          "This is the  --- ${_searchProductsWithPluGroupMixMatchModel!.length}");
      if (mixMatchGroupListGetter!.isEmpty) {
        _pluGroupProducts = _pluGroupProducts + 1;
        final jsonToModel =
            searchProductsWithPluGroupMixMatchModelFromMap(responseString);
        _searchProductsWithPluGroupMixMatchModel = jsonToModel.message!.data;
        print(
            "This is the Length --- $_searchProductsWithPluGroupMixMatchModel");
        notifyListeners();
        print("This is the String Returning $responseString");
      } else if (mixMatchGroupListGetter!.isNotEmpty &&
          responseString.runtimeType == String) {
        final newList =
            searchProductsWithPluGroupMixMatchModelFromMap(responseString)
                .message!
                .data;
        _pluGroupProducts = _pluGroupProducts + 1;
        _searchProductsWithPluGroupMixMatchModel!.addAll(newList!);
        notifyListeners();
      }
    }
  }

  //Search Department
  searchDepartmentCall(String departmentName, String token) async {
    final String responseString =
        await ItemSearchApiFuncion().searchDeparments(departmentName, token);
    print("This is the String Returning $responseString");
  }

  emptyPluGroup() {
    _pluGroupListApi = [];
    notifyListeners();
  }

  emptyMixMstchGroup() {
    _mixMatchGroupListModel = [];
    notifyListeners();
  }

  // //Plu Group Api
  pluGroupApiCall(String locationId, String token) async {
    final String responseString =
        await ItemSearchApiFuncion().itemSearchPluGroup(locationId,token);
    // final jsonToModel = pluGroupListApiFromMap(responseString);
    // _pluGroupListApi = jsonToModel;
    // notifyListeners();
    // print("This is the String Returning $responseString");
    if (pluGroupListApiFromMap(responseString).message!.data!.isEmpty) {
      return 'No Data Found';
    } else {
      if (_pluGroupListApi!.isEmpty) {
        _pluGroupListPage = _pluGroupListPage + 1;
        final jsonToModel = pluGroupListApiFromMap(responseString);
        _pluGroupListApi = jsonToModel.message!.data;
        notifyListeners();
        print("This is the String Returning $responseString");
      } else if (_pluGroupListApi!.isNotEmpty &&
          responseString.runtimeType == String) {
        final newList = pluGroupListApiFromMap(responseString).message!.data;
        _pluGroupListPage = _pluGroupListPage + 1;
        _pluGroupListApi!.addAll(newList!);
        notifyListeners();
      }
    }
  }

//TODO://
  //Search Product
  // searchProductsWithPluGroupMixMatchCall() async {
  //   final String responseString = await ItemSearchApiFuncion().pluGroupById(1);
  //   print("This is the String Returning $responseString");
  // }

  //Search Product by Bar Code and Name
  searchResultByBarCodeOrNameCall(
      String nameofProduct, String locationId, String token) async {
    final String responseString = await ItemSearchApiFuncion()
        .itemSearchProductById(nameofProduct, locationId, token);
    print("This is the String Returning $responseString");
  }

  //Search Vendors
  searchVendorModel(String vendorName, String token) async {
    final String responseString =
        await ItemSearchApiFuncion().searchVendors(vendorName, token);
    print("This is the String Returning $responseString");
  }

  //GetSalesof7D15D30DModel

  //Plu Group Api
  productUpdate(String token) async {
    final String responseString =
        await ItemSearchApiFuncion().saveProduct(token: token);
    print("This is the String Returning $responseString");
  }
}

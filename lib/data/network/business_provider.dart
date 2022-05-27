import 'dart:convert';

import 'package:dummy_app/data/models/menu_item.dart';
import 'package:dummy_app/data/models/sale_summary_model.dart';
import 'package:dummy_app/data/models/sales_overview.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
// import 'package:catcher/catcher.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class BusinessProvider with ChangeNotifier {
  late SaleOverViewModel _saleOverViewModel;
  late SaleSummaryModelApi _saleSummaryModel = SaleSummaryModelApi(
    code: 400,
    message: "message",
    data: DataSaleSummaryModelApi(
        currentPage: 0,
        data: [],
        firstPageUrl: '',
        from: 0,
        lastPage: 0,
        lastPageUrl: '',
        links: [],
        nextPageUrl: '',
        path: '',
        perPage: 0,
        prevPageUrl: '',
        to: 0,
        total: 0),
  );
  late int _categoryId;
  NewMenuItem _newMenuItem =
      const NewMenuItem(title: 'Sales', icons: Icons.title);

  changeMenuItem(NewMenuItem menuItem) {
    print("This is the new Item ${menuItem.title}");
    _newMenuItem = menuItem;
    notifyListeners();
  }

  changeCategorId(int categ) {
    _categoryId = categ;
    notifyListeners();
  }

  SaleOverViewModel get saleOverViewModelGetter {
   
    return _saleOverViewModel;
  }

  int get categoryIdGetter {
    return _categoryId;
  }

  SaleSummaryModelApi get saleSummaryModelApiGetter {
    return _saleSummaryModel;
  }

  NewMenuItem get saleNewMenuItem {
    return _newMenuItem;
  }

  Future<bool> getSalesGrpah(
    String locationId,
    String token,
    String date,
    String type,
  ) async {
    Future<bool> isCrendentialTrue = Future.delayed(
        const Duration(
          seconds: 0,
        ), () {
      return false;
    });
    await tryCatchFunction(
      () async {
//Here the Function Start
        String responseDataString = await HttpRequestOfApp()
            .getSalesFunction(getSalesGraph, locationId, token, date, type);

        var responseJsonDecode = json.decode(responseDataString);
        if (responseJsonDecode['code'] == 400) {
          edgeAlert(navKey.currentContext,
              gravity: Gravity.top,
              title: responseJsonDecode['message'].toString(),
              icon: Icons.error_outline,
              backgroundColor: Colors.red);
          isCrendentialTrue = Future.delayed(
              const Duration(
                seconds: 0,
              ), () {
            return false;
          });
        } else {
          final jsonToModel = saleOverViewModelFromMap(responseDataString);
          _saleOverViewModel = jsonToModel;
          _newMenuItem = NewMenuItem(title: 'Sales', icons: Icons.title);
          notifyListeners();
          return isCrendentialTrue = Future.delayed(
              const Duration(
                seconds: 0,
              ), () {
            return true;
          });
        }
      },
    );
    return isCrendentialTrue;
  }

  Future<bool> getSalesSummary(String locationId, String categoryId,
      String token, String date, String type) async {
    Future<bool> isCrendentialTrue = Future.delayed(
        const Duration(
          seconds: 0,
        ), () {
      return false;
    });
    await tryCatchFunction(
      () async {
        print('This is the Data $date');
//Here the Function Start
        String responseDataString = await HttpRequestOfApp()
            .getSaleDetailsFunction(
                getSalesGraphDetial, locationId, categoryId, token, date, type);

        var responseJsonDecode = json.decode(responseDataString);
        if (responseJsonDecode['code'] == 400) {
          edgeAlert(navKey.currentContext,
              gravity: Gravity.top,
              title: responseJsonDecode['message'].toString(),
              icon: Icons.error_outline,
              backgroundColor: Colors.red);
          isCrendentialTrue = Future.delayed(
              const Duration(
                seconds: 0,
              ), () {
            return false;
          });
        } else {
          final jsonToModel = saleSummaryModleFromMap(responseDataString);
          _saleSummaryModel = jsonToModel;
          notifyListeners();
          return isCrendentialTrue = Future.delayed(
              const Duration(
                seconds: 0,
              ), () {
            return true;
          });
        }
      },
    );
    return isCrendentialTrue;
  }
}

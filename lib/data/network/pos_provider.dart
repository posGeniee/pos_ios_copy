import 'dart:convert';

import 'package:dummy_app/data/models/item%20search%20model/scan_bar_code.dart';
import 'package:dummy_app/data/models/pos/mix_and_match_pos.dart';
import 'package:catcher/catcher.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../helpers/helper function api/pos_mix_and_match.dart';
import '../models/pos/customer_list.dart';

class PosSectionProvider with ChangeNotifier {
  List<ScanBarCodeDatum> _list = [];
  List<MixMatchDatum> _mixMatchDiscount = [];
  List<Datum> _customerList = [];
  double _tototalAmount = 0.0;
  int _totalDiscount = 0;
  late double _totalTax;
  double _total = 0.0;
  late double _totalEbt;
  double _specialPrice = 0.0;
  bool _isSpecial = false;

  double get totalAmountGetter {
    return _tototalAmount;
  }

  double get totalGetter {
    return _total;
  }

  double get totalEbtGetter {
    return _totalEbt;
  }

  int get totalDiscountGetter {
    return _totalDiscount;
  }

  double get totalTaxGetter {
    return _totalTax;
  }

  double get specialPriceGetter {
    return _specialPrice;
  }

  bool get isSpecialGetter {
    return _isSpecial;
  }

  checkSpecialPrice(ScanBarCodeDatum cart) {
    print('>>>>>>>>>>>>>>>>> checkSpecialPrice');
    _list.where((element) {
      if (element.id == cart.id) {
        if (cart.onSpecial == 1) {
          DateTime todayDate = DateTime.now();
          DateTime startDate = DateTime.parse(cart.startDate);
          DateTime endDate = DateTime.parse(cart.endDate);

          print(
              '>>>>>>>>>>>>>>>>>> startDate : $startDate ... endDate : $endDate');
          if (todayDate.isAfter(startDate) && todayDate.isBefore(endDate)) {
            _isSpecial = true;
            _specialPrice = double.parse(cart.specialPrice);
            print(
                "Here is special price : ${double.parse(cart.specialPrice).toStringAsFixed(2)}");
          }
        }
        // print('>>>>>>>>>>>>>>>>>>>>>> cart.onSpecial');
        // subTotalCalculate(element, cart);
      }
      return false;
    }).toList();

    // cart.subTotal = cart.onSpecial == 1 && _isSpecial == true
    //     ? (_specialPrice * 1).toStringAsFixed(2)
    //     : (double.parse(cart.retailPrice) * 1).toStringAsFixed(2);

    notifyListeners();
  }

  List<ScanBarCodeDatum> get productListGetter {
    return _list;
  }

  // List<MixMatchDatum> get mixMatchGetter {
  //   if (_mixMatchDiscount == null) {
  //     return [];
  //   }
  //   return _mixMatchDiscount;
  // }

  mixMatchSetter(String dataofMixMatch) {
    _mixMatchDiscount = mixAndMatchFromMap(dataofMixMatch).data!;
    notifyListeners();
  }

  customerListSetter(String customerList) {
    _customerList = customerListModelFromMap(customerList).data!;
    notifyListeners();
  }

  List<Datum> get customerListGetter {
    if (_customerList == null) {
      return [];
    }
    return _customerList;
  }

  totalAmountSetterAdd(ScanBarCodeDatum cart) {
    _list.where((element) {
      if (element.id == cart.id) {
        element.unitQty = (double.parse(cart.unitQty) + 1).toStringAsFixed(2);
        subTotalCalculate(element);
        notifyListeners();
      }
      return false;
    }).toList();
    _list.map((element) {
      if (element.id == cart.id) {
        _tototalAmount = _tototalAmount +
            (element.onSpecial == 1 && _isSpecial
                ? double.parse(element.specialPrice)
                : double.parse(element.retailPrice));
        print('_tototalAmount + : $_tototalAmount');
      }

      notifyListeners();
      return false;
    }).toList();
    mixMatchIdCheck(cart);
    callMethods(cart);
    notifyListeners();
  }

  removeAll() {
    _list = [];
    edgeAlert(
      Catcher.navigatorKey!.currentState!.context,
      title: 'Transaction SuccessFul',
      backgroundColor: Colors.green,
    );
    notifyListeners();
  }

  totalAmountSetterMinus(ScanBarCodeDatum cart) {
    _list.where((element) {
      if (element.id == cart.id) {
        element.unitQty = (double.parse(cart.unitQty) - 1).toStringAsFixed(2);

        subTotalCalculate(element);

        notifyListeners();
      }
      return false;
    }).toList();
    _list.map((element) {
      if (element.id == cart.id) {
        _tototalAmount = _tototalAmount -
            (element.onSpecial == 1 && _isSpecial
                ? double.parse(element.specialPrice)
                : double.parse(element.retailPrice));
        print('_tototalAmount - : $_tototalAmount');
      }
      notifyListeners();
      return false;
    }).toList();
    mixMatchIdCheck(cart);
    callMethods(cart);
    notifyListeners();
  }

  String subTotalCalculate(ScanBarCodeDatum element) {
    print('>>>>>>>>>>>>.. subTotalCalculate >>>>>>>>>>>>> ');
    return element.subTotal = (element.onSpecial == 1 && _isSpecial
            ? double.parse(element.specialPrice) * double.parse(element.unitQty)
            : double.parse(element.retailPrice) * double.parse(element.unitQty))
        .toStringAsFixed(2);
  }

  addtoProductList(BuildContext context, ScanBarCodeDatum barCodeDatum,
      {bool showAlertMassage = false, String productQuantity = '2'}) {
    List<ScanBarCodeDatum> check =
        _list.where((element) => element.id == barCodeDatum.id).toList();
    notifyListeners();

    if (check.isEmpty) {
      print('If>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
      _list.add(barCodeDatum);
      checkSpecialPrice(barCodeDatum);
      _list.where((element) {
        print(
            '>>>>> (double.parse(element.unitQty) : ${(double.parse(element.unitQty))} ... productQuantity : $productQuantity');
        if (element.id == barCodeDatum.id) {
          element.unitQty = (double.parse(element.unitQty) +
                  (double.parse(productQuantity) - 1))
              .toString();
          // element.subTotal = (double.parse(element.subTotal) + 1).toStringAsFixed(2);
          element.subTotal = subTotalCalculate(element);

          print(
              'hi >>>>>>>>>> element.unitQty : ${element.unitQty} ... element.subTotal : ${element.subTotal}');
          print('Add product _tototalAmount : $_tototalAmount');
          _tototalAmount = _tototalAmount + double.parse(element.subTotal);
          print(
              'Add product _tototalAmount list : $_tototalAmount... subTotal : ${double.parse(element.subTotal)}');

          notifyListeners();
        }
        return element.id == barCodeDatum.id;
      }).toList();

      mixMatchIdCheck(barCodeDatum);

      edgeAlert(context,
          gravity: Gravity.top,
          title: 'Product Added Successfully',
          icon: Icons.error_outline,
          backgroundColor: Colors.green);
      notifyListeners();
    } else {
      print('Else>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
      _list.where((element) {
        if (element.id == barCodeDatum.id) {
          element.unitQty =
              (double.parse(element.unitQty) + (double.parse(productQuantity)))
                  .toString();
          // element.subTotal = (double.parse(element.subTotal) + 1).toStringAsFixed(2);
          element.subTotal = subTotalCalculate(element);

          print(
              'hi 2 >>>>>>>>>> element.unitQty : ${element.unitQty} ... element.subTotal : ${element.subTotal}');
          print(
              'Add product _tototalAmount : $_tototalAmount ... productQuantity : ${double.parse(productQuantity)}');
          // double increment = double.parse(element.subTotal) * double.parse(productQuantity);
          double increment = element.onSpecial == 1 && _isSpecial
              ? double.parse(element.specialPrice) *
                  double.parse(productQuantity)
              : double.parse(element.retailPrice) *
                  double.parse(productQuantity);
          _tototalAmount = _tototalAmount + increment;
          print(
              'Add product _tototalAmount list : $_tototalAmount... increment : $increment');

          notifyListeners();
        }
        return element.id == barCodeDatum.id;
      }).toList();

      mixMatchIdCheck(barCodeDatum);
    }

    callMethods(barCodeDatum);

    notifyListeners();
  }

  mixMatchIdCheck(ScanBarCodeDatum barCodeDatum) {
    _mixMatchDiscount.where((element1) {
      element1.groupables!.where((element2) {
        if (element2.id == barCodeDatum.id) {
          print(
              '>>>>>>>>>>>>>>>>> element.id == barCodeDatum.id : ${element2.id} ... barCodeDatum.sku : ${barCodeDatum.sku}');

          if (element1.isActive == 1) {
            print('>>>>>>>>>>>>>>>>> element1.isActive : ${element1.isActive}');
            checkWeekDayRestriction(element1, barCodeDatum);
          }
        }
        return false;
      }).toList();
      return false;
    }).toList();

    ///Tax calculation for Cart Items.............
    _list.map((element) {
      if (element.id == barCodeDatum.id) {
        if (element.tax == '1') {
          element.cartTax =
              double.parse(element.taxAmount) * double.parse(element.unitQty);
          _totalTax = 0.0;
          _list.map((element2) {
            _totalTax = _totalTax + element2.cartTax;
            print(
                'Tax >>>>>>>>>>>> proName : ${element2.proName} ... taxAmount : ${element2.taxAmount} ... unitQty : ${element2.unitQty} ... cartTax : ${element2.cartTax}');
            notifyListeners();
          }).toList();
        }
      }
      notifyListeners();
    }).toList();
    print('Tax >>>>>>>>>>>> _totalTax : ${_totalTax}');

    notifyListeners();
  }

  callMethods(ScanBarCodeDatum barCodeDatum) {
    total();

    ebtCheck(barCodeDatum);

    notifyListeners();
  }

  total() {
    _total = _tototalAmount + _totalTax - _totalDiscount.toDouble();
    print('>>>>>>>>>> _total : $_total');
    notifyListeners();
  }

  ebtCheck(ScanBarCodeDatum barCodeDatum) {
    _list.map((e) {
      if (e.id == barCodeDatum.id) {
        if (barCodeDatum.ebt == 1) {
          print(
              'double.parse(subTotalCalculate(e, barCodeDatum)) : ${double.parse(subTotalCalculate(e))} ... e.discount : ${e.discount}');
          e.ebtCart = double.parse(subTotalCalculate(e)) - e.discount;
          print(
              'IF >>> barCodeDatum.proName : ${barCodeDatum.proName} ... barCodeDatum.ebtCart : ${barCodeDatum.ebtCart}');
        } else {
          print(
              'double.parse(subTotalCalculate(e, barCodeDatum)) : ${double.parse(subTotalCalculate(e))} ... e.cartTax : ${e.cartTax} ... e.discount : ${e.discount}');
          e.ebtCart =
              double.parse(subTotalCalculate(e)) + e.cartTax - e.discount;
          print(
              'Else >>> barCodeDatum.proName : ${barCodeDatum.proName} ... barCodeDatum.ebtCart : ${barCodeDatum.ebtCart}');
        }

        _totalEbt = 0;
        _list.map((e1) {
          print('barCodeDatum.ebtCart : ${barCodeDatum.ebtCart}');
          print('e1.proName : ${e1.proName} ... e1.ebtCart : ${e1.ebtCart}');
          _totalEbt = _totalEbt + e1.ebtCart;
        }).toList();

        notifyListeners();
        print('>>>>>>>>> _totalEbt : $_totalEbt');
      }
    }).toList();

    notifyListeners();
  }

  checkWeekDayRestriction(
      MixMatchDatum mixMatchDatum, ScanBarCodeDatum barCodeDatum) {
    if (DateFormat.EEEE().format(DateTime.now()) == 'Monday') {
      if (mixMatchDatum.monday == 1) {
        print(
            '>>>>>>>>>>>>>>>> mixMatchDatum.monday : ${mixMatchDatum.monday}');
        dateTimeRestriction(mixMatchDatum, barCodeDatum);
      }
    } else if (DateFormat.EEEE().format(DateTime.now()) == 'Tuesday') {
      if (mixMatchDatum.tuesday == 1) {
        print(
            '>>>>>>>>>>>>>>>> mixMatchDatum.tuesday : ${mixMatchDatum.tuesday}');
        dateTimeRestriction(mixMatchDatum, barCodeDatum);
      }
    } else if (DateFormat.EEEE().format(DateTime.now()) == 'Wednesday') {
      if (mixMatchDatum.wednesday == 1) {
        print(
            '>>>>>>>>>>>>>>>> mixMatchDatum.wednesday : ${mixMatchDatum.wednesday}');
        dateTimeRestriction(mixMatchDatum, barCodeDatum);
      }
    } else if (DateFormat.EEEE().format(DateTime.now()) == 'Thursday') {
      if (mixMatchDatum.thursday == 1) {
        print(
            '>>>>>>>>>>>>>>>> mixMatchDatum.thursday : ${mixMatchDatum.thursday}');
        dateTimeRestriction(mixMatchDatum, barCodeDatum);
      }
    } else if (DateFormat.EEEE().format(DateTime.now()) == 'Friday') {
      if (mixMatchDatum.friday == 1) {
        print(
            '>>>>>>>>>>>>>>>> mixMatchDatum.friday : ${mixMatchDatum.friday}');
        dateTimeRestriction(mixMatchDatum, barCodeDatum);
      }
    } else if (DateFormat.EEEE().format(DateTime.now()) == 'Saturday') {
      if (mixMatchDatum.saturday == 1) {
        print(
            '>>>>>>>>>>>>>>>> mixMatchDatum.saturday : ${mixMatchDatum.saturday}');
        dateTimeRestriction(mixMatchDatum, barCodeDatum);
      }
    } else if (DateFormat.EEEE().format(DateTime.now()) == 'Sunday') {
      if (mixMatchDatum.sunday == 1) {
        print(
            '>>>>>>>>>>>>>>>> mixMatchDatum.sunday : ${mixMatchDatum.sunday}');
        dateTimeRestriction(mixMatchDatum, barCodeDatum);
      }
    }
  }

  dateTimeRestriction(
      MixMatchDatum mixMatchDatum, ScanBarCodeDatum barCodeDatum) {
    ///Date & Time Check.............
    if (mixMatchDatum.limitedDates == 1 || mixMatchDatum.timeRestricted == 1) {
      ///Date in string...
      var todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      var startDate = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(mixMatchDatum.limitedDatesStart.toString()));
      var endDate = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(mixMatchDatum.limitedDatesEnd.toString()));
      print(
          'startDate : $startDate ... todayDate : $todayDate ... endDate : $endDate');

      ///Time in string...
      var todayTime = DateFormat.Hm().format(DateTime.now());
      var startTime = DateFormat.Hm()
          .format(DateTime.parse(mixMatchDatum.timeRestrictedStart.toString()));
      var endTime = DateFormat.Hm()
          .format(DateTime.parse(mixMatchDatum.timeRestrictedEnd.toString()));
      print(
          'startTime : $startTime ... todayTime : $todayTime ... endTime : $endTime');

      if (mixMatchDatum.limitedDates == 1 &&
          mixMatchDatum.timeRestricted == 1) {
        ///Concatenate string date and string time (Calculate current dtaeTime is between start & end DateTime)
        DateTime todayDateTime = DateTime.parse(todayDate + ' ' + todayTime);
        DateTime startDateTime = DateTime.parse(startDate + ' ' + startTime);
        DateTime endDateTime = DateTime.parse(endDate + ' ' + endTime);
        print(
            'startDateTime : $startDateTime ... todayDateTime : $todayDateTime ... endDateTime : $endDateTime');

        if (todayDateTime.isAfter(startDateTime) &&
            todayDateTime.isBefore(endDateTime)) {
          print(
              'mixMatchDatum.limitedDates == 1 && mixMatchDatum.timeRestricted == 1');

          ///Type Implementation...
          typeDicountImplementation(mixMatchDatum, barCodeDatum);
        }
      } else if (mixMatchDatum.limitedDates == 1 &&
          mixMatchDatum.timeRestricted == 0) {
        if (DateTime.parse(todayDate).isAfter(DateTime.parse(startDate)) ||
            DateTime.parse(todayDate)
                    .isAtSameMomentAs(DateTime.parse(startDate)) &&
                DateTime.parse(todayDate).isBefore(DateTime.parse(endDate)) ||
            DateTime.parse(todayDate)
                .isAtSameMomentAs(DateTime.parse(endDate))) {
          print(
              'mixMatchDatum.limitedDates == 1 && mixMatchDatum.timeRestricted == 0');

          ///Type Implementation...
          typeDicountImplementation(mixMatchDatum, barCodeDatum);
        }
      } else if (mixMatchDatum.limitedDates == 0 &&
          mixMatchDatum.timeRestricted == 1) {
        ///Concatenate today date with time (For calculating current time is between start & end time)
        DateTime todayDateTime = DateTime.parse(todayDate + ' ' + todayTime);
        DateTime startDateTime = DateTime.parse(todayDate + ' ' + startTime);
        DateTime endDateTime = DateTime.parse(todayDate + ' ' + endTime);
        print(
            'startDateTime : $startDateTime ... todayDateTime : $todayDateTime ... endDateTime : $endDateTime');

        if (todayDateTime.isAfter(startDateTime) &&
            todayDateTime.isBefore(endDateTime)) {
          print(
              'mixMatchDatum.limitedDates == 0 && mixMatchDatum.timeRestricted == 1');

          ///Type Implementation...
          typeDicountImplementation(mixMatchDatum, barCodeDatum);
        }
      }
    } else {
      print(
          'mixMatchDatum.limitedDates == 0 && mixMatchDatum.timeRestricted == 0');

      ///Type Implementation...
      typeDicountImplementation(mixMatchDatum, barCodeDatum);
    }
  }

  typeDicountImplementation(
      MixMatchDatum mixMatchDatum, ScanBarCodeDatum barCodeDatum) {
    //type 1 is Discount Amount
    //type 2 is Discount Percentage
    //type 3 is Set Price
    //type 4 is Discount Cheapset Item By Amount
    //type 5 is Discount Cheapset Item By Percentage
    //type 6 is Discount Last Item By Amount
    //type 7 is Discount Last Item By Percentage
    //type 8 is Set Discounted Rate

    if (mixMatchDatum.type == '1') {
      print('>>>>>>>>>>> Discount Amount.....');
      double dis_times = 0.0;

      _mixMatchDiscount.where((element1) {
        element1.groupables!.where((element2) {
          print(
              'Discount>>> element2.id : ${element2.id}....barCodeDatum.id : ${barCodeDatum.id}');
          if (element2.id == barCodeDatum.id) {
            _list.where((element_list) {
              print(
                  'Discount 2 >>> element_list.id : ${element_list.id}....barCodeDatum.id : ${barCodeDatum.id}');
              if (element_list.id == barCodeDatum.id) {
                if (double.parse(element_list.unitQty) >=
                    int.parse(mixMatchDatum.quantity)) {
                  print(
                      'card quantity: ${double.parse(element_list.unitQty)} ...mixMatch quantity: ${int.parse(mixMatchDatum.quantity)}');
                  dis_times = double.parse(element_list.unitQty) /
                      int.parse(mixMatchDatum.quantity);
                  print('dis_times : $dis_times');
                  double discount = 0.0;
                  discount = dis_times.toInt() * double.parse(mixMatchDatum.discount);
                  barCodeDatum.discount = discount.toInt();

                  _totalDiscount = 0;
                  _list.map((e) {
                    _totalDiscount = _totalDiscount + e.discount;
                    print(
                        '>>>>>>>> element_list.proName: ${e.proName} ... element_list.discount : ${e.discount}');
                  }).toList();

                  print(
                      '>>>>>>>>>>>>>>> discount : $discount ... barCodeDatum.discount : ${barCodeDatum.discount} ... _totalDiscount : $_totalDiscount');
                  if (discount > 0) {
                    element_list.mixmatchGroupIdApply.add(element2.id);

                    element_list.mixmatchGroupIdApply.where((element3) {
                      if (element3 == barCodeDatum.id) {
                          element_list.mixMatchGroupApplied = true;
                          element_list.subtotalAfterDiscount = (double.parse(element_list.subTotal) - discount);
                          print(
                              '>>>>>>>>>proName : ${element_list.proName} ... element_list.subTotal : ${element_list.subTotal} ... subtotalAfterDiscount : ${element_list.subtotalAfterDiscount} ... _tototalAmount : $_tototalAmount');
                      }
                      return false;
                    }).toList();
                  }
                } else {
                  element_list.mixMatchGroupApplied = false;

                  if (element_list.id == barCodeDatum.id) {
                    element_list.discount = 0;
                    _totalDiscount = 0;
                    _list.map((e) {
                      _totalDiscount = _totalDiscount + e.discount;
                      print(
                          '>>>>>>>> element_list.proName: ${e.proName} ... element_list.discount : ${e.discount}');
                    }).toList();
                  }
                  notifyListeners();
                }
              }
              return false;
            }).toList();
          }
          return false;
        }).toList();
        return false;
      }).toList();

      notifyListeners();
    }
  }

  removetoProductList(ScanBarCodeDatum barCodeDatum) {
    _list.where((element) {
      if (element.id == barCodeDatum.id) {
        print(
            'remove list data 1 >>>>>>>>>>> element.proName ... ${element.proName} element.id : ${element.id} ... barCodeDatum.id : ${barCodeDatum.id} ... subTotalCalculate : ${double.parse(subTotalCalculate(element))} ... cartTax : ${element.cartTax} ... discount : ${element.discount} ... ebt : ${element.ebt} ... ebtCart : ${element.ebtCart} ... mixMatchGroupApplied : ${element.mixMatchGroupApplied}');

        //Remove id...
        element.mixmatchGroupIdApply.where((elementMixMatchId) {
            print('1. elementMixMatchId : ${elementMixMatchId}');
            element.mixmatchGroupIdApply.remove(element.id);
            print('2. elementMixMatchId : ${elementMixMatchId}');
          return false;
        }).toList();
        //Set mixMatch default to false...
        element.mixMatchGroupApplied == false;
        //Total Bill Update...
        _tototalAmount =
            _tototalAmount - double.parse(subTotalCalculate(element));
        //Tax Update...
        _totalTax = _totalTax - element.cartTax;
        //Discount Update...
        _totalDiscount = _totalDiscount - element.discount;
        //total update...
        total();
        //Ebt update...
        _totalEbt = _totalEbt - element.ebtCart;
      }
      return false;
    }).toList();

    _list.removeWhere((element) {
      print(
          'remove list data 3 >>>>>>>>>>> element.proName ... ${element.proName} element.id : ${element.id} ... barCodeDatum.id : ${barCodeDatum.id} ... mixMatchGroupApplied : ${element.mixMatchGroupApplied}');
      return element.id == barCodeDatum.id;
    });

    notifyListeners();
  }
}

List<ScanBarCodeDatum> dummyListConverter(String str) =>
    List<ScanBarCodeDatum>.from(
        json.decode(str).map((x) => ScanBarCodeDatum.fromMap(x)));

//Dummy Products
String dummyDataPos = '''[      {
                "id": 328484,
                "product_code": "82193",
                "pro_name": "DURANGO CHILITOS 1 LB",
                "sku": "08511960017",
                "item_upc": null,
                "item": null,
                "unit_cost": "2.9200000",
                "tax_number": "TAX",
                "EBT": 1,
                "enable_stock": 1,
                "rebate_group": null,
                "type": "single",
                "mix_match_group": null,
                "inventory_group": null,
                "cate_id": 638,
                "cate_name": "MEAT",
                "price": "4.4900",
                "cost": "0",
                "margin": "34.9600000",
                "on_hand_qty": "0.0000000",
                "qty_available": "0.0000",
                "pack_size": null,
                "pack_upc": null,
                "case_cost": "0.0000000",
                "vendor_id": null,
                "on_special": 0,
                "start_date": null,
                "end_date": null,
                "plu": "08511960017",
                "pack_price": "0.0000000",
                "retail_price": "4.4900000",
                "case_size": "0.0000000",
                "special_price": "0.0000000",
                "loyalty_description": null,
                "loyalty_point": "0.0000000",
                "weight_item": 0,
                "ebt_eligible": 1,
                "wic_eligible": 0,
                "active_item": 1,
                "ingredient": 0,
                "show_in_menu": 0,
                "show_in_kiosk": 0,
                "must_ask_qty": 0,
                "inventory": 0,
                "kitchen_printer": 0,
                "loyalty_amount": "0.0000000",
                "send_to_scale": 0,
                "unit_id": 1,
                "sub_unit_ids": null,
                "tax": "1",
                "tax_amount": null,
                "unit_weight": "0",
                "case_weight": "0",
                "variation_id": 197234,
                "purchase_line_id": 15085,
                "purchase_line_tax_id": null
            },
            {
                "id": 336720,
                "product_code": null,
                "pro_name": "new reno 5",
                "sku": "336720",
                "item_upc": null,
                "item": null,
                "unit_cost": "30.0000000",
                "tax_number": "TAX",
                "EBT": 1,
                "enable_stock": 1,
                "rebate_group": null,
                "type": "single",
                "mix_match_group": null,
                "inventory_group": null,
                "cate_id": 640,
                "cate_name": "BEER",
                "price": "30.0000",
                "cost": "30",
                "margin": "25.0000000",
                "on_hand_qty": null,
                "qty_available": "17.0000",
                "pack_size": null,
                "pack_upc": null,
                "case_cost": "300.0000000",
                "vendor_id": 7756,
                "on_special": 0,
                "start_date": "2022-01-19 15:57:00",
                "end_date": "2022-01-19 15:57:00",
                "plu": "reno",
                "pack_price": "0",
                "retail_price": "30.0000000",
                "case_size": "250.0000000",
                "special_price": "0",
                "loyalty_description": null,
                "loyalty_point": "0",
                "weight_item": 1,
                "ebt_eligible": 1,
                "wic_eligible": 1,
                "active_item": 1,
                "ingredient": 1,
                "show_in_menu": 0,
                "show_in_kiosk": 1,
                "must_ask_qty": 1,
                "inventory": 1,
                "kitchen_printer": 1,
                "loyalty_amount": "0",
                "send_to_scale": 0,
                "unit_id": 1,
                "sub_unit_ids": null,
                "tax": "1",
                "tax_amount": null,
                "unit_weight": "0",
                "case_weight": "0",
                "variation_id": 205470,
                "purchase_line_id": 15073,
                "purchase_line_tax_id": null
            },
            {
                "id": 336720,
                "product_code": null,
                "pro_name": "new reno 5",
                "sku": "336720",
                "item_upc": null,
                "item": null,
                "unit_cost": "30.0000000",
                "tax_number": "TAX",
                "EBT": 1,
                "enable_stock": 1,
                "rebate_group": null,
                "type": "single",
                "mix_match_group": null,
                "inventory_group": null,
                "cate_id": 640,
                "cate_name": "BEER",
                "price": "0.0000",
                "cost": "30",
                "margin": "25.0000000",
                "on_hand_qty": null,
                "qty_available": "28.0000",
                "pack_size": null,
                "pack_upc": null,
                "case_cost": "300.0000000",
                "vendor_id": 7756,
                "on_special": 0,
                "start_date": "2022-01-19 15:57:00",
                "end_date": "2022-01-19 15:57:00",
                "plu": "reno",
                "pack_price": "0",
                "retail_price": "30.0000000",
                "case_size": "250.0000000",
                "special_price": "0",
                "loyalty_description": null,
                "loyalty_point": "0",
                "weight_item": 1,
                "ebt_eligible": 1,
                "wic_eligible": 1,
                "active_item": 1,
                "ingredient": 1,
                "show_in_menu": 0,
                "show_in_kiosk": 1,
                "must_ask_qty": 1,
                "inventory": 1,
                "kitchen_printer": 1,
                "loyalty_amount": "0",
                "send_to_scale": 0,
                "unit_id": 1,
                "sub_unit_ids": null,
                "tax": "1",
                "tax_amount": null,
                "unit_weight": "0",
                "case_weight": "0",
                "variation_id": 205471,
                "purchase_line_id": 15073,
                "purchase_line_tax_id": null
            },
            {
                "id": 336720,
                "product_code": null,
                "pro_name": "new reno 5",
                "sku": "336720",
                "item_upc": null,
                "item": null,
                "unit_cost": "30.0000000",
                "tax_number": "TAX",
                "EBT": 1,
                "enable_stock": 1,
                "rebate_group": null,
                "type": "single",
                "mix_match_group": null,
                "inventory_group": null,
                "cate_id": 640,
                "cate_name": "BEER",
                "price": "30.0000",
                "cost": "30",
                "margin": "25.0000000",
                "on_hand_qty": null,
                "qty_available": "17.0000",
                "pack_size": null,
                "pack_upc": null,
                "case_cost": "300.0000000",
                "vendor_id": 7756,
                "on_special": 0,
                "start_date": "2022-01-19 15:57:00",
                "end_date": "2022-01-19 15:57:00",
                "plu": "reno",
                "pack_price": "0",
                "retail_price": "30.0000000",
                "case_size": "250.0000000",
                "special_price": "0",
                "loyalty_description": null,
                "loyalty_point": "0",
                "weight_item": 1,
                "ebt_eligible": 1,
                "wic_eligible": 1,
                "active_item": 1,
                "ingredient": 1,
                "show_in_menu": 0,
                "show_in_kiosk": 1,
                "must_ask_qty": 1,
                "inventory": 1,
                "kitchen_printer": 1,
                "loyalty_amount": "0",
                "send_to_scale": 0,
                "unit_id": 1,
                "sub_unit_ids": null,
                "tax": "1",
                "tax_amount": null,
                "unit_weight": "0",
                "case_weight": "0",
                "variation_id": 205470,
                "purchase_line_id": 15074,
                "purchase_line_tax_id": null
            },
            {
                "id": 336720,
                "product_code": null,
                "pro_name": "new reno 5",
                "sku": "336720",
                "item_upc": null,
                "item": null,
                "unit_cost": "30.0000000",
                "tax_number": "TAX",
                "EBT": 1,
                "enable_stock": 1,
                "rebate_group": null,
                "type": "single",
                "mix_match_group": null,
                "inventory_group": null,
                "cate_id": 640,
                "cate_name": "BEER",
                "price": "0.0000",
                "cost": "30",
                "margin": "25.0000000",
                "on_hand_qty": null,
                "qty_available": "28.0000",
                "pack_size": null,
                "pack_upc": null,
                "case_cost": "300.0000000",
                "vendor_id": 7756,
                "on_special": 0,
                "start_date": "2022-01-19 15:57:00",
                "end_date": "2022-01-19 15:57:00",
                "plu": "reno",
                "pack_price": "0",
                "retail_price": "30.0000000",
                "case_size": "250.0000000",
                "special_price": "0",
                "loyalty_description": null,
                "loyalty_point": "0",
                "weight_item": 1,
                "ebt_eligible": 1,
                "wic_eligible": 1,
                "active_item": 1,
                "ingredient": 1,
                "show_in_menu": 0,
                "show_in_kiosk": 1,
                "must_ask_qty": 1,
                "inventory": 1,
                "kitchen_printer": 1,
                "loyalty_amount": "0",
                "send_to_scale": 0,
                "unit_id": 1,
                "sub_unit_ids": null,
                "tax": "1",
                "tax_amount": null,
                "unit_weight": "0",
                "case_weight": "0",
                "variation_id": 205471,
                "purchase_line_id": 15074,
                "purchase_line_tax_id": null
            }]''';

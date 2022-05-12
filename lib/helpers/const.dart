import 'package:dummy_app/data/models/menu_item.dart';
import 'package:dummy_app/data/models/sales_overview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kTextColor = Color(0xFF757575);

const buttonColor = Color.fromRGBO(28, 12, 91, 1);
//App Blue
Color colorblue = const Color.fromRGBO(60, 63, 153, 1);
//App Pink
Color colorpink = const Color.fromRGBO(233, 17, 147, 1);
// Color White
Color colorwhite = const Color.fromRGBO(255, 143, 225, 1);
// Color Pink
Color colorPinkButton = const Color.fromRGBO(236, 36, 129, 1);

String assetImage = 'assets/images/event_star.png';

//Base Url
const baseUrl = 'https://thesuperstarshop.com/api';

//SignIn API
const signInApi = '$baseUrl/v2/login';

//Forgot Password APIs
const forgotPasswordApi = '$baseUrl/v2/forgot-password';
//Enter Otp
const enterOtpApi = '$baseUrl/v2/enter-otp';
//Change Password
const changePasswordApi = '$baseUrl/v2/chnage-password';
//Change Password After Login
const changePasswordAfterLoginApi = '$baseUrl/v2/new-change-password';

//Sales Apis
const getSalesGraph = '$baseUrl/v2/sale-overview';
//Item Summary
const getSalesGraphDetial = '$baseUrl/v2/item-summary';

//Item Search Apis.
// plu group list
const pluGrouplist = '$baseUrl/v2/plu-group';
// Mix Match Group List
const mixmatchgroup = '$baseUrl/v2/mix-match-group';
// plu Group By Id
const pluGroupById = '$baseUrl/v2/group-by-id';
//Get Departments
const departments = '$baseUrl/v2/category';
// item Products
const itemproduct = '$baseUrl/v2/item-product';
//vendors Data
const vendors = '$baseUrl/v2/vendors';
// save products
const saveProducts = '$baseUrl/v2/save-product';
// vendors search
const vendorSearch = '$baseUrl/v2/vendors-search';
// category search
const categorySearch = '$baseUrl/v2/category-search';
//sale 7 day & 15 day & 30 day
const sale7day15day30day = '$baseUrl/v2/sale-chart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

const dataCheck =
    '''{"code":200,"message":"Successfully data","sum_value":189.80000000000001136868377216160297393798828125,"data":[{"id":639,"name":"GROC NON FOOD","total_paid":58.56000000000000227373675443232059478759765625,"share":30.853530031612226736115189851261675357818603515625},{"id":640,"name":"BEER","total_paid":30,"share":15.8061116965226542419031829922460019588470458984375},{"id":641,"name":"GROCERY","total_paid":101.2399999999999948840923025272786617279052734375,"share":53.34035827186512079833846655674278736114501953125},{"id":641,"name":"GROCERY","total_paid":101.2399999999999948840923025272786617279052734375,"share":53.34035827186512079833846655674278736114501953125},{"id":641,"name":"GROCERY","total_paid":101.2399999999999948840923025272786617279052734375,"share":53.34035827186512079833846655674278736114501953125},{"id":641,"name":"GROCERY","total_paid":101.2399999999999948840923025272786617279052734375,"share":53.34035827186512079833846655674278736114501953125},{"id":641,"name":"GROCERY","total_paid":101.2399999999999948840923025272786617279052734375,"share":53.34035827186512079833846655674278736114501953125},{"id":641,"name":"GROCERY","total_paid":101.2399999999999948840923025272786617279052734375,"share":53.34035827186512079833846655674278736114501953125},{"id":641,"name":"GROCERY","total_paid":101.2399999999999948840923025272786617279052734375,"share":53.34035827186512079833846655674278736114501953125}]}''';

const List<NewMenuItem> listofSalesItems = [
  NewMenuItem(title: 'Sales', icons: Icons.arrow_drop_down_circle),
  NewMenuItem(title: 'Inventory', icons: Icons.arrow_drop_down_circle),
  NewMenuItem(
      title: 'Clock Ins/Void/Sales', icons: Icons.arrow_drop_down_circle),
  NewMenuItem(
      title: 'Tickets Customers/Avg', icons: Icons.arrow_drop_down_circle),
  NewMenuItem(title: 'Gas Inventory', icons: Icons.arrow_drop_down_circle),
  NewMenuItem(title: 'Gas Sales', icons: Icons.arrow_drop_down_circle),
  NewMenuItem(title: 'Registers', icons: Icons.arrow_drop_down_circle),
];
const kTextColor1 = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPaddin = 20.0;

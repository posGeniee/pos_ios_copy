import 'dart:convert';

import 'package:dummy_app/data/models/purchase_scan/purchases_list_api_model.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:http/http.dart' as http;

class PurchaseScanApiFunction {
  listofPurchases(String locationId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/list-purchase?location_id=$locationId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final string = await response.stream.bytesToString();
      var responseJsonDecode = json.decode(
        string,
      );
      if (responseJsonDecode['code'] == 200) {
        print("This is the Data Returned $string  ");
        return string;
      } else {
        return string;
      }
    } else {
      return false;
    }
  }

  updateUnApprovePurchases(List<UnapprovedPurchase> unApprovePurchase,String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('$baseUrl/v2/update-take-purchase'));
    request.body = json.encode({
      "data": [
        {
          "unapproved_purchase_line_id": 16,
          "plu": null,
          "description": "BISTEK RANCHERO",
          "item": "01",
          "package_upc": null,
          "department": null,
          "tax_number": "tax",
          "ebt": "1",
          "wic": "1",
          "qty_on_hand": "0",
          "case_size": "6",
          "order_unit": "36.00",
          "product_id": "328385",
          "variation_id": "197135",
          "quantity": "36.00",
          "product_unit_id": "1",
          "sub_unit_id": "1",
          "order_case": "6",
          "product_item_status": "0",
          "product_item_type": "purchase",
          "ext_cost": "1500",
          "case_cost": "250.00",
          "case_retail": "0",
          "case_margin": "0",
          "unit_cost": "41.67",
          "purchase_price": "41.67",
          "pp_without_discount": "41.67",
          "discount_percent": "0.00",
          "new_retail": "50.99",
          "current_retail": "0",
          "purchase_line_tax_id": null,
          "item_tax": "0.00",
          "purchase_price_inc_tax": "41.67",
          "profit_percent": "22.37",
          "default_sell_price": "50.99"
        }
      ]
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}

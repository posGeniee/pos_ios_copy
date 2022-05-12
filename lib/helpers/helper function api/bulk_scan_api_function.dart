import 'dart:convert';
import 'dart:developer';
import 'package:dummy_app/helpers/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BulkScanApiCall {
  getAllProductData(String locationId, String token, int pageNo,
      Map<String, String> data) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/v2/item-product?page=$pageNo '),
    );
    request.fields.addAll(data);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  bankList(String locationId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET', Uri.parse('$baseUrl/v2/bank-list?location_id=$locationId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  takeOrderPurchase(
    String locationId,
    String token,
    String purchases,
  ) async {
    // printDebug(purchases);
    debugPrint('movieTitle: $purchases');
    log(purchases);

    var dateofPuchases = DateTime.now();
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('$baseUrl/v2/take-order-purchase'));
    request.body = json.encode({
      //
      "contact_id": "7759",
      "bank_name": "2",
      "ref_no": null,
      "transaction_date":
          "${dateofPuchases.day}/${dateofPuchases.month}/${dateofPuchases.year} ${dateofPuchases.hour}:${dateofPuchases.minute}",
      "status": "received",
      "location_id": locationId,
      "exchange_rate": "1",
      "purchase_item_type": "purchase",
      "search_product": null,
      "total_net": "0",
      "total_return": "0",
      "final_total": "0",
      "total_before_tax": 6500.12,
      "advance_balance": null,
      "payment": [
        {"amount": "0", "method": "cash", "note": null}
      ],
      "purchases": json.decode(purchases),
    });
    log(request.body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}

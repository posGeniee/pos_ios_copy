import 'dart:convert';
import 'dart:developer';

import 'package:dummy_app/helpers/const.dart';
// import 'package:catcher/catcher.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class IventoryScanApiCall {
  listofInventory(String locationId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/adjust-inventory-list?location_id=$locationId'));

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

  updateStock(
    String locationId,
    String token,
    String refNo,
    String transactionDate,
    String adjustmentType,
    String fineTotal, 
    String products,
    String totalAmountRecovered,
    String additionalNotes,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse('$baseUrl/v2/adjust-inventory'));
    request.body = json.encode({
      "location_id": locationId,
      "ref_no": refNo,
      "transaction_date": transactionDate,
      "adjustment_type": adjustmentType,
      "search_product": null,
      "final_total": fineTotal,
      "products": json.decode(products),
      "total_amount_recovered": totalAmountRecovered,
      "additional_notes": additionalNotes,
    });
    log('This is the Data Passed ${request.body}');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      edgeAlert(navKey.currentContext,
          gravity: Gravity.top,
          title: 'Updated Successfully',
          backgroundColor: Colors.green);
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}

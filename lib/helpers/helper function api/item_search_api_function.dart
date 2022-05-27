// import 'package:dummy_app/ui/screens/item_search/options/add_mix_match_group.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/main.dart';
// import 'package:catcher/catcher.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemSearchApiFuncion {
  // plu group list
  itemSearchPluGroup(String locationId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/plu-group?location_id=$locationId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  // plu group list Search
  itemSearchPluGroupSearch(
      String searchString, String token, String location) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/plu-group?location_id=$location&name=$searchString'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }

// Mix Match Group List
  mixMatchGroupList(int page, String locationId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
      'GET',
      Uri.parse(
          '$baseUrl/v2/mix-match-group?location_id=$locationId&page=$page'),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

// Mix Match Group List Search
  mixMatchGroupListSearch(
      String searchString, String locationId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
      'GET',
      Uri.parse(
          '$baseUrl/v2/mix-match-group?name=$searchString&location_id=$locationId'),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }

// plu Group By Id
  pluGroupById(int page, String pluGroupId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/group-by-id?page=$page'));
    request.fields.addAll({'ids[0]': pluGroupId, 'type': 'Plugroup'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

//
  mixMatchGroupById(int page, String mixMatchGroupId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/group-by-id?page=$page'));
    request.fields.addAll({'ids[0]': mixMatchGroupId, 'type': 'Mixmatchgroup'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

//Get Departments
  getDepartments(int pageNo, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET',
        Uri.parse('$baseUrl/v2/category?page=$pageNo'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

// item Products Search by Bar Code Id or name
  itemSearchProductById(
      String nameofProduct, String locationId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/v2/item-product'));
    request.fields.addAll({
      'name': nameofProduct,
      'location_id': locationId,
      'type': 'item_name'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }

//Get Vendors
  getVendor(int pageNo, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET',
        Uri.parse('$baseUrl/v2/vendors?page=$pageNo'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

//Save Product
  saveProduct({
    String? productcode,
    String? productId,
    String? name,
    String? sku,
    String? taxNumber,
    String? eBT,
    String? catId,
    String? price,
    String? cost,
    String? netMargin,
    String? onHandQty,
    String? packSize,
    String? packPrice,
    String? packUpc,
    String? vendorId,
    required String token,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/save-product/$productId'));

    request.fields.addAll(
      {
        'product_code': productcode.toString(),
        'name': name.toString(),
        'sku': sku as String,
        'tax_number': taxNumber.toString(),
        'ebt': eBT.toString(),
        'cate_id': catId.toString(),
        'price': price.toString(),
        'cost': cost.toString(),
        'net_margin': netMargin.toString(),
        'on_hand_qty': onHandQty.toString(),
        'pack_size': packSize.toString(),
        'pack_price': packSize.toString(),
        'pack_upc': packUpc.toString(),
        'vendor_id': (vendorId!.contains('null')) ? "7758" : vendorId,
      },
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

//Search By Deparments
  searchDeparments(String departmentName, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/category-search?name=$departmentName'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }

//Search By Vendors
  searchVendors(String vendorName, String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/vendors-search?name=$vendorName'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }

  //Sales Graph of Item Search
  salesGraphofItemSearch(
      String locationId, String productId, String date, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/sale-chart?location_id=$locationId&product_id=$productId&date=$date'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }

// Item Search From BarCode
  Future searchFromBarCode(String name, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/v2/item-product'));
    request.fields
        .addAll({'location_id': '1', 'type': 'barcode', 'name': name});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();
      print('Dat is $data');
      return data;
    } else {
      return 400;
    }
  }

// Item Search From Product Name
  Future searchFromProductName(String name, int page, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/item-product?page=$page'));
    request.fields
        .addAll({'location_id': '1', 'type': 'item_name', 'name': name});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

// Add Mix Match Group
  addMixMatchGroup(String groupName, String locationId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/v2/add-mixmatch'));
    request.fields.addAll({'name': groupName, 'location_id': locationId});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      edgeAlert(navKey.currentContext,
          gravity: Gravity.top,
          title: 'Mix Match Group Added Successfully',
          backgroundColor: Colors.green);
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }

  // Add Plu Group
  addPluGroup(String groupName, String locationId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/v2/add-plugroup'));
    request.fields.addAll({'name': groupName, 'location_id': locationId});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      edgeAlert(navKey.currentContext,
          gravity: Gravity.top,
          title: 'Plu Group Added Successfully',
          backgroundColor: Colors.green);
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }
}

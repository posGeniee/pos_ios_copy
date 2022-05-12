import 'package:dummy_app/helpers/const.dart';
import 'package:http/http.dart' as http;

class OverViewScanApiFunction {
  // get Item Details
  getItemDetail(
    String token,
    String locationId,
    String productId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/item-details?location_id=$locationId&product_id=$productId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final string = await response.stream.bytesToString();
      print('object - $string');
      return string;
    } else {
      return 400;
    }
  }

  getRegisterer(
    String token,
    String locationId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET', Uri.parse('$baseUrl/v2/registers?location_id=$locationId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final string = await response.stream.bytesToString();
      print('object - $string');
      return string;
    } else {
      return 400;
    }
  }

  getClockInVoid(
    String token,
    String locationId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/employee-attendance-list?location_id=$locationId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final string = await response.stream.bytesToString();
      print('object - $string');
      return string;
    } else {
      return 400;
    }
  }

  getInventory(
    String token,
    String locationId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    // var request = http.Request(
    //     'GET', Uri.parse('$baseUrl/v2/registers?location_id=$locationId'));
    var request =
        http.Request('GET', Uri.parse('$baseUrl/v2/inventory?location_id=1'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final string = await response.stream.bytesToString();
      print('object - $string');
      return string;
    } else {
      return 400;
    }
  }
}

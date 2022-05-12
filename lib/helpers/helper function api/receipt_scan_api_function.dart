import 'package:dummy_app/helpers/const.dart';
import 'package:http/http.dart' as http;

class ReceiptApiScan {
  getReciepts(
    String token,
    String pageNo,
    String locationId,
    String date,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/receipts?location_id=$locationId&date=$date&page=$pageNo'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  receiptDetails(
    String token,
    String receiptId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET',
        Uri.parse('$baseUrl/v2/receipts/$receiptId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase); 
    }
  }
}

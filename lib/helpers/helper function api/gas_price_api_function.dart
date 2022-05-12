import 'package:dummy_app/helpers/const.dart';
import 'package:http/http.dart' as http;

class GasPriceApiFunction {
  // get Item Details
  getGasPrice(
    String token,
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
            '$baseUrl/v2/list-gas-price?location_id=$locationId&date=$date'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final string = await response.stream.bytesToString();

      print('This is the App $string');
      return string;
    } else {
      print(response.reasonPhrase);
    }
  }
}

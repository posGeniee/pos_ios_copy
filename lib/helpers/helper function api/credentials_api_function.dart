import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../data/models/starting_credentials/get_terminal.dart';
import '../const.dart';

class CredentialsApi {
  getLocation() async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/getLocations'));
    request.fields.addAll({'business_id': '1'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print('GetLocations >>>>>> ${response.reasonPhrase}');
    }
  }

  //int locationId
  getTerminals(int locationId) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/getTerminals'));
    request.fields.addAll({
      'business_id': '1',
      'location_id': '$locationId'
      // 'location_id': '$locationId'
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }

  updateTerminals(String terminalId) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/updateTerminal'));
    request.fields
        .addAll({'business_id': '1', 'terminal_id': terminalId, 'status': '1'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }
}

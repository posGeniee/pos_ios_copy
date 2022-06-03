import 'package:dummy_app/helpers/const.dart';
import 'package:http/http.dart' as http;

class PosModuleApi {
  mixAndMatchPosProductData(String locationId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/getMixmatchGroup'));
    request.fields.addAll({'location_id': locationId});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }

  customerList(String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse('$baseUrl/getCustomers'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }

  businessSettings(String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.Request('POST', Uri.parse('$baseUrl/getBusinessSettings'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }

  addCustomer(String token, String name, String mobileNo, String email, String zipCode, var dob) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/storeCustomer'));
    request.fields.addAll({
      'user_id': '1',
      'customer_group_id': '',
      'type': 'customer',
      'name': '$name',
      'first_name': '',
      'middle_name': '',
      'last_name': '',
      'email': '$email',
      'contact_id': '0',
      'dob': '$dob',
      'mobile': '$mobileNo',
      'balance': '0.0',
      'visits_count': '0',
      'credit_limit': '0',
      'zip_code': '$zipCode',
      'remarks': 'null',
      'terminal_id': '4',
      'offline_id': '9'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(response.reasonPhrase);
    }
  }
}

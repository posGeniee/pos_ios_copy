import 'dart:convert';

import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/main.dart';
// import 'package:catcher/catcher.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:http/http.dart' as http;

class SupportTicketsApiFunction {
  addTicket(
    String locationId,
    String userName,
    String userEmail,
    String teamId,
    String prioty,
    String description,
    String token,
    String serviceType,
  ) async {
    // var headers = {
    //   'Accept': 'application/json',
    //   'Authorization': 'Bearer $token'
    // };
    // var request = http.MultipartRequest('POST',
    //     Uri.parse('$baseUrl/v1/support-ticket-user'));
    // request.fields.addAll({
    //   'location_id': locationId.toString(),
    //   'name': userName.toString(),
    //   'email': userEmail,
    //   'subject': teamId,
    //   'priority': prioty,
    //   'message': description,
    //   'service': serviceType,
    // });
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('$baseUrl/v2/support/tickets'));
    request.fields.addAll({
      'location_id': locationId,
      'name': userName,
      'email': userEmail,
      'subject': teamId,
      'priority': prioty,
      'message': description,
      'service': serviceType,
    });

    request.headers.addAll(headers);
    print(request.fields);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseJsonDecode = json.decode(
        await response.stream.bytesToString(),
      );
      if (responseJsonDecode['code'] == 200) {
        print(responseJsonDecode['message']);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  getTickets(
    String locationId,
    String token,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET',
        Uri.parse('$baseUrl/v1/support-ticket-user'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final string = await response.stream.bytesToString();
      var responseJsonDecode = json.decode(
        string,
      );
      if (responseJsonDecode['code'] == 200) {
        return string;
      } else {
        return string;
      }
    } else {
      return false;
    }
  }

  getComments(
    String commentId,
    String token,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v1/support-ticket-user/comment/show?id=$commentId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final string = await response.stream.bytesToString();
      // var responseJsonDecode = json.decode(
      //   string,
      // );
      return string;
      // if (responseJsonDecode['code'] == 200) {
      //   return string;
      // } else {
      //   return string;
      // }
    } else {
      return false;
    }
  }

  createComment(
    String userId,
    String type,
    String userName,
    String commentName,
    String token,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v1/support-ticket-user/comment'));
    request.fields.addAll({
      'id': userId,
      'type': type,
      'user_name': userName,
      'comment': commentName
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(request.fields);

    if (response.statusCode == 200) {
      var responseJsonDecode = json.decode(
        await response.stream.bytesToString(),
      );
      if (responseJsonDecode['code'] == 200) {
        edgeAlert(
          navKey.currentState!.context,
          title: 'Comment Added',
        );
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

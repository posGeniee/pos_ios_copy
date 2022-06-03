import 'dart:convert';
import 'dart:developer';

import 'package:dummy_app/helpers/const.dart';
import 'package:catcher/catcher.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as datelibrary;
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HttpRequestOfApp {
  //Post Request
  Future<dynamic> postFunction(
    dynamic jsonBody,
    String url,
  ) async {
    var responseData = await http.post(Uri.parse(url),
        body: jsonBody, headers: {'Accept': 'application/json'});
    return responseData;
  }

//Get Request of Api
  Future<dynamic> postgetFunction(
    String url,
    dynamic jsonBody,
    String token,
  ) async {
    var headers = {'Authorization': token, 'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('$baseUrl/v2/new-change-password'));
    request.body = json.encode(jsonBody);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final String data = await response.stream.bytesToString();
      print(data);
      return data;
    } else {
      final String data = await response.stream.bytesToString();
      print(data);
      return data;
    }
  }

//Get Sales OverView Tab Function
  Future<dynamic> getSalesFunction(
    String url,
    String locationId,
    String token,
    String date,
    String type,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var urlRequestWithoutType =
        '$baseUrl/v2/sale-overview?location_id=$locationId&date=$date';
    var urlRequestWithType =
        '$baseUrl/v2/sale-overview?location_id=$locationId&date=$date&type=$type';
    var urlRequestWithRangeType =
        '$baseUrl/v2/sale-overview?location_id=$locationId&type=range-date&$date';
    var request = http.Request(
        'GET',
        Uri.parse((type.isEmpty)
            ? urlRequestWithoutType
            : (type.contains('range-date')
                ? urlRequestWithRangeType
                : urlRequestWithType)));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(request);

    if (response.statusCode == 200) {
      final String data = await response.stream.bytesToString();
      print(data);
      return data;
    } else {
      final String data = await response.stream.bytesToString();
      print(data);
      return data;
    }
  }

//Get Sales OverView Tab Detail Function
  Future<dynamic> getSaleDetailsFunction(
    String url,
    String locationId,
    String categoryId,
    String token,
    String date,
    String type,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var urlRequestWithoutType =
        '$url?location_id=$locationId&category_id=$categoryId&date=$date';
    var urlRequestWithType =
        '$url?location_id=$locationId&category_id=$categoryId&date=$date&type=$type';
    var urlRequestWithRangeType =
        '$url?location_id=$locationId&category_id=$categoryId&type=range-date&$date';
    var request = http.Request(
        'GET',
        Uri.parse((type.isEmpty)
            ? urlRequestWithoutType
            : (type.contains('range-date')
                ? urlRequestWithRangeType
                : urlRequestWithType)));
    // var request = http.Request(
    //     'GET',
    //     Uri.parse(
    //         '$url?location_id=$locationId&category_id=$categoryId&date=$date'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    log(request.toString());

    if (response.statusCode == 200) {
      final String data = await response.stream.bytesToString();
      print(data);
      return data;
    } else {
      final String data = await response.stream.bytesToString();
      print(data);
      return data;
    }
  }
}

//Try Catch Function
Future tryCatchFunction(Function function) async {
  try {
    await function();
  } catch (error) {
    print('This is the Main Error ${error}');

    if (error.toString().contains("SocketException")) {


      edgeAlert(Catcher.navigatorKey!.currentState!.context,
          title: 'Internet connection is down');
    } else {
      Catcher.reportCheckedError(error, 'Error of the Catcher');
    }
  }
}



//Show Dialog
void showLoading() async {
  SmartDialog.showLoading(
    backDismiss: false,
  );
}

void dismissLoading() async {
  await SmartDialog.dismiss();
}

final formatofDateForView = datelibrary.DateFormat('yyyy-MM-dd');
final formatofDateForViewwithTime = datelibrary.DateFormat('yyyy-MM-dd HH:mm');
final formatofDateForViewwithTimeSlash =
    datelibrary.DateFormat('yyyy/MM/dd HH:mm');

Widget appButttonWithoutAnimation(
  BuildContext context,
  IconData iconOfButton,
  String textOfButtton,
  Function()? onPressed,
) {
  return Container(
    padding: const EdgeInsets.all(2.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      color: buttonColor,
    ),
    child: TextButton.icon(
      label: Text(
        textOfButtton,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 18,
              color: Colors.white,
            ),
      ),
      icon: Icon(
        iconOfButton,
        color: Colors.white,
      ),
      onPressed: onPressed,
    ),
  );
}

appButttonWithoutAnimationWithoutDecoration(
  BuildContext context,
  IconData iconOfButton,
  String textOfButtton,
  Function()? onPressed,
) {
  return Container(
    padding: const EdgeInsets.all(2.0),
    child: TextButton.icon(
      label: Text(
        textOfButtton,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 18,
              color: buttonColor,
            ),
      ),
      icon: Icon(
        iconOfButton,
        color: buttonColor,
      ),
      onPressed: onPressed,
    ),
  );
}

Future<File> fileFromImageUrl(String networkImage) async {
  final response = await http.get(
    Uri.parse(networkImage),
  );

  final documentDirectory = await getApplicationDocumentsDirectory();

  final file = File(join(documentDirectory.path, 'imagetest.png'));

  file.writeAsBytesSync(response.bodyBytes);

  return file;
}

configureAlertOfApp(
  BuildContext context,
  Function()? onPressed,
) {
  return Alert(
    context: context,
    type: AlertType.warning,
    title: "Delete Record(s)",
    desc: "Are you sure you want to delete the selected record?",
    buttons: [
      DialogButton(
        child: Text(
          "Cancel",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
        ),
        onPressed: () => Navigator.pop(context),
        color: Colors.grey,
      ),
      DialogButton(
        child: Text(
          "Delete",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
        ),
        onPressed: onPressed,
        color: Colors.red,
      )
    ],
  ).show();
}

totalCasesFormula() {}
//Total
totalUnitsFormula() {}
//Total Items
totalItemsFormula() {}

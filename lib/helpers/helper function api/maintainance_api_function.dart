import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:dummy_app/data/models/maintainance/machines/machine_list_model.dart';
import 'package:dummy_app/data/models/maintainance/part_category/part_category_list.dart';
import 'package:dummy_app/data/models/maintainance/part_order/part_order.dart';
import 'package:dummy_app/data/models/maintainance/parts/parts_model_list.dart';
import 'package:dummy_app/data/models/maintainance/schedule/schedule_list_model.dart';
import 'package:dummy_app/data/models/maintainance/temperature/temperature_model_list.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/services/location_service.dart';
import 'package:catcher/catcher.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MaintainanceApiFunction {
  getMachines(
    String locationId,
    String token,
    int pageNo,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.Request('GET',
        Uri.parse('$baseUrl/v2/machines?location_id=$locationId&page=$pageNo'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      print(await response.stream.bytesToString());
      return 400;
    }
  }

  //Add Machine
  addMachine(
      String token, String locationId, MachineListModelDatum modelDatum) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('$baseUrl/v2/machines/store?location_id=$locationId'));
    request.fields.addAll({
      'number': modelDatum.number.toString(),
      'name': modelDatum.name.toString(),
      'temperature': modelDatum.temperature.toString(),
    });
    if (modelDatum.displayUrl.isNotEmpty) {
      request.files.add(
          await http.MultipartFile.fromPath('image', modelDatum.displayUrl));
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final jsonDecodeofResponse = json.decode(responseString);
      final convertTomodelMachine = jsonDecodeofResponse['data'];

      final MachineListModelDatum modelDatum =
          MachineListModelDatum.fromMap(convertTomodelMachine);
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Machine Added Successfully',
          backgroundColor: Colors.green);
      return modelDatum;
    } else {
      print(response.reasonPhrase);
    }
  }

// Delete Machine
  deleteMachine(MachineListModelDatum modelDatum, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST',
        Uri.parse('$baseUrl/v2/machines/destroy/${modelDatum.id.toString()}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Machine Deleted Successfully',
          backgroundColor: Colors.red);
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  //Update Machines
  updateMachine(String token, MachineListModelDatum modelDatum) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/v2/machines/update/${modelDatum.id}'));
    request.fields.addAll({
      'number': modelDatum.number,
      'name': modelDatum.name,
      'temperature': modelDatum.temperature
    });
    print("This is the String ${modelDatum.displayUrl}");
    if (modelDatum.displayUrl.isNotEmpty) {
      request.files.add(
          await http.MultipartFile.fromPath('image', modelDatum.displayUrl));
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final jsonDecodeofResponse = json.decode(responseString);
      final convertTomodelMachine = jsonDecodeofResponse['data'];

      final MachineListModelDatum modelDatum =
          MachineListModelDatum.fromMap(convertTomodelMachine);
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Machine Updated Successfully',
          backgroundColor: Colors.green);
      return modelDatum;
    } else {
      print(response.reasonPhrase);
    }
  }

  // get Assigned Customer
  getCustomers(
    String locationId,
    String token,
    int pageNo,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request =
        http.Request('GET', Uri.parse('$baseUrl/v2/listUser?page=$pageNo'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  // Parts Section
  getParts(
    String locationId,
    String token,
    int pageNo,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET',
        Uri.parse('$baseUrl/v2/parts?location_id=$locationId&page=$pageNo'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }
  // Add Part

  addPart(
      String token, String locationId, PartsListModelDatum modelDatum) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/v2/parts/store?location_id=$locationId'));
    request.fields
        .addAll({'name': modelDatum.name, 'remarks': modelDatum.note});
    if (modelDatum.displayUrl.isNotEmpty) {
      request.files.add(
          await http.MultipartFile.fromPath('image', modelDatum.displayUrl));
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final jsonDecodeofResponse = json.decode(responseString);
      final convertTomodelMachine = jsonDecodeofResponse['data'];

      final PartsListModelDatum modelDatum =
          PartsListModelDatum.fromMap(convertTomodelMachine);
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Part Added Successfully',
          backgroundColor: Colors.green);
      return modelDatum;
    } else {
      print(response.reasonPhrase);
    }
  }

  updateParts(
      String token, PartsListModelDatum modelDatum, String locationId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/parts/update/${modelDatum.id.toString()}?location_id=$locationId'));
    request.fields
        .addAll({'name': modelDatum.name, 'remarks': modelDatum.note});
    if (modelDatum.displayUrl.isNotEmpty) {
      request.files.add(
          await http.MultipartFile.fromPath('image', modelDatum.displayUrl));
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final jsonDecodeofResponse = json.decode(responseString);
      final convertTomodelMachine = jsonDecodeofResponse['data'];

      final PartsListModelDatum modelDatum =
          PartsListModelDatum.fromMap(convertTomodelMachine);
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Parts Updated Successfully',
          backgroundColor: Colors.green);
      return modelDatum;
    } else {
      print(response.reasonPhrase);
    }
  }

  deletePart(PartsListModelDatum modelDatum, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST',
        Uri.parse('$baseUrl/v2/parts/destroy/${modelDatum.id.toString()}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Part Deleted Successfully',
          backgroundColor: Colors.red);
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  getPartCategory(String locationId, String token, int pageNo) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/part-category?location_id=$locationId&page=$pageNo'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print('Deleted --');
      // edgeAlert(Catcher.navigatorKey!.currentContext,
      //     gravity: Gravity.top,
      //     title: 'Part Deleted Successfully',
      //     backgroundColor: Colors.red);
      return await response.stream.bytesToString();
    } else {
      // return 400;
    }
  }

  addPartCategory(
      String token, String locationId, PartCategoryDatum modelDatum) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('$baseUrl/v2/part-category/store?location_id=$locationId'));
    request.fields.addAll({
      'name': modelDatum.name,
      'profit': modelDatum.profit,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final jsonDecodeofResponse = json.decode(responseString);
      final convertTomodelMachine = jsonDecodeofResponse['data'];

      final PartCategoryDatum modelDatum =
          PartCategoryDatum.fromJson(convertTomodelMachine);
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Part Added Successfully',
          backgroundColor: Colors.green);
      return modelDatum;
    } else {
      print(response.reasonPhrase);
    }
  }

  updateCategoryPart(
      String token, PartCategoryDatum modelDatum, String locationId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/part-category/update/${modelDatum.id}?location_id=$locationId'));
    request.fields
        .addAll({'name': modelDatum.name, 'profit': modelDatum.profit});
    // if (modelDatum.displayUrl.isNotEmpty) {
    //   request.files.add(
    //       await http.MultipartFile.fromPath('image', modelDatum.displayUrl));
    // }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final jsonDecodeofResponse = json.decode(responseString);
      final convertTomodelMachine = jsonDecodeofResponse['data'];

      final PartCategoryDatum modelDatum =
          PartCategoryDatum.fromJson(convertTomodelMachine);
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Parts Updated Successfully',
          backgroundColor: Colors.green);
      return modelDatum;
    } else {
      print(response.reasonPhrase);
    }
  }

  deletePartCategory(
      PartCategoryDatum modelDatum, String token, String locationId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '$baseUrl/v2/part-category/delete/${modelDatum.id}?location_id=$locationId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Machine Deleted Successfully',
          backgroundColor: Colors.red);
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  // Parts Section
  getOrderParts(
    String locationId,
    String token,
    int pageNo,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/order-part?location_id=$locationId&page=$pageNo'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  // add Order Part
  addOrderPart(
    String token,
    String locationId,
    String categoryId,
    String name,
    String link,
    String supplierName,
    String descriptionm,
    int status,
  ) async {
    var date = DateTime.now();
    var formatString = formatofDateForViewwithTime.format(date);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('$baseUrl/v2/order-part/store?location_id=$locationId'));
    request.fields.addAll({
      'part_category_id': '7',
      'recieve_date': formatString,
      'name': name,
      'link': link,
      'supplier_name': supplierName,
      'description': descriptionm,
      'status': status.toString(),
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(request.fields);

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final jsonDecodeofResponse = json.decode(responseString);
      final convertTomodelMachine = jsonDecodeofResponse['data'];

      final PartOrderDatum modelDatum =
          PartOrderDatum.fromJson(convertTomodelMachine);
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Part Added Successfully',
          backgroundColor: Colors.green);
      return modelDatum;
    } else {
      print(response.reasonPhrase);
    }
  }

  //Assigned Data

  getTemperatureData(
    String locationId,
    String token,
    int pageNo,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/machine-temperature?location_id=$locationId&page=$pageNo'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  addTemperature(
    String token,
    String locationId,
    String machineId,
    String date,
    String temperature,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/machine-temperature/store?location_id=$locationId'));
    request.fields.addAll(
        {'machine_id': machineId, 'date': date, 'temperature': temperature});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final jsonDecodeofResponse = json.decode(responseString);
      final convertTomodelMachine = jsonDecodeofResponse['data'];

      final TemperatureModelDatum modelDatum =
          TemperatureModelDatum.fromJson(convertTomodelMachine);
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Part Added Successfully',
          backgroundColor: Colors.green);
      return modelDatum;
    } else {
      print(response.reasonPhrase);
    }
  }

  deleteTempture(String machineId, String token, String locationId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '$baseUrl/v2/machine-temperature/destroy/$machineId?location_id=$locationId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Machine Deleted Successfully',
          backgroundColor: Colors.red);
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  //Schedule
  getSchedules(
    String locationId,
    String token,
    int pageNo,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/machine-schedule?location_id=$locationId&page=$pageNo'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("This is the Schedule Getting runs --$request");

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  addSchedule(
    String token,
    String locationId,
    String date,
    String decription,
    List<MachineListModelDatum> machines,
    bool isSchedule, {
    String? scheduleValue,
  }) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/machine-schedule/store?location_id=$locationId'));
    final Map listofmachineIds = {};

    for (var i = 0; i < machines.length; i++) {
      listofmachineIds["machine_ids[$i]"] = machines[i].id.toString();
    }

    // log(listofmachineIds.toString());

    if (isSchedule) {
      request.fields.addAll({
        'date': date,
        'description': decription,
        'document_type': 'image',
        'is_schedule': '1',
        'schedule': scheduleValue as String,
        ...listofmachineIds
        // 'machine_ids[0]': '36'
      });
    } else {
      request.fields.addAll({
        'date': date,
        'description': decription,
        'document_type': 'image',
        ...listofmachineIds
      });
    }

    request.headers.addAll(headers);
    // log(request.fields.toString());

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Part Added Successfully',
          backgroundColor: Colors.green);
      // return modelDatum;
    } else {
      print(response);
    }
  }

  deleteSchedule(String machineId, String token, String locationId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '$baseUrl/v2/machine-schedule/destroy/$machineId?location_id=$locationId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Schedule Deleted Successfully',
          backgroundColor: Colors.red);
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  addScheduleAsigni(
    String scheduleId,
    String token,
    String locationId,
    String assigniId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/assigned-schedule-update/$scheduleId?location_id=$locationId'));
    request.fields.addAll(
        {'assigned_to': assigniId, 'type': 'user', 'schedule_id': scheduleId});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("This the Fields12 ${request.fields}");

    if (response.statusCode == 200) {
      // print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Record Updated Successfully',
          backgroundColor: Colors.green);
      return await response.stream.bytesToString();
    } else {
      print("This is the Data${await response.stream.bytesToString()}");
      return 400;
    }
  }

  addScheduleVendor(
    String scheduleId,
    String token,
    String locationId,
    String assigniId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/assigned-schedule-update/$scheduleId?location_id=$locationId'));
    request.fields.addAll({
      'assigned_to': assigniId,
      'type': 'contact_id',
      'schedule_id': scheduleId
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("This the Fields ${request.fields}");

    if (response.statusCode == 200) {
      // print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Record Updated Successfully',
          backgroundColor: Colors.green);
      return await response.stream.bytesToString();
    } else {
      print("This is the Data${await response.stream.bytesToString()}");
      return 400;
    }
  }

  updateScheduleCostandDescription(String token, String schduleId,
      String locationId, String cost, String description) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/machine-schedule/update/$schduleId?location_id=$locationId'));
    request.fields.addAll({'cost': cost, 'description': description});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final jsonDecodeofResponse = json.decode(responseString);
      final convertTomodelMachine = jsonDecodeofResponse['data'];

      final ScheduleModelDatum modelDatum =
          ScheduleModelDatum.fromJson(convertTomodelMachine);
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Parts Updated Successfully',
          backgroundColor: Colors.green);
      return modelDatum;
    } else {
      print(response.reasonPhrase);
    }
  }

  getTrips(
    String locationId,
    String token,
    int pageNo,
    String scheduleId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/maintenance/trips/$scheduleId?location_id=$locationId'));

    request.headers.addAll(headers);
    print(request);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("trips--running");
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  addScheduleTrip(
    String scheduleId,
    String token,
    String locationId,
    List<DateTime> userStartEndTime,
    List<UserLocation> userStartEndLocation,
    String description,
    String cost,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/maintenance/trips/store?location_id=$locationId'));

    request.fields.addAll({
      'maintenance_schedules_id': scheduleId,
      'start_time': formatofDateForViewwithTime.format(userStartEndTime.first),
      'end_time': formatofDateForViewwithTime.format(userStartEndTime.last),
      'description': description,
      'start_point':
          '${userStartEndLocation.first.latitude}:${userStartEndLocation.first.longitude}',
      'end_point':
          '${userStartEndLocation.last.latitude}:${userStartEndLocation.last.longitude}',
      'cost': cost,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("This the Fields ${request.fields}");

    if (response.statusCode == 200) {
      // print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Record Updated Successfully',
          backgroundColor: Colors.green);
      return await response.stream.bytesToString();
    } else {
      print("This is the Data${await response.stream.bytesToString()}");
      return 400;
    }
  }

  updateScheduleTrip(
    String scheduleId,
    String token,
    String locationId,
    DateTime userStartTime,
    DateTime endTime,
    String userStartLocation,
    String userEnddLocation,
    String description,
    String cost,
    String updatTripId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/maintenance/trips/update/$updatTripId?location_id=$locationId'));
    request.fields.addAll({
      'maintenance_schedules_id': scheduleId,
      'start_time': formatofDateForViewwithTime.format(userStartTime),
      'end_time': formatofDateForViewwithTime.format(endTime),
      'description': description,
      'start_point': userStartLocation,
      'end_point': userEnddLocation,
      'cost': cost,
    });
    // var request = http.MultipartRequest(
    //     'POST',
    //     Uri.parse(
    //         '$baseUrl/v2/maintenance/trips/store?location_id=$locationId'));

    // request.fields.addAll({
    //   'maintenance_schedules_id': scheduleId,
    //   'start_time': formatofDateForViewwithTime.format(userStartTime),
    //   'end_time': formatofDateForViewwithTime.format(endTime),
    //   'description': description,
    //   'start_point': userStartLocation,
    //   'end_point': userEnddLocation,
    //   'cost': cost,
    // });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("This the Fields ${request.fields}");

    if (response.statusCode == 200) {
      // print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Record Updated Successfully',
          backgroundColor: Colors.green);
      return await response.stream.bytesToString();
    } else {
      print("This is the Data${await response.stream.bytesToString()}");
      return 400;
    }
  }

  deleteTrip(
    String tripId,
    String token,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST', Uri.parse('$baseUrl/v2/maintenance/trips/destroy/$tripId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('$request');
    if (response.statusCode == 200) {
      print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Trip Deleted Successfully',
          backgroundColor: Colors.red);
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  getDecisions(
    String locationId,
    String token,
    int pageNo,
    String tripId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            '$baseUrl/v2/maintenance/trips/decisions/$tripId?location_id=$locationId&page=$pageNo'));

    request.headers.addAll(headers);
    print(request);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("trips--running");
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  addTripDescision(
    String token,
    String locationId,
    String tripId,
    String description,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/maintenance/trips/decisions/store?location_id=$locationId'));
    request.fields.addAll({
      'trip_id': tripId,
      'description': description,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("This the Fields ${request.fields}");

    if (response.statusCode == 200) {
      // print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Record Updated Successfully',
          backgroundColor: Colors.green);
      return await response.stream.bytesToString();
    } else {
      print("This is the Data${await response.stream.bytesToString()}");
      return 400;
    }
  }

  updateTripDescision(
      String token, String decisionId, String description) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/maintenance/trips/decisions/update/$decisionId'));
    request.fields.addAll({
      'description': description,
    });
    // var request = http.MultipartRequest(
    //     'POST',
    //     Uri.parse(
    //         '$baseUrl/v2/maintenance/trips/store?location_id=$locationId'));

    // request.fields.addAll({
    //   'maintenance_schedules_id': scheduleId,
    //   'start_time': formatofDateForViewwithTime.format(userStartTime),
    //   'end_time': formatofDateForViewwithTime.format(endTime),
    //   'description': description,
    //   'start_point': userStartLocation,
    //   'end_point': userEnddLocation,
    //   'cost': cost,
    // });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("This the Fields ${request.fields}");

    if (response.statusCode == 200) {
      // print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Record Updated Successfully',
          backgroundColor: Colors.green);
      return await response.stream.bytesToString();
    } else {
      print("This is the Data${await response.stream.bytesToString()}");
      return 400;
    }
  }

  deleteTripDescision(
    String decisionId,
    String token,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/maintenance/trips/decisions/destroy/$decisionId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('$request');
    if (response.statusCode == 200) {
      print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Decision Deleted Successfully',
          backgroundColor: Colors.red);
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  getNotes(
    String locationId,
    String token,
    int pageNo,
    String scheduleId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/maintenance/notes/$scheduleId?location_id=$locationId&page=$pageNo'));

    request.headers.addAll(headers);
    print(request);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("trips--running");
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  addNote(
    String token,
    String locationId,
    String scheduleId,
    String description,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/maintenance/notes/store?location_id=$locationId'));
    request.fields.addAll({
      'maintenance_schedules_id': scheduleId,
      'description': description,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("This the Fields ${request.fields}");
    print("This the request ${request.url}");

    if (response.statusCode == 200) {
      // print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Record Updated Successfully',
          backgroundColor: Colors.green);
      return await response.stream.bytesToString();
    } else {
      print("This is the Data${await response.stream.bytesToString()}");
      return 400;
    }
  }

  updateNote(String token, String locationId, String noteId,
      String description) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/maintenance/notes/update/$noteId?location_id=$locationId'));
    request.fields.addAll({'description': description});
    // var request = http.MultipartRequest(
    //     'POST',
    //     Uri.parse(
    //         '$baseUrl/v2/maintenance/trips/store?location_id=$locationId'));

    // request.fields.addAll({
    //   'maintenance_schedules_id': scheduleId,
    //   'start_time': formatofDateForViewwithTime.format(userStartTime),
    //   'end_time': formatofDateForViewwithTime.format(endTime),
    //   'description': description,
    //   'start_point': userStartLocation,
    //   'end_point': userEnddLocation,
    //   'cost': cost,
    // });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print("This the Fields ${request.fields}");

    if (response.statusCode == 200) {
      // print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Record Updated Successfully',
          backgroundColor: Colors.green);
      return await response.stream.bytesToString();
    } else {
      print("This is the Data${await response.stream.bytesToString()}");
      return 400;
    }
  }

  deleteNote(String locationId, String token, String noteId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '$baseUrl/v2/maintenance/notes/destroy/$noteId?location_id=$locationId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print('$request');
    if (response.statusCode == 200) {
      print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Decision Deleted Successfully',
          backgroundColor: Colors.red);
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  getPartsWhenSchedule(
    String locationId,
    String token,
    int pageNo,
    String schduleId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    // var request = http.Request(
    //     'GET',
    //     Uri.parse(
    //         '$baseUrl/v2/parts?location_id=$locationId&page=$pageNo'));
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/schedule-parts/$schduleId?location_id=$locationId&page=$pageNo'));

    // request.headers.addAll(headers);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(request);
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }
  // Add Part

  addPartWhenSchedule(
    String token,
    String locationId,
    String scheduleId,
    String partId,
    String partWarentyDate,
    String description,
    String cost,
    String partWarrenty,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('$baseUrl/v2/schedule-parts/store?location_id=$locationId'));
    request.fields.addAll({
      'maintenance_schedules_id': scheduleId,
      'part_id': partId,
      'part_warranty_date': partWarentyDate,
      'description': description,
      'cost': cost,
      'part_warranty': '0'
    });
    request.headers.addAll(headers);
    print(request.fields);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final jsonDecodeofResponse = json.decode(responseString);
      final convertTomodelMachine = jsonDecodeofResponse['data'];

      final PartsListModelDatum modelDatum =
          PartsListModelDatum.fromMap(convertTomodelMachine);
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Part Added Successfully',
          backgroundColor: Colors.green);
      return modelDatum;
    } else {
      print(await response.stream.bytesToString());
    }
  }

  updatePartsWhenSchedule(
    String token,
    String locationId,
    String partId,
    String partCatId,
    String partWarrentyDate,
    String description,
    String cost,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/schedule-parts/update/$partId?location_id=$locationId'));
    request.fields.addAll({
      'part_id': partCatId,
      'part_warranty_date': partWarrentyDate,
      'description': description,
      'cost': cost,
    });
    print(request.fields);
    print(request);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final jsonDecodeofResponse = json.decode(responseString);
      final convertTomodelMachine = jsonDecodeofResponse['data'];

      final PartsListModelDatum modelDatum =
          PartsListModelDatum.fromMap(convertTomodelMachine);
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Parts Updated Successfully',
          backgroundColor: Colors.green);
      return modelDatum;
    } else {
      print(response.reasonPhrase);
    }
  }

  deletePartWhenSchedule(
    String token,
    int partId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST', Uri.parse('$baseUrl/v2/schedule-parts/destroy/$partId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Part Deleted Successfully',
          backgroundColor: Colors.red);
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  getPartsOrderWhenSchedule(
    String locationId,
    String token,
    int pageNo,
    String schduleId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    // var request = http.Request(
    //     'GET',
    //     Uri.parse(
    //         '$baseUrl/v2/parts?location_id=$locationId&page=$pageNo'));
    // var request = http.Request(
    //     'GET',
    //     Uri.parse(
    //         '$baseUrl/v2/schedule-parts/$schduleId?location_id=$locationId&page=$pageNo'));
    var request = http.Request(
        'GET',
        Uri.parse(
            '$baseUrl/v2/order-part?location_id=$locationId&schedule_id=$schduleId&page=$pageNo'));

    // request.headers.addAll(headers);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(request);
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }
  // Add Part

  addPartsOrderWhenSchedule(
    String token,
    String locationId,
    String partCategoryId,
    String recieveDate,
    String name,
    String link,
    String supplierName,
    String description,
    String status,
    String scheduleId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('$baseUrl/v2/order-part/store?location_id=$locationId'));
    request.fields.addAll({
      'part_category_id': partCategoryId,
      'recieve_date': recieveDate,
      'name': name,
      'link': link,
      'supplier_name': supplierName,
      'description': description,
      'status': status,
      'schedule_id': scheduleId,
    });
    request.headers.addAll(headers);
    print(request.fields);
    print(request.url);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final jsonDecodeofResponse = json.decode(responseString);
      final convertTomodelMachine = jsonDecodeofResponse['data'];

      final PartOrderDatum modelDatum =
          PartOrderDatum.fromJson(convertTomodelMachine);
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Part Added Successfully',
          backgroundColor: Colors.green);
      return modelDatum;
    } else {
      print(await response.stream.bytesToString());
    }
  }

  updatePartsOrderWhenSchedule(
    String token,
    String locationId,
    String partCategoryId,
    String recieveDate,
    String name,
    String link,
    String supplierName,
    String description,
    String status,
    String partOrderId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '$baseUrl/v2/order-part/update/$partOrderId?location_id=$locationId'));
    request.fields.addAll({
      'part_category_id': partCategoryId,
      'recieve_date': recieveDate,
      'name': name,
      'link': link,
      'supplier_name': supplierName,
      'description': description,
      'status': status
    });
    print(request.fields);
    print(request);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final jsonDecodeofResponse = json.decode(responseString);
      final convertTomodelMachine = jsonDecodeofResponse['data'];

      final PartOrderDatum modelDatum =
          PartOrderDatum.fromJson(convertTomodelMachine);
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Parts Updated Successfully',
          backgroundColor: Colors.green);
      return modelDatum;
    } else {
      print(await response.stream.bytesToString());
    }
  }

  deletePartsOrderWhenSchedule(
    String token,
    int partId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST', Uri.parse('$baseUrl/v2/schedule-parts/destroy/$partId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Deleted --');
      edgeAlert(Catcher.navigatorKey!.currentContext,
          gravity: Gravity.top,
          title: 'Part Deleted Successfully',
          backgroundColor: Colors.red);
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }

  viewCalender(String token, String locationId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://thesuperstarshop.com/api/v2/schedule-calender?location_id=$locationId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return 400;
    }
  }
}

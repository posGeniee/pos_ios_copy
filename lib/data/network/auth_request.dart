import 'dart:convert';

import 'package:dummy_app/data/models/sign_in.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/main.dart';
// import 'package:catcher/catcher.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AuthRequest with ChangeNotifier {
  late String emailSaved;
  late String otpSaved;
  late SignInModel _signInModel;
  late LocationFromApi _locationFromApi;

  String get otpTextGetter {
    return otpSaved;
  }

  LocationFromApi get locationFromApiGetter {
    return _locationFromApi;
  }

  String get emailTextGetter {
    return emailSaved;
  }

  SignInModel get signiModelGetter {
    return _signInModel;
  }

  //Sign In Request
  Future<bool> signInFunction(String? email, String? password) async {
    Future<bool> isCrendentialTrue = Future.delayed(
        const Duration(
          seconds: 0,
        ), () {
      return false;
    });
    await tryCatchFunction(
      () async {
//Here the Function Start
        Response responseDataString = await HttpRequestOfApp().postFunction(
          {"email": email, "password": password},
          signInApi,
        );

        var responseJsonDecode = json.decode(responseDataString.body);
        if (responseJsonDecode['code'] == 400) {
          edgeAlert(navKey.currentContext,
              gravity: Gravity.top,
              title: responseJsonDecode['message'].toString(),
              icon: Icons.error_outline,
              backgroundColor: Colors.red);
          isCrendentialTrue = Future.delayed(
              const Duration(
                seconds: 0,
              ), () {
            return false;
          });
        } else {
          final jsonToModel = signInModelFromMap(responseDataString.body);
          _signInModel = jsonToModel;
          _locationFromApi = jsonToModel.data!.location!.first;
          notifyListeners();
          return isCrendentialTrue = Future.delayed(
              const Duration(
                seconds: 0,
              ), () {
            return true;
          });
        }
      },
    );
    return isCrendentialTrue;
  }

  //Forgot Password
  forgotPassword(String emailText) async {
    Future<bool> isApiCallSuccess = Future.delayed(
        const Duration(
          seconds: 0,
        ), () {
      return false;
    });
    await tryCatchFunction(
      () async {
//Here the Function Start
        Response responseDataString = await HttpRequestOfApp().postFunction(
          {
            "email": emailText,
          },
          forgotPasswordApi,
        );
        var responseJsonDecode = json.decode(responseDataString.body);
        if (responseJsonDecode['code'] == 400) {
          edgeAlert(navKey.currentContext,
              gravity: Gravity.top,
              title: responseJsonDecode['message'].toString(),
              icon: Icons.error_outline,
              backgroundColor: Colors.red);
          isApiCallSuccess = Future.delayed(
              const Duration(
                seconds: 0,
              ), () {
            return false;
          });
        } else {
          edgeAlert(
            navKey.currentContext,
            gravity: Gravity.top,
            title: responseJsonDecode['message'].toString(),
            backgroundColor: Colors.green,
          );
          emailSaved = emailText;
          notifyListeners();

          return isApiCallSuccess = Future.delayed(
              const Duration(
                seconds: 0,
              ), () {
            return true;
          });
        }
      },
    );
    return isApiCallSuccess;
  }

  //OTP Verify
  verifyyOtp(String otpText, String email) async {
    Future<bool> isApiCallSuccess = Future.delayed(
        const Duration(
          seconds: 0,
        ), () {
      return false;
    });
    await tryCatchFunction(
      () async {
//Here the Function Start
        Response responseDataString = await HttpRequestOfApp().postFunction(
          {
            "otp": otpText,
            "email": email,
          },
          enterOtpApi,
        );
        var responseJsonDecode = json.decode(responseDataString.body);
        if (responseJsonDecode['code'] == 400) {
          edgeAlert(navKey.currentContext,
              gravity: Gravity.top,
              title: responseJsonDecode['message'].toString(),
              icon: Icons.error_outline,
              backgroundColor: Colors.red);
          isApiCallSuccess = Future.delayed(
              const Duration(
                seconds: 0,
              ), () {
            return false;
          });
        } else {
          edgeAlert(
            navKey.currentContext,
            gravity: Gravity.top,
            title: responseJsonDecode['message'].toString(),
            backgroundColor: Colors.green,
          );
          otpSaved = otpText;
          notifyListeners();
          return isApiCallSuccess = Future.delayed(
              const Duration(
                seconds: 0,
              ), () {
            return true;
          });
        }
      },
    );
    return isApiCallSuccess;
  }

  //ChangePassword
  Future<bool> changePassword(
    String email,
    String password,
    String confirmPassword,
    String otp,
  ) async {
    Future<bool> isApiCallSuccess = Future.delayed(
        const Duration(
          seconds: 0,
        ), () {
      return false;
    });
    await tryCatchFunction(
      () async {
//Here the Function Start
        Response responseDataString = await HttpRequestOfApp().postFunction(
          {
            "email": email,
            "password": password,
            "confirm_password": confirmPassword,
            "otp": otp,
          },
          changePasswordApi,
        );
        var responseJsonDecode = json.decode(responseDataString.body);
        if (responseJsonDecode['code'] == 400) {
          edgeAlert(navKey.currentContext,
              gravity: Gravity.top,
              title: responseJsonDecode['message'].toString(),
              icon: Icons.error_outline,
              backgroundColor: Colors.red);
          isApiCallSuccess = Future.delayed(
              const Duration(
                seconds: 0,
              ), () {
            return false;
          });
        } else {
          edgeAlert(
            navKey.currentContext,
            gravity: Gravity.top,
            title: responseJsonDecode['message'].toString(),
            backgroundColor: Colors.green,
          );
          return isApiCallSuccess = Future.delayed(
              const Duration(
                seconds: 0,
              ), () {
            return true;
          });
        }
      },
    );
    return isApiCallSuccess;
  }

  //ChangePassword
  Future<bool> changePasswordAfterAuth(
    String password,
    String currentPassword,
    String tokenFunc,
  ) async {
    Future<bool> isApiCallSuccess = Future.delayed(
        const Duration(
          seconds: 0,
        ), () {
      return false;
    });
    await tryCatchFunction(
      () async {
//Here the Function Start
        String responseDataString = await HttpRequestOfApp().postgetFunction(
          changePasswordAfterLoginApi,
          {
            "current_password": currentPassword,
            "password": password,
            "confirm_password": password,
          },
          "Bearer $tokenFunc",
        );

        var responseJsonDecode = json.decode(responseDataString);
        if (responseJsonDecode['code'] == 400) {
          edgeAlert(navKey.currentContext,
              gravity: Gravity.top,
              title: responseJsonDecode['message'].toString(),
              icon: Icons.error_outline,
              backgroundColor: Colors.red);
          isApiCallSuccess = Future.delayed(
              const Duration(
                seconds: 0,
              ), () {
            return false;
          });
        } else {
          edgeAlert(
            navKey.currentContext,
            gravity: Gravity.top,
            title: responseJsonDecode['messsage'].toString(),
            backgroundColor: Colors.green,
          );
          return isApiCallSuccess = Future.delayed(
              const Duration(
                seconds: 0,
              ), () {
            return true;
          });
        }
      },
    );
    return isApiCallSuccess;
  }

  //Change Business
  changeBusiness(LocationFromApi locationFromApi) {
    print("This is the Location Selected ${locationFromApi.name}");
    _locationFromApi = locationFromApi;
    notifyListeners();
  }
}

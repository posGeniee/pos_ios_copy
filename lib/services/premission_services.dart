import 'dart:async';

import 'package:permission_handler/permission_handler.dart';

class PremisiionServiceofApp {
  final StreamController<PremissonChange> _premisionofChange =
      StreamController<PremissonChange>.broadcast();

  //Stream Getter
  Stream<PremissonChange> get premissonChange {
    return _premisionofChange.stream;
  }

// Test Service
  PremisiionServiceofApp() {
    getPremisionStream().listen((event) {
      if (event != null) {
        _premisionofChange.add(event);
      }
    });
  }

  Stream<PremissonChange> getPremisionStream() async* {
    PremissonChange isPremission = PremissonChange.isDenied;

    while (true) {
      final requestAccessCameraMedia = Permission.accessMediaLocation;
      final requestAccessMicrophone = Permission.microphone;
      final requestAccessCamera = Permission.camera;
      final requestAccessStorage = Permission.storage;
      final requestAccessLocation = Permission.location;

      if (await requestAccessLocation.isDenied ||
          await requestAccessLocation.isDenied ||
          await requestAccessStorage.isDenied ||
          await requestAccessStorage.isLimited ||
          await requestAccessCamera.isDenied ||
          await requestAccessMicrophone.isDenied ||
          await requestAccessMicrophone.isLimited ||
          await requestAccessCameraMedia.isLimited ||
          await requestAccessCamera.isDenied) {
        isPremission = PremissonChange.isDenied;
      } else if (await requestAccessLocation.isPermanentlyDenied ||
          await requestAccessStorage.isPermanentlyDenied ||
          await requestAccessCamera.isPermanentlyDenied ||
          await requestAccessMicrophone.isPermanentlyDenied ||
          await requestAccessCamera.isPermanentlyDenied) {
        isPremission = PremissonChange.isDeniedForever;
      } else if (await requestAccessStorage.isGranted ||
          await requestAccessCamera.isGranted ||
          await requestAccessMicrophone.isGranted ||
          await requestAccessCamera.isGranted) {
        isPremission = PremissonChange.isAccepted;
      }
      await Future.delayed(
        const Duration(seconds: 1),
      );
      print("This is the Premission $isPremission");
      yield isPremission;
    }
  }
}

class LogModel {
  final String log;
  final String data;

  LogModel(this.log, this.data);
}

enum PremissonChange {
  isDenied,
  isAccepted,
  isDeniedForever,
}

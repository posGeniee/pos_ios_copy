import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationService {
  LocationPermission? permission;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
  StreamSubscription<Position>? _positionStreamSubscription;

  final StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  );
  //Stream Getter
  Stream<UserLocation> get locationGetterStream {
    return _locationController.stream;
  }

  LocationService() {
    //  print("This is Runinng--");
    _geolocatorPlatform.requestPermission().then((value) {
      // print("This is Runinng--");
      if (_serviceStatusStreamSubscription == null) {
        // print('This is the New Running ');
        if (_positionStreamSubscription == null) {
          final positionStream = _geolocatorPlatform.getPositionStream(
              locationSettings: locationSettings);
          _positionStreamSubscription = positionStream.handleError((error) {
            _positionStreamSubscription?.cancel();
            _positionStreamSubscription = null;
          }).listen(
            (position) => _locationController.add(UserLocation(
                latitude: position.latitude, longitude: position.longitude)),
          );
          _positionStreamSubscription?.pause();
        }
        if (_positionStreamSubscription!.isPaused) {
          _positionStreamSubscription!.resume();
        } else {
          _positionStreamSubscription!.pause();
        }
      }
    });
  }
}

class UserLocation {
  final double? latitude;
  final double? longitude;

  UserLocation({this.latitude, this.longitude});
}

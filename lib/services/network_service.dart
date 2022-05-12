// import 'dart:async';
// import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:data_connection_checker/data_connection_checker.dart';

// enum NetworkStatus { online, offline }

// class NetworkStatusService {
//   //From which the data is connectec WIFI or Mobile.
//   final StreamController<ConnectivityResult> _networkStatusController =
//       StreamController<ConnectivityResult>.broadcast();
//   Connectivity connectivityoftheNetwork = Connectivity();
// //Checking if the User is Online or Offline
//   final StreamController<NetworkStatus> _dataConnectionController =
//       StreamController<NetworkStatus>.broadcast();
//   DataConnectionChecker connectivityoftheDataConnection =
//       DataConnectionChecker();
//   final List<AddressCheckOptions> _dEFAULTADDRESSES =
//       List<AddressCheckOptions>.unmodifiable([
//     AddressCheckOptions(
//       InternetAddress('2001:4860:4860::8888',
//           type: InternetAddressType.IPv6), // Google
//       port: DataConnectionChecker.DEFAULT_PORT,
//       timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
//     ),
//     AddressCheckOptions(
//       InternetAddress('2001:4860:4860::8844',
//           type: InternetAddressType.IPv6), // Google
//       port: DataConnectionChecker.DEFAULT_PORT,
//       timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
//     ),
//     AddressCheckOptions(
//       InternetAddress('2606:4700:4700::64',
//           type: InternetAddressType.IPv6), // CloudFlare
//       port: DataConnectionChecker.DEFAULT_PORT,
//       timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
//     ),
//     AddressCheckOptions(
//       InternetAddress('2606:4700:4700::6400',
//           type: InternetAddressType.IPv6), // CloudFlare
//       port: DataConnectionChecker.DEFAULT_PORT,
//       timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
//     ),
//     AddressCheckOptions(
//       InternetAddress('2620:119:35::35',
//           type: InternetAddressType.IPv6), // OpenDNS
//       port: DataConnectionChecker.DEFAULT_PORT,
//       timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
//     ),
//     AddressCheckOptions(
//       InternetAddress('2620:119:53::53',
//           type: InternetAddressType.IPv6), // OpenDNS
//       port: DataConnectionChecker.DEFAULT_PORT,
//       timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
//     ),
//   ]);
// // Network Getter Stream
//   Stream<ConnectivityResult> get networkGetterStream {
//     return _networkStatusController.stream;
//   }

// // data Connection Stream
//   Stream<NetworkStatus> get dataConncectionStream {
//     return _dataConnectionController.stream;
//   }

// //
//   NetworkStatusService() {
//     Connectivity().onConnectivityChanged.listen((event) {
//       _networkStatusController.add(event);
//     });

//     DataConnectionChecker().onStatusChange.listen((dataConnectionEvent) {
//       _dataConnectionController.add(_dataConnectionStatus(dataConnectionEvent));
//     });
//   }
//   NetworkStatus _dataConnectionStatus(DataConnectionStatus status) {
//     return status == DataConnectionStatus.connected
//         ? NetworkStatus.online
//         : NetworkStatus.offline;
//   }
// }



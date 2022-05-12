import 'dart:async';

import 'package:dummy_app/data/network/bulk_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:fast_barcode_scanner/fast_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final codeStream2 = StreamController<Barcode>.broadcast();

class ScanBulkScanList extends StatefulWidget {
  static const routeName = '/ScanBulkScanList';
  const ScanBulkScanList({Key? key}) : super(key: key);

  @override
  _ScanBulkScanListState createState() => _ScanBulkScanListState();
}

class _ScanBulkScanListState extends State<ScanBulkScanList> {
  final _torchIconState = ValueNotifier(false);

  @override
  void dispose() {
    CameraController.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Continuous Barcode Scan',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: buttonColor)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: _torchIconState,
            builder: (context, state, _) => IconButton(
              icon: state
                  ? const Icon(Icons.flash_on)
                  : const Icon(Icons.flash_off),
              onPressed: () async {
                await CameraController.instance.toggleTorch();
                _torchIconState.value =
                    CameraController.instance.state.torchState;
              },
            ),
          ),
        ],
      ),
      body: BarcodeCamera(
        types: const [
          BarcodeType.ean8,
          BarcodeType.ean13,
          BarcodeType.code128,
        ],
        resolution: Resolution.hd720,
        framerate: Framerate.fps30,
        mode: DetectionMode.continuous,
        position: CameraPosition.back,
        onScan: (code) => codeStream2.add(code),
        children: [
          const MaterialPreviewOverlay(animateDetection: true),
          // const BlurPreviewOverlay(),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: const [SizedBox(height: 20), BullkDetectionsCounter()],
            ),
          )
        ],
      ),
    );
  }
}

class BullkDetectionsCounter extends StatefulWidget {
  const BullkDetectionsCounter({Key? key}) : super(key: key);

  @override
  _BullkDetectionsCounterState createState() => _BullkDetectionsCounterState();
}

class _BullkDetectionsCounterState extends State<BullkDetectionsCounter> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _streamToken = codeStream2.stream.listen((event) async {
      final count = detectionCount.update(event.value, (value) => value + 1,
          ifAbsent: () => 1);
      detectionInfo.value = "${count}x\n${event.value}";
      if (!mounted) return; setState(() {
        isLoading = true;
      });
      // final data = await ItemSearchApiFuncion().searchFromBarCode(event.value);
      // final response = scanBarCodeFromMap(data);
      // print("This is the Check Regarding Data ${response.message!.data}");
      if (isLoading == true) {
        Provider.of<BulkScanProvider>(context, listen: false)
            .addBulkScanItemPurchase(event.value);
        if (!mounted) return; setState(() {
          isLoading = false;
        });
        // CameraController.instance.resumeDetector();
        // edgeAlert(
        //   context,
        //   title: 'BarCode is not in the database',
        //   backgroundColor: Colors.red,
        // );
      } else {
        // final newData = response.message!.data![0];

        if (!mounted) return; setState(() {
          isLoading = false;
        });
      }
    });
  }

  late StreamSubscription _streamToken;
  Map<String, int> detectionCount = {};
  final detectionInfo = ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? const CircularProgressIndicator()
        : Column(
            children: [
              ElevatedButton(
                child: const Text("Resume"),
                onPressed: () => CameraController.instance.resumeDetector(),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                  child: ValueListenableBuilder(
                      valueListenable: detectionInfo,
                      builder: (context, dynamic info, child) {
                        print("This is the Information ${info.toString()}");
                        // if (info.toString().characters.isEmpty) {
                        //   CameraController.instance.resumeDetector();
                        // }
                        return Text(
                          info,
                          textAlign: TextAlign.center,
                        );
                      }
                      //  Text(
                      //   info,
                      //   textAlign: TextAlign.center,
                      // ),
                      ),
                ),
              ),
            ],
          );
  }

  @override
  void dispose() {
    _streamToken.cancel();
    super.dispose();
  }
}

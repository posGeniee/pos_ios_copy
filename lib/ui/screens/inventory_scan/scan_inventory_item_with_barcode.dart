import 'dart:async';

import 'package:dummy_app/data/models/item%20search%20model/scan_bar_code.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/inventory_scan_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper%20function%20api/item_search_api_function.dart';
import 'package:dummy_app/ui/screens/item_search/ItemEdit/edit_product.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:fast_barcode_scanner/fast_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final codeStream2 = StreamController<Barcode>.broadcast();

class ScannerScreenOfInventory extends StatefulWidget {
  static const routeName = '/ScannerScreenOfInventory';
  const ScannerScreenOfInventory({Key? key}) : super(key: key);

  @override
  _ScannerScreenOfInventoryState createState() =>
      _ScannerScreenOfInventoryState();
}

class _ScannerScreenOfInventoryState extends State<ScannerScreenOfInventory> {
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
        title: Text('Fast Barcode Scanner',
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
        mode: DetectionMode.pauseVideo,
        position: CameraPosition.back,
        onScan: (code) => codeStream2.add(code),
        children: [
          const MaterialPreviewOverlay(animateDetection: true),
          const BlurPreviewOverlay(),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: const [SizedBox(height: 20), DetectionsCounter()],
            ),
          )
        ],
      ),
    );
  }
}

class DetectionsCounter extends StatefulWidget {
  const DetectionsCounter({Key? key}) : super(key: key);

  @override
  _DetectionsCounterState createState() => _DetectionsCounterState();
}

class _DetectionsCounterState extends State<DetectionsCounter> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _streamToken = codeStream2.stream.listen((event) async {
      final count = detectionCount.update(event.value, (value) => value + 1,
          ifAbsent: () => 1);
      detectionInfo.value = "${count}x\n${event.value}";
      if (!mounted) return;
      setState(() {
        isLoading = true;
      });
      final token = Provider.of<AuthRequest>(context, listen: false)
          .signiModelGetter
          .data!
          .bearer;
      final data =
          await ItemSearchApiFuncion().searchFromBarCode(event.value, token);
      final response = scanBarCodeFromMap(data);
      print("This is the Check Regarding Data ${response.message!.data}");
      if (response.message!.data!.isEmpty) {
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
        edgeAlert(
          context,
          title: 'BarCode is not in the database',
          backgroundColor: Colors.red,
        );
      } else {
        final newData = response.message!.data![0];
        if (double.parse(newData.stockOfProduct) > 0) {
          print('InventoryScan item will be added ${newData.stockOfProduct}');
          Provider.of<InventoryScanProvider>(context, listen: false)
              .addInventoryScanData(newData);
        } else {
          edgeAlert(
            context,
            title: 'Product is available but Stock is not Available',
            backgroundColor: Colors.red,
          );
        }
        // Navigator.of(context).pushNamed(
        //   EditProduct.routeName,
        //   arguments: newData,
        // );
        if (!mounted) return;
        setState(() {
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
                    builder: (context, dynamic info, child) => Text(
                      info,
                      textAlign: TextAlign.center,
                    ),
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

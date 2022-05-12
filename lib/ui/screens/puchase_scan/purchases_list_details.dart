import 'package:dummy_app/data/models/purchase_scan/bulk_purchase_scan.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/ui/screens/bulk_scan/purchase/create_purchase.dart';
import 'package:edge_alerts/edge_alerts.dart';
import 'package:flutter/material.dart';

class PurchaseListDetails extends StatefulWidget {
  static const routeName = '/PurchaseListDetails';
  const PurchaseListDetails({
    Key? key,
  }) : super(key: key);

  @override
  _PurchaseListDetailsState createState() => _PurchaseListDetailsState();
}

class _PurchaseListDetailsState extends State<PurchaseListDetails> {
  final ScrollController _listScrollPage = ScrollController();
  List<String> items = [];
  bool loading = false, allLoaded = false;

  mockFetch() async {
    if (allLoaded) {
      return;
    }
    if (!mounted) return; setState(() {
      loading = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    List<String> newData = items.length >= 60
        ? []
        : List.generate(20, (index) => "List Item ${index + items.length}");
    if (newData.isNotEmpty) {
      items.addAll(newData);
    }
    if (!mounted) return; setState(() {
      loading = false;
      allLoaded = newData.isEmpty;
    });
  }

  @override
  void initState() {
    mockFetch();
    _listScrollPage.addListener(() {
      if (_listScrollPage.offset <= _listScrollPage.position.minScrollExtent &&
          !_listScrollPage.position.outOfRange) {}
      if (_listScrollPage.position.pixels >=
              _listScrollPage.position.maxScrollExtent &&
          !loading) {
        print("this is the New Data Call----");
        mockFetch();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _listScrollPage.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Puchase products List ",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              // final locationId =
              //     Provider.of<AuthRequest>(context, listen: false)
              //         .locationFromApiGetter
              //         .id;
              // final token = Provider.of<AuthRequest>(context, listen: false)
              //     .signiModelGetter
              //     .data!
              //     .bearer;
              showLoading();
              // final purchases =
              //     Provider.of<BulkScanProvider>(context, listen: false)
              //         .purchasesGetter;
              await Future.delayed(
                const Duration(seconds: 1),
              );
              // await BulkScanApiCall()
              //     .takeOrderPurchase(locationId.toString(), token, purchases);
              dismissLoading();
              edgeAlert(context,
                  backgroundColor: Colors.green,
                  title: 'Purchases Updated Successfully');
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.send),
          )
        ],
      ),
      body: LayoutBuilder(builder: (context, constraits) {
        if (items.isNotEmpty) {
          return Stack(
            children: [
              ListView.separated(
                  controller: _listScrollPage,
                  itemBuilder: (context, index) {
                    if (index < items.length) {
                      return ListTile(
                        isThreeLine: true,
                        leading: CircleAvatar(
                          child: Text('$index'),
                        ),
                        onTap: () {
                          // Navigator.of(context).pushNamed(
                          //   EditProduct.routeName,
                          //   arguments: data,
                          // );
                          Navigator.of(context).pushNamed(
                            CreatePurchaseEditProduct.routeName,
                            arguments: _tempPurchasesItem,
                          );
                        },
                        title: Text("Product : $index"),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: '',
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: 'Product Name : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: 'BISTEK RANCHERO'),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: '',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'Purch.Qty : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: '36.0${index}'),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: '',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'Unit Cost : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: '88${index}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: constraits.maxWidth,
                        height: 50,
                        child: const Center(
                          child: Text("Nothing more to Load "),
                        ),
                      );
                    }
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1,
                    );
                  },
                  itemCount: items.length + (allLoaded ? 1 : 0)),
              if (loading) ...[
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    height: 80,
                    width: constraits.maxWidth,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ],
          );
        } else {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      }),
    );
  }
}

PurchaseBulkScanDatum _tempPurchasesItem = PurchaseBulkScanDatum(
  id: 0,
  productCode: '001',
  proName: 'proName',
  sku: 'sku',
  image: 'image',
  taxNumber: 'TAX',
  ebt: 0,
  cateId: 0,
  cateName: 'cateName',
  price: '0',
  cost: '0',
  margin: '0',
  onHandQty: '0.0',
  qtyAvailable: '0',
  packSize: '1',
  packPrice: '0',
  packUpc: '0.0',
  vendorId: '0',
  caseSize: '0',
  variationId: 0,
  purchaseLineId: 0,
  caseCost: '0.0',
  plu: '0.0',
  unitCost: '1',
  newRetailPrice: '0',
  itemId: 'itemId',
  packageUPC: '0.0',
  wicEligible: '0.0',
  unitId: "0",
  subunitId: '0',
  activeItem: '0.0',
  purchaseLineTaxId: '0.0',
  orderUnit: '0.0',
  orderCase: '0.0',
  extCost: '0.0',
  profitMargin: '1.0',
  caseMargin: '0.0',
  caseRetial: '0.0',
  departmentId: '1',
  stockOfProduct: '0',
);

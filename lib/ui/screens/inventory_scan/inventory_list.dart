import 'package:dummy_app/data/models/Inventory_scan/list_of_inventory_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/inventory_scan_api__function.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/ui/screens/inventory_scan/adjust_inventory.dart';
import 'package:dummy_app/ui/screens/inventory_scan/inventory_scan_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryList extends StatefulWidget {
  static const routeName = '/InventoryList';
  const InventoryList({Key? key}) : super(key: key);

  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  @override
  Widget build(BuildContext context) {
    final signInModelData =
        Provider.of<AuthRequest>(context, listen: false).signiModelGetter;
    final locationId =
        Provider.of<AuthRequest>(context, listen: false).locationFromApiGetter;
    print("This is the Location Id $locationId");
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Inventory Scan",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(InventoryScanList.routeName);
            },
            icon: Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: FutureBuilder(
        builder: (context, snapshhot) {
          if (snapshhot.connectionState == ConnectionState.done) {
            final stringToJson =
                inventoryListModelFromMap(snapshhot.data.toString());
            if (stringToJson.data!.isNotEmpty) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {},
                      isThreeLine: true,

                      title: RichText(
                        text: TextSpan(
                          text: '',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            const TextSpan(
                                text: 'Added By : ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: stringToJson.data![index].addedBy),
                          ],
                        ),
                      ),

                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text('${data.cateName} ${data.taxNumber}'),
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'Date : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: formatofDateForView.format(
                                        stringToJson.data![index]
                                            .transactionDate as DateTime)),
                              ],
                            ),
                          ),

                          RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'Adjustment Type : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: stringToJson
                                        .data![index].adjustmentType),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'Total Amount : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                  text: double.parse(
                                          stringToJson.data![index].finalTotal)
                                      .toStringAsFixed(2),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                const TextSpan(
                                    text: 'Total Amount Recovered : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                  text: double.parse(stringToJson
                                          .data![index].totalAmountRecovered)
                                      .toStringAsFixed(2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      //  Text(stringToJson.data![index].transactionDate!
                      //     .toString()),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: stringToJson.data!.length);
            } else if (stringToJson.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No Data Found',
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: IventoryScanApiCall().listofInventory(
            locationId.id.toString(), signInModelData.data!.bearer),
      ),
    );
  }
}

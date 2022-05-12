import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/ui/screens/auth/change_password_after_sign.dart';

// import 'package:dummy_app/ui/screens/overview/app_pie_chart_widget.dart';
import 'package:dummy_app/ui/screens/auth/sign_in_screen.dart';
import 'package:dummy_app/ui/screens/bulk_scan/bulk_scan_main.dart';
import 'package:dummy_app/ui/screens/gas_price.dart/gas_price_main.dart';
import 'package:dummy_app/ui/screens/inventory_scan/inventory_list.dart';
import 'package:dummy_app/ui/screens/item_search/item_search_main.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_main.dart';
import 'package:dummy_app/ui/screens/overview/overview_main.dart';
import 'package:dummy_app/ui/screens/pos/pos_main.dart';
import 'package:dummy_app/ui/screens/puchase_scan/purchase_scan_main.dart';
import 'package:dummy_app/ui/screens/receipts/receipt_main.dart';
import 'package:dummy_app/ui/screens/support_ticket/create_ticket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AfterSignIn extends StatelessWidget {
  static const routeName = '/AfterSignIn';

  const AfterSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationFromApiBusiness = Provider.of<AuthRequest>(
      context,
    ).locationFromApiGetter;
    final locationFromApiAllBusiness = Provider.of<AuthRequest>(
      context,
    ).signiModelGetter.data!.location;
    final userNameInfo = Provider.of<AuthRequest>(
      context,
    ).signiModelGetter.data;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Home Screen",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextButton.icon(
              onPressed: () async {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  builder: (BuildContext _) {
                    return Container(
                      child: Wrap(
                        children: [
                          for (var item in locationFromApiAllBusiness!)
                            ListTile(
                              leading: Text(
                                item.id.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.white),
                              ),
                              title: Text(
                                item.name,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              trailing: (item.name ==
                                      locationFromApiBusiness.name)
                                  ? Icon(
                                      CupertinoIcons.check_mark_circled_solid,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      CupertinoIcons.checkmark,
                                      color: Colors.white,
                                    ),
                              onTap: () {
                                Provider.of<AuthRequest>(context, listen: false)
                                    .changeBusiness(item);
                                Navigator.of(context).pop();
                              },
                            ),
                        ],
                        alignment: WrapAlignment.center,
                      ),
                    );
                  },
                  isScrollControlled: true,
                );
              },
              icon: const Icon(
                CupertinoIcons.ellipsis_circle_fill,
                color: Colors.green,
                size: 18,
              ),
              label: Text(
                locationFromApiBusiness.name,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ],
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.4,
        ),
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(OverViewMain.routeName);
            },
            child: const GridTileofApp(
              firstText: '\nOverview',
              secondText: '(Live)',
              iconData: CupertinoIcons.chart_bar,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(GasPriceMainScreen.routeName);
            },
            child: const GridTileofApp(
              firstText: 'Gas',
              secondText: 'Price',
              iconData: CupertinoIcons.play,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ItemSearchMainPage.routeName);
            },
            child: const GridTileofApp(
              firstText: 'Item',
              secondText: 'Search',
              iconData: CupertinoIcons.search,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(CreateTicket.routeName);
            },
            child: const GridTileofApp(
              firstText: 'Support',
              secondText: 'Ticket',
              iconData: CupertinoIcons.ticket,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(InventoryList.routeName);
            },
            child: const GridTileofApp(
              firstText: 'Inventory',
              secondText: 'Scan',
              iconData: CupertinoIcons.square_stack_3d_down_right,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(BulkScanMian.routeName);
            },
            child: const GridTileofApp(
              firstText: 'Bulk',
              secondText: 'Scan',
              iconData: CupertinoIcons.app_badge,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(PurchaseScanMain.routeName);
            },
            child: const GridTileofApp(
              firstText: 'Purchase',
              secondText: 'Scan',
              iconData: CupertinoIcons.purchased_circle,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(MaintainanceMain.routeName);
            },
            child: const GridTileofApp(
              firstText: 'Maintaince',
              secondText: '',
              iconData: CupertinoIcons.recordingtape,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ReceiptMain.routeName);
            },
            child: const GridTileofApp(
              firstText: 'Receipts',
              secondText: '',
              iconData: CupertinoIcons.tickets_fill,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(PosMainSreen.routeName);
              // Navigator.of(context).pushNamed(ReceiptMain.routeName);
            },
            child: const GridTileofApp(
              firstText: 'POS',
              secondText: '',
              iconData: CupertinoIcons.selection_pin_in_out,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: buttonColor,
              ),
              child: Center(
                child: Text(
                  'Hey ${userNameInfo!.surname} ${userNameInfo.firstName} ${userNameInfo.lastName}',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Change Password',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: buttonColor),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushReplacementNamed(ChangePasswordAfterSignIn.routeName);
              },
            ),
            ListTile(
              title: Text(
                'Log Out',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: buttonColor),
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushReplacementNamed(SignInScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GridTileofApp extends StatelessWidget {
  const GridTileofApp({
    Key? key,
    required this.iconData,
    required this.firstText,
    required this.secondText,
  }) : super(key: key);
  final IconData iconData;
  final String firstText;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Icon(
                iconData,
                size: 50,
                color: buttonColor,
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            '\n$firstText',
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: buttonColor),
          ),
        ),
        Center(
          child: Text(
            secondText,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: buttonColor),
          ),
        ),
      ],
    );
  }
}

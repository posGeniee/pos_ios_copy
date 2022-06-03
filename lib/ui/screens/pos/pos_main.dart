import 'package:dummy_app/data/models/item%20search%20model/scan_bar_code.dart';
import 'package:dummy_app/data/models/pos/mix_and_match_pos.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/pos_provider.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/helpers/scalling.dart';
import 'package:dummy_app/ui/screens/bulk_scan/scanned_bulk_products.dart';
import 'package:dummy_app/ui/screens/item_search/ItemEdit/widgets/department_edit.dart';
import 'package:dummy_app/ui/screens/overview/sale_item_summary.dart';
import 'package:dummy_app/ui/screens/pos/add_new_customer.dart';
import 'package:dummy_app/ui/screens/pos/list_of_products_search.dart';
import 'package:dummy_app/ui/screens/pos/pos_scanner.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
// import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:provider/provider.dart';

import '../../../data/models/pos/customer_list.dart';
import '../../../helpers/helper function api/pos_module_api.dart';

class PosMainSreen extends StatefulWidget {
  static const routeName = '/PosMainSreen';

  const PosMainSreen({Key? key}) : super(key: key);

  @override
  _PosMainSreenState createState() => _PosMainSreenState();
}

class _PosMainSreenState extends State<PosMainSreen>
    with SingleTickerProviderStateMixin {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    if (!mounted) return;
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  late List<Datum> customerListItems;
  late Animation<double> _animation;
  late AnimationController _animationController;
  int _index = 0;
  String customerPoints = '0.00';
  String customerAmount = '0';
  String billAmount = '0';
  String billPoints = '0';
  String totalPoints = '0';
  String totalAmount = '0';

  mixAndMatch() async {
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;

    await Future.delayed(Duration.zero);
    showLoading();

    //Business Setting Api call....
    final responseBusinessSettingList =
        await PosModuleApi().businessSettings(token);
    print('responseBusinessSettingList : $responseBusinessSettingList');
    Provider.of<PosSectionProvider>(context, listen: false)
        .businessSettingSetter(responseBusinessSettingList);

    //MixMatch Api call...
    final responseMixMatch = await PosModuleApi()
        .mixAndMatchPosProductData(locationId.toString(), token);
    print('responseMixMatch : $responseMixMatch');
    Provider.of<PosSectionProvider>(context, listen: false)
        .mixMatchSetter(responseMixMatch);

    //Customer List Api Call....
    final responseCustomerList = await PosModuleApi().customerList(token);
    print('responseCustomerList : $responseCustomerList');
    Provider.of<PosSectionProvider>(context, listen: false)
        .customerListSetter(responseCustomerList);

    dismissLoading();
  }

  @override
  void initState() {
    mixAndMatch();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var posProvider = Provider.of<PosSectionProvider>(context, listen: true);

    posProvider.customerListFirstItem();

    final List<ScanBarCodeDatum> data = posProvider.productListGetter;

    if (data.isNotEmpty) {
      print(
          'posProvider.customerListFirstItemGetter >>>> : ${posProvider.customerListFirstItemGetter}');
      customerListItems = posProvider.customerListGetter;

      var businessSetting = posProvider.businesssSettingListGetter;
      billPoints = posProvider.totalBillPointsGetter.toStringAsFixed(2);

      billAmountCal() {
        billAmount = ((double.parse(billPoints) /
                    double.parse(businessSetting.elementAt(0).loyaltyPoint)) *
                double.parse(businessSetting.elementAt(0).loyaltyAmount))
            .toStringAsFixed(2);

        print(
            '>>>>>>>>>>>> loyaltyPoint : ${businessSetting.elementAt(0).loyaltyPoint} ... loyaltyAmount : ${businessSetting.elementAt(0).loyaltyAmount} ... billAmount : $billAmount');

        if (double.parse(billAmount) % 1 == 0) {
          billAmount = double.parse(billAmount).round().toString();
        }
      }

      billPointsCal() {
        if (billPoints != '0.00') {
          if (double.parse(billPoints) % 1 == 0) {
            billPoints = double.parse(billPoints).round().toString();
            print(
                'billPoints 1 >>>>>>>> $billPoints  double.parse(billPoints) % 1 == 0');
          }
          billAmountCal();
        } else {
          print('billPoints: $billPoints');
          billPoints = double.parse(billPoints).round().toString();
        }
      }

      customerAmountCal() {
        customerAmount = ((double.parse(customerPoints) /
                    double.parse(businessSetting.elementAt(0).loyaltyPoint)) *
                double.parse(businessSetting.elementAt(0).loyaltyAmount))
            .toStringAsFixed(2);

        print(
            '>>>>>>>>>>>> loyaltyPoint : ${businessSetting.elementAt(0).loyaltyPoint} ... loyaltyAmount : ${businessSetting.elementAt(0).loyaltyAmount} ... customerAmount : $customerAmount');

        if (double.parse(customerAmount) % 1 == 0) {
          customerAmount = double.parse(customerAmount).round().toString();
        }
      }

      customerPointsCal() {
        if (customerPoints != '0.00') {
          if (double.parse(customerPoints) % 1 == 0) {
            customerPoints = double.parse(customerPoints).round().toString();
            print(
                'customerPoints 1 >>>>>>>> $customerPoints  double.parse(customerPoints) % 1 == 0');
          }
          customerAmountCal();
        } else {
          customerPoints = double.parse(customerPoints).round().toString();
          print('customerPoints: $customerPoints');
        }
      }

      totalPointsCal() {
        totalPoints = (double.parse(customerPoints) + double.parse(billPoints))
            .toStringAsFixed(2);
        if (double.parse(totalPoints) % 1 == 0) {
          totalPoints = double.parse(totalPoints).round().toString();
        }
        totalAmount = (double.parse(customerAmount) + double.parse(billAmount))
            .toStringAsFixed(2);
        if (double.parse(totalAmount) % 1 == 0) {
          totalAmount = double.parse(totalAmount).round().toString();
        }
      }

      customerPointsCal();
      billPointsCal();
      totalPointsCal();
    }

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "POS",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          TextButton.icon(
            label: Text(
              'Products',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 18, color: buttonColor),
            ),
            icon: const Icon(
              CupertinoIcons.list_bullet,
              color: buttonColor,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                builder: (BuildContext _) {
                  return const NewWidgetTemp();
                },
                isScrollControlled: true,
              );
            },
          ),
          TextButton.icon(
            label: Text(
              'Search',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 18, color: buttonColor),
            ),
            icon: const Icon(
              CupertinoIcons.search,
              color: buttonColor,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                builder: (BuildContext _) {
                  return const SearchWidgetofPos();
                },
                isScrollControlled: true,
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
// Check the
      //Init Floating Action Bubble
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionBubble(
          // Menu items
          items: <Bubble>[
            // Floating action menu item

            //Floating action menu item
            Bubble(
              title: "Cash",
              iconColor: Colors.white,
              bubbleColor: buttonColor,
              icon: CupertinoIcons.money_dollar,
              titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
              onPress: () {
                _animationController.reverse();
                Provider.of<PosSectionProvider>(context, listen: false)
                    .removeAll();
                // Navigator.of(context).pushNamed(PartCommentScreen.routeName);
              },
            ),
          ],

          // animation controller
          animation: _animation,

          // On pressed change animation state
          onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),

          // Floating Action button Icon color
          iconColor: Colors.white,

          // Flaoting Action button Icon
          iconData: Icons.edit,
          backGroundColor: buttonColor,
        ),
      ),
      body: (data.isEmpty)
          ? const Center(child: Text('No Product has been Found'))
          : Column(
              children: [
                SizedBox(height: 5),
                customerPointsCard(customerListItems),
                SizedBox(
                  height: 120,
                  child: PageView(
                    controller: PageController(viewportFraction: 0.95),
                    onPageChanged: (int index) =>
                        setState(() => _index = index),
                    children: [
                      AppCardWidget(
                        itemName: 'TOTAL Bill',
                        itemValue: Provider.of<PosSectionProvider>(context)
                            .totalAmountGetter
                            .toStringAsFixed(2),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: CartCard(cart: data[index]),
                      );
                    },
                    itemCount: data.length,
                  ),
                )
              ],
            ),
    );
  }

  Padding customerPointsCard(List<Datum> customerListItems) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.green.shade800,
                Colors.green.shade300,
                Colors.green.shade800,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                dropdownSearch(customerListItems),
                pointsCalculations(
                    'Customer points', customerPoints, customerAmount),
                pointsCalculations('Bill points', billPoints, billAmount),
                pointsCalculations('Total points', totalPoints, totalAmount),
                SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding dropdownSearch(List<Datum> customerListItems) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Theme(
              data: ThemeData(
                textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white)),
              ),
              child: DropdownSearch<String>(
                mode: Mode.DIALOG,
                showSelectedItems: true,
                items: customerListItems.isNotEmpty
                    ? customerListItems
                        .map((e) => '${e.name} # ${e.mobile}')
                        .toList()
                    : null,
                dropdownSearchDecoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 0),
                  labelText: "Select your customer",
                  hintText: "Select your customer",
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                showSearchBox: true,
                dropdownButtonProps: const IconButtonProps(
                  iconSize: 30,
                  icon: Icon(Icons.arrow_drop_down),
                  color: Colors.white,
                ),
                onChanged: (abc) {
                  customerListItems.where((element) {
                    if ('${element.name} # ${element.mobile}' == abc) {
                      setState(() {
                        customerPoints = double.parse(element.usedLoyaltyPoint).toStringAsFixed(2);
                        print('onChange >>>>>>>>>>>>>>> customerPoints : $customerPoints');
                      });
                    }
                    return false;
                  }).toString();
                },
                selectedItem: customerListItems.isNotEmpty
                    ? '${customerListItems.elementAt(0).name} # ${customerListItems.elementAt(0).mobile}'
                    : 'Select your customer',
              ),
            ),
          ),
          SizedBox(
              width: 50,
              child: Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNewCustomer()));
                    },
                    child: Icon(Icons.add_circle_outline,
                        color: Colors.white, size: 35),
                  ))),
        ],
      ),
    );
  }

  Row pointsCalculations(var name, var points, var usd) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        Text('$points ($usd\$)',
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class NewWidgetTemp extends StatelessWidget {
  const NewWidgetTemp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dummyData = dummyListConverter(dummyDataPos);
    return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
                height: 100,
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: DepartmentEditTextForField(),
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: dummyData.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: kDefaultPaddin,
                      crossAxisSpacing: kDefaultPaddin,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) => ItemCard(
                          product: dummyData[index],
                          press: () => {},
                        )),
              ),
            ),
          ],
        ));
  }
}

enum _SelectedTab { home, favorite, search, person }

class ItemCard extends StatelessWidget {
  final ScanBarCodeDatum product;
  final Function press;

  const ItemCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<PosSectionProvider>(context, listen: false)
            .addtoProductList(context, product);
        Navigator.of(context).pop();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(kDefaultPaddin),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${product.id}",
                child: Image.network(
                  'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              product.proName,
              style: const TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\$${double.parse(product.unitCost).toStringAsFixed(2)}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class CartCard extends StatefulWidget {
  ScanBarCodeDatum cart;

  CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  final itemQty = TextEditingController(text: '1.0');
  bool checkMixMatchDiscount = false;

  @override
  void initState() {
    // TODO: implement initState
    // checkCartDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    init(context);

    return Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              flex: 2,
              onPressed: (context) {
                Provider.of<PosSectionProvider>(context, listen: false)
                    .removetoProductList(widget.cart);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: Row(
          children: [
            SizedBox(
              width: 88,
              child: AspectRatio(
                aspectRatio: 0.88,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.network(
                    'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cart.proName,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    // overflow: TextOverflow.ellipsis,
                    // maxLines: 2,
                  ),
                  cartRetailPriceDetails(context),
                  cartSubTotalDetails(context),
                  Row(children: [
                    IconButton(
                      onPressed: () {
                        if (!mounted) return;
                        setState(() {
                          Provider.of<PosSectionProvider>(context,
                                  listen: false)
                              .totalAmountSetterAdd(widget.cart);
                        });
                      },
                      icon: const Icon(CupertinoIcons.add_circled),
                    ),
                    Text(
                      widget.cart.unitQty,
                    ),
                    IconButton(
                      onPressed: () {
                        if (double.parse(widget.cart.unitQty) == 1) {
                        } else {
                          if (!mounted) return;
                          setState(() {
                            Provider.of<PosSectionProvider>(context,
                                    listen: false)
                                .totalAmountSetterMinus(widget.cart);
                          });
                        }
                      },
                      icon: const Icon(CupertinoIcons.minus_circle),
                    ),
                    // if(widget.cart.mixmatchGroupIdApply == true)
                    //   Text('MixMatch done'),
                  ]),
                ],
              ),
            )
          ],
        ));
  }

  Row cartRetailPriceDetails(BuildContext context) {
    return Row(
      children: [
        const Text('Retail Price : ',
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text(double.parse(widget.cart.retailPrice).toStringAsFixed(2),
            style: TextStyle(
              decoration: widget.cart.onSpecial == 1 &&
                      Provider.of<PosSectionProvider>(context)
                              .isSpecialGetter ==
                          true
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            )),
        SizedBox(width: width(15)),
        if (widget.cart.onSpecial == 1 &&
            Provider.of<PosSectionProvider>(context).isSpecialGetter == true)
          Text(Provider.of<PosSectionProvider>(context)
              .specialPriceGetter
              .toStringAsFixed(2))
      ],
    );
  }

  Row cartSubTotalDetails(BuildContext context) {
    return Row(
      children: [
        const Text('SubTotal : ',
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text(widget.cart.subTotal,
            style: TextStyle(
              decoration: widget.cart.mixMatchGroupApplied
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            )),
        SizedBox(width: width(15)),
        if (widget.cart.mixMatchGroupApplied)
          Text(widget.cart.subtotalAfterDiscount.toStringAsFixed(2)),
      ],
    );
  }
}

class SearchWidgetofPos extends StatefulWidget {
  const SearchWidgetofPos({Key? key}) : super(key: key);

  @override
  _SearchWidgetofPosState createState() => _SearchWidgetofPosState();
}

class _SearchWidgetofPosState extends State<SearchWidgetofPos> {
  final _formKey1 = GlobalKey<FormState>();
  final barCodeName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'Type, Scan or Click the Camera Icon to scan from camera. Click Go button on mobile keyboard to proceed',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: buttonColor,
                      fontSize: 18,
                    ),
                textAlign: TextAlign.justify,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () async {
                    // await [
                    //   Permission.camera,
                    // ].request();
                    // final requestAccessCamera =
                    //     await Permission.camera.isGranted;
                    // if (requestAccessCamera) {
                      Navigator.of(context).pushNamed(
                        PosScanner.routeName,
                      );
                    // }
                  },
                  icon: const Icon(
                    CupertinoIcons.camera,
                    color: buttonColor,
                  ),
                  label: Text(
                    'Scan by Bar Code Image',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey1,
                child: TextFormField(
                  controller: barCodeName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Product name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Please enter Product name',
                    labelText: 'Search by Product name',
                  ),
                  onFieldSubmitted: (value) async {
                    if (_formKey1.currentState!.validate() == true) {
                      Navigator.of(context).pushNamed(
                          SearchProductListByNamePos.routeName,
                          arguments: ScreenArguments(barCodeName.text));
                      // Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

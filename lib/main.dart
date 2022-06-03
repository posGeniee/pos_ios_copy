import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/bulk_provider.dart';
import 'package:dummy_app/data/network/business_provider.dart';
import 'package:dummy_app/data/network/inventory_scan_provider.dart';
import 'package:dummy_app/data/network/item_search_provider.dart';
import 'package:dummy_app/data/network/maintainance_provider.dart';
import 'package:dummy_app/data/network/pos_provider.dart';
import 'package:dummy_app/helpers/theme.dart';
import 'package:dummy_app/services/network_service.dart';
// import 'package:dummy_app/services/premission_services.dart';
import 'package:dummy_app/ui/screens/after_sign_in.dart';
import 'package:dummy_app/ui/screens/auth/change_password.dart';
import 'package:dummy_app/ui/screens/auth/change_password_after_sign.dart';
import 'package:dummy_app/ui/screens/auth/enter_otp.dart';
import 'package:dummy_app/ui/screens/auth/first_screen.dart';
import 'package:dummy_app/ui/screens/auth/forgot_password.dart';
import 'package:dummy_app/ui/screens/auth/home_screen.dart';
import 'package:dummy_app/ui/screens/auth/sign_in_screen.dart';
import 'package:dummy_app/ui/screens/auth/starting_credentials_screen.dart';
import 'package:dummy_app/ui/screens/bulk_scan/bulk_scan_main.dart';
import 'package:dummy_app/ui/screens/bulk_scan/bulk_scannner.dart';
import 'package:dummy_app/ui/screens/bulk_scan/purchase/create_purchase.dart';
import 'package:dummy_app/ui/screens/bulk_scan/scanned_bulk_products.dart';
import 'package:dummy_app/ui/screens/gas_price.dart/gas_price_main.dart';
import 'package:dummy_app/ui/screens/inventory_scan/adjust_inventory.dart';
import 'package:dummy_app/ui/screens/inventory_scan/inventory_list.dart';
import 'package:dummy_app/ui/screens/inventory_scan/inventory_scan_list.dart';
import 'package:dummy_app/ui/screens/inventory_scan/invetory_item_detail.dart';
import 'package:dummy_app/ui/screens/inventory_scan/scanned_Inventory.dart';
import 'package:dummy_app/ui/screens/item_search/ItemEdit/edit_product.dart';
import 'package:dummy_app/ui/screens/item_search/item_search_main.dart';
import 'package:dummy_app/ui/screens/item_search/mix_match_group_prod_screen.dart';
import 'package:dummy_app/ui/screens/item_search/options/add_mix_match_group.dart';
import 'package:dummy_app/ui/screens/item_search/options/add_plu_group.dart';
import 'package:dummy_app/ui/screens/item_search/pagination_example.dart';
import 'package:dummy_app/ui/screens/item_search/plu_group_detail_prod_screen.dart';
import 'package:dummy_app/ui/screens/item_search/plu_group_prod_graph.dart';
import 'package:dummy_app/ui/screens/maintainance/admin_maintainance_main.dart';
import 'package:dummy_app/ui/screens/maintainance/equipment_main.dart';
import 'package:dummy_app/ui/screens/maintainance/event_page.dart';
import 'package:dummy_app/ui/screens/maintainance/machines/machine_add.dart';
import 'package:dummy_app/ui/screens/maintainance/machines/update_machine.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_main.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/maintainance_schedule_main.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/maintainance_schedule_update.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/notes/notes_add.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/notes/notes_main.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/notes/notes_update.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/part_when_schedule/maintainance_when_schedule.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/part_when_schedule/part_add_when_schedule.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/part_when_schedule/part_order_add_when_schedule.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/part_when_schedule/update_parts_order_when_schedule.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/part_when_schedule/update_parts_when_schedule.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/ticket_trip/decisions/decision_update.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/ticket_trip/decisions/decisions_add.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/ticket_trip/decisions/decisions_main.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/ticket_trip/ticket_trip_add.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/ticket_trip/ticket_trip_main.dart';
import 'package:dummy_app/ui/screens/maintainance/maintainance_schedule/ticket_trip/ticket_trip_update.dart';
import 'package:dummy_app/ui/screens/maintainance/orders.dart';
import 'package:dummy_app/ui/screens/maintainance/parts/parts_add.dart';
import 'package:dummy_app/ui/screens/maintainance/parts/parts_main.dart';
import 'package:dummy_app/ui/screens/maintainance/parts/update_part.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_category/parts_category_add.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_category/parts_category_main.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_category/parts_category_update.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/part_comments.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/part_order_update.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/parts_order_add.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/parts_order_main.dart';
import 'package:dummy_app/ui/screens/maintainance/schedule/assigned_schedule/assigned_schedule_add.dart';
import 'package:dummy_app/ui/screens/maintainance/schedule/assigned_schedule/assigned_schedule_main.dart';
import 'package:dummy_app/ui/screens/maintainance/schedule/schedule_add.dart';
import 'package:dummy_app/ui/screens/maintainance/temperature/temperature_add.dart';
import 'package:dummy_app/ui/screens/maintainance/temperature/temperature_main.dart';
import 'package:dummy_app/ui/screens/overview/overview_main.dart';
import 'package:dummy_app/ui/screens/overview/sale_item_detail.dart';
import 'package:dummy_app/ui/screens/overview/sale_item_summary.dart';
import 'package:dummy_app/ui/screens/item_search/bar_code_scanner_widget.dart';
import 'package:dummy_app/ui/screens/pos/list_of_products_search.dart';
import 'package:dummy_app/ui/screens/pos/pos_main.dart';
import 'package:dummy_app/ui/screens/pos/pos_scanner.dart';
import 'package:dummy_app/ui/screens/puchase_scan/purchase_scan_main.dart';
import 'package:dummy_app/ui/screens/puchase_scan/purchases_list_details.dart';
import 'package:dummy_app/ui/screens/receipts/receipt_detail.dart';
import 'package:dummy_app/ui/screens/receipts/receipt_main.dart';
import 'package:dummy_app/ui/screens/support_ticket/create_ticket.dart';
import 'package:dummy_app/ui/screens/support_ticket/list_of_ticket.dart';
import 'package:dummy_app/ui/screens/support_ticket/support_ticket_comment.dart';
import 'package:catcher/catcher.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import 'data/network/starting_credential_provider.dart';

void main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  CatcherOptions debugOptions =
      CatcherOptions(DialogReportMode(), [ConsoleHandler()]);

  /// Release configuration. Same as above, but once user accepts dialog, user will be prompted to send email with crash to support.
  CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
    EmailManualHandler([
      "shahryar.r101@gmail.com",
      "support@theposgeniee.com",
      "m.umairashraf786@gmail.com"
    ])
  ]);

  /// STEP 2. Pass your root widget (MyApp) along with Catcher configuration:
  Catcher(
      rootWidget: const MyApp(),
      debugConfig: debugOptions,
      releaseConfig: releaseOptions);
  // FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthRequest>(
          create: (_) => AuthRequest(),
        ),
        ChangeNotifierProvider<BusinessProvider>(
          create: (_) => BusinessProvider(),
        ),
        //ItemSearch Tab of the App
        ChangeNotifierProvider<ItemSearchProvider>(
          create: (_) => ItemSearchProvider(),
        ),
        //For Inventory Scan
        ChangeNotifierProvider<InventoryScanProvider>(
          create: (_) => InventoryScanProvider(),
        ),
        //For Bulk Scan
        ChangeNotifierProvider<BulkScanProvider>(
          create: (_) => BulkScanProvider(),
        ),
        // User Location of the App
        // StreamProvider<UserLocation>(
        //   create: (_) => LocationService().locationGetterStream,
        //   initialData: UserLocation(latitude: 0.0, longitude: 0.0),
        // ),
        //Stream to Get the Connectivity of the User with WIFI and Mobile.
        // StreamProvider<ConnectivityResult>(
        //   create: (_) => NetworkStatusService().networkGetterStream,
        //   initialData: ConnectivityResult.wifi,
        // ),
        //Stream to Get the Whetherthe User is online or Offline.
        // StreamProvider<NetworkStatus>(
        //   create: (_) => NetworkStatusService().dataConncectionStream,
        //   initialData: NetworkStatus.offline,
        // ),
        //Stream to Get the Whether the User Accepted the Premission of the App or not.
        // StreamProvider<PremissonChange>(
        //   create: (_) => PremisiionServiceofApp().premissonChange,
        //   initialData: PremissonChange.isDenied,
        // ),
        //For Bulk Scan
        ChangeNotifierProvider<MaintainanceProvider>(
          create: (_) => MaintainanceProvider(),
        ),
        //Pos Section Provider
        ChangeNotifierProvider<PosSectionProvider>(
          create: (_) => PosSectionProvider(),
        ),
        ChangeNotifierProvider<CredentialProvider>(
          create: (_) => CredentialProvider(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: theme(),
          debugShowCheckedModeBanner: false,
          // home: const StartingCredentialsScreen(),
          home: const HomeScreen(),
          navigatorKey: Catcher.navigatorKey,
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(),
          routes: {
            HomeScreen.routeName: (context) => const HomeScreen(),
            ForgotPassword.routeName: (context) => const ForgotPassword(),
            EnterOTP.routeName: (context) => const EnterOTP(),
            ChangePassword.routeName: (context) => const ChangePassword(),
            SignInScreen.routeName: (context) => const SignInScreen(),
            AfterSignIn.routeName: (context) => const AfterSignIn(),
            ChangePasswordAfterSignIn.routeName: (context) =>
                const ChangePasswordAfterSignIn(),
            //OverView Module --
            OverViewMain.routeName: (context) => const OverViewMain(),
            SaleItemSummary.routeName: (context) => const SaleItemSummary(),
            SaleItemDetail.routeName: (context) => const SaleItemDetail(),

            //Gas Price
            GasPriceMainScreen.routeName: (context) =>
                const GasPriceMainScreen(),
            ItemSearchMainPage.routeName: (context) =>
                const ItemSearchMainPage(),
            AddPluGroup.routeName: (context) => const AddPluGroup(),
            AddMixMatchGroup.routeName: (context) => const AddMixMatchGroup(),
            ScannerScreen.routeName: (context) => const ScannerScreen(),
            PluGroupProductScreen.routeName: (context) =>
                const PluGroupProductScreen(),
            MixMatchProdScreen.routeName: (context) =>
                const MixMatchProdScreen(),
            PluGroupProdGraph.routeName: (context) => const PluGroupProdGraph(),
            PaginationExample.routeName: (context) => const PaginationExample(),
            //Support Ticket
            EditProduct.routeName: (context) => const EditProduct(),
            CreateTicket.routeName: (context) => const CreateTicket(),
            PreviousTickets.routeName: (context) => const PreviousTickets(),
            SupportCommentScreen.routeName: (context) =>
                const SupportCommentScreen(),

            //Inventory Scan Module
            InventoryList.routeName: (context) => const InventoryList(),
            ScannedInventoryProducts.routeName: (context) =>
                const ScannedInventoryProducts(),
            InventoryScanList.routeName: (context) => const InventoryScanList(),
            AdjustInventory.routeName: (context) => const AdjustInventory(),
            InventoryItemDetail.routeName: (context) =>
                const InventoryItemDetail(),
            //Bulk Scan Module
            BulkScanMian.routeName: (context) => const BulkScanMian(),
            ScanBulkScanList.routeName: (context) => const ScanBulkScanList(),
            ScannedBulkProducts.routeName: (context) =>
                const ScannedBulkProducts(),
            //Purchase & Bulk Merge
            CreatePurchaseEditProduct.routeName: (context) =>
                const CreatePurchaseEditProduct(),

            //Reciept Main
            ReceiptMain.routeName: (context) => const ReceiptMain(),
            ReceiptDetail.routeName: (context) => const ReceiptDetail(),

            // Purchase Scan
            PurchaseScanMain.routeName: (context) => const PurchaseScanMain(),
            PurchaseListDetails.routeName: (context) =>
                const PurchaseListDetails(),

            //Maintainance Scan
            MaintainanceMain.routeName: (context) => const MaintainanceMain(),
            AddMachineScreen.routeName: (context) => const AddMachineScreen(),
            UpdateMachineScreen.routeName: (context) =>
                const UpdateMachineScreen(),
            PartsMainScreen.routeName: (context) => const PartsMainScreen(),
            PartsMainAddScreen.routeName: (context) =>
                const PartsMainAddScreen(),
            UpdatePartScreen.routeName: (context) => const UpdatePartScreen(),
            //Add Parts and Part Order When Schedule
            // PartsOrderMainScreenWhenSchedule.routeName: (context) =>
            //     const PartsOrderMainScreenWhenSchedule(),
            MaintainanceMainWhenSchedule.routeName: (context) =>
                const MaintainanceMainWhenSchedule(),
            PartsMainAddScreenWhenScedule.routeName: (context) =>
                const PartsMainAddScreenWhenScedule(),
            PartsMainUpdateScreenWhenScedule.routeName: (context) =>
                const PartsMainUpdateScreenWhenScedule(),
            AddPartOrderWhenSchedule.routeName: (context) =>
                const AddPartOrderWhenSchedule(),
            UpdatePartOrderWhenSchedule.routeName: (context) =>
                const UpdatePartOrderWhenSchedule(),

            TemperatureMainScreen.routeName: (context) =>
                const TemperatureMainScreen(),
            AddMachineTemperature.routeName: (context) =>
                const AddMachineTemperature(),
            ScheduleAdd.routeName: (context) => const ScheduleAdd(),
            AssignedMainMachine.routeName: (context) =>
                const AssignedMainMachine(),
            AddAssignedMachineScreen.routeName: (context) =>
                const AddAssignedMachineScreen(),
            MaintainanceScheduleMain.routeName: (context) =>
                const MaintainanceScheduleMain(),
            MaintainanceScheduleUpdate.routeName: (context) =>
                const MaintainanceScheduleUpdate(),
            TicketTripMain.routeName: (context) => const TicketTripMain(),
            AddTicketTrip.routeName: (context) => const AddTicketTrip(),
            UpdateTicketTrip.routeName: (context) => const UpdateTicketTrip(),
            DecisionMainScreen.routeName: (context) =>
                const DecisionMainScreen(),
            AddDecision.routeName: (context) => const AddDecision(),
            UpdateDecisionScreen.routeName: (context) =>
                const UpdateDecisionScreen(),
            NoteMainScreen.routeName: (context) => const NoteMainScreen(),
            UpdateNoteScreen.routeName: (context) => const UpdateNoteScreen(),
            AddNote.routeName: (context) => const AddNote(),
            PartsCategoryMainScreen.routeName: (context) =>
                const PartsCategoryMainScreen(),
            AddPartCategoryScreen.routeName: (context) =>
                const AddPartCategoryScreen(),
            UpdateCategoryParts.routeName: (context) =>
                const UpdateCategoryParts(),
            PartsOrderMainScreen.routeName: (context) =>
                const PartsOrderMainScreen(
                  showAppBar: true,
                ),
            AddPartOrderScreen.routeName: (context) =>
                const AddPartOrderScreen(),
            UpdatePartOrderScreen.routeName: (context) =>
                const UpdatePartOrderScreen(),
            UpdatePartOrderWhenSchedule.routeName: (context) =>
                const UpdatePartOrderWhenSchedule(),
            PartCommentScreen.routeName: (context) => const PartCommentScreen(),
            //Pos Section
            PosMainSreen.routeName: (context) => PosMainSreen(),
            PosScanner.routeName: (context) => const PosScanner(),
            SearchProductListByNamePos.routeName: (context) =>
                const SearchProductListByNamePos(),
          },
        );
      },
    );
  }
}

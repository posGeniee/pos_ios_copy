// import 'package:dummy_app/data/network/maintainance_provider.dart';
// import 'package:dummy_app/helpers/const.dart';
// import 'package:dummy_app/helpers/helper_funtions.dart';
// import 'package:dummy_app/helpers/widget.dart';
// import 'package:dummy_app/ui/screens/maintainance/parts_order/part_comments.dart';
// import 'package:dummy_app/ui/screens/maintainance/parts_order/parts_category_edit_field.dart';
// import 'package:floating_action_bubble/floating_action_bubble.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// class UpdatePartOrderWhenSchedule extends StatefulWidget {
//   static const routeName = '/UpdatePartOrderWhenSchedule';
//   const UpdatePartOrderWhenSchedule({Key? key}) : super(key: key);

//   @override
//   _UpdatePartOrderWhenScheduleState createState() =>
//       _UpdatePartOrderWhenScheduleState();
// }

// class _UpdatePartOrderWhenScheduleState
//     extends State<UpdatePartOrderWhenSchedule>
//     with SingleTickerProviderStateMixin {
//   final nameField = TextEditingController();

//   final linkField = TextEditingController();
//   final descriptionField = TextEditingController();
//   final supplierField = TextEditingController();
//   final categoryField = TextEditingController();

//   String dropDownValue = 'None';

//   late Animation<double> _animation;
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 260),
//     );

//     final curvedAnimation =
//         CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
//     _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final data = Provider.of<MaintainanceProvider>(
//       context,
//     ).selectedCustomerListModelDatumGetter;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         title: Text(
//           "Update Part Order",
//           style: Theme.of(context).textTheme.headline6,
//         ),
//         actions: [
//           appButttonWithoutAnimationWithoutDecoration(
//             context,
//             CupertinoIcons.share_up,
//             'Save',
//             () async {},
//           ),
//         ],
//       ),
//       // floatingActionButton:
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
// // Check the
//       //Init Floating Action Bubble
//       floatingActionButton: FloatingActionBubble(
//         // Menu items
//         items: <Bubble>[
//           // Floating action menu item
//           Bubble(
//             title: "Delete",
//             iconColor: Colors.red,
//             bubbleColor: buttonColor,
//             icon: Icons.delete,
//             titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
//             onPress: () {
//               _animationController.reverse();
//             },
//           ),
//           //Floating action menu item
//           Bubble(
//             title: "Comments",
//             iconColor: Colors.white,
//             bubbleColor: buttonColor,
//             icon: Icons.description,
//             titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
//             onPress: () {
//               _animationController.reverse();

//               Navigator.of(context).pushNamed(PartCommentScreen.routeName);
//             },
//           ),
//         ],

//         // animation controller
//         animation: _animation,

//         // On pressed change animation state
//         onPress: () => _animationController.isCompleted
//             ? _animationController.reverse()
//             : _animationController.forward(),

//         // Floating Action button Icon color
//         iconColor: Colors.white,

//         // Flaoting Action button Icon
//         iconData: Icons.edit,
//         backGroundColor: buttonColor,
//       ),

//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: TextFormField(
//                 readOnly: true,
//                 onTap: () {
//                   // showModalBottomSheet(
//                   //   context: context,
//                   //   shape: const RoundedRectangleBorder(
//                   //     borderRadius:
//                   //         BorderRadius.vertical(top: Radius.circular(30)),
//                   //   ),
//                   //   builder: (BuildContext _) {
//                   //     return const PartsCategoryEditFieldModelSheet();
//                   //   },
//                   //   isScrollControlled: true,
//                   // );
//                 },
//                 controller: categoryField,
//                 decoration: InputDecoration(
//                   hintText: data.fullName,
//                   labelText: 'Parts Category : ',
//                   suffixIcon: const Icon(
//                     Icons.search,
//                     color: buttonColor,
//                   ),
//                 ),
//               ),
//             ),
//             newAppField(nameField, 'Name', TextInputType.number,
//                 [FilteringTextInputFormatter.digitsOnly], TextInputAction.next,
//                 readOnly: false),
//             newAppField(
//                 linkField, 'Link', TextInputType.name, [], TextInputAction.next,
//                 readOnly: false),
//             newAppField(supplierField, 'Supplier', TextInputType.name, [],
//                 TextInputAction.next,
//                 readOnly: false),
//             newAppField(descriptionField, 'Description', TextInputType.name, [],
//                 TextInputAction.next,
//                 readOnly: false),
//             Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: DropdownButtonFormField(
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(30.0),
//                     ),
//                   ),
//                   hintText: "Select the Status",
//                 ),
//                 value: dropDownValue,
//                 onChanged: (value) {
//                   print("This si the Value Selected $value");
//                 },
//                 items: ['None', 'Yes', 'No']
//                     .map(
//                       (cityTitle) => DropdownMenuItem(
//                         value: cityTitle,
//                         child: Text(cityTitle),
//                       ),
//                     )
//                     .toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

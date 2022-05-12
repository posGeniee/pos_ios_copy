// import 'package:dummy_app/data/network/auth_request.dart';
// import 'package:dummy_app/data/network/item_search_provider.dart';
// import 'package:dummy_app/helpers/const.dart';
// import 'package:dummy_app/ui/screens/item_search/widgets/search_delegate_of_mix_match_group.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class TagEditFormField extends StatefulWidget {
//   const TagEditFormField({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<TagEditFormField> createState() => _TagEditFormFieldState();
// }

// class _TagEditFormFieldState extends State<TagEditFormField> {
//   final ScrollController mixMatchscrollController = ScrollController();
//   bool isPopularEnd = false;
//   bool isLoading = true;
//   bool allLoaded = false;

//   mixMatchGroupList() async {
//     await Provider.of<ItemSearchProvider>(context, listen: false)
//         .getVendorCall()
//         .then((value) {
//       if (!mounted) return; setState(() {
//         isLoading = false;
//       });
//     });

//     mixMatchscrollController.addListener(() {
//       if (mixMatchscrollController.offset <=
//               mixMatchscrollController.position.minScrollExtent &&
//           !mixMatchscrollController.position.outOfRange) {}
//       if (mixMatchscrollController.position.pixels >=
//               mixMatchscrollController.position.maxScrollExtent &&
//           !isPopularEnd) {
//         nextPageCall();
//       }
//     });
//   }

//   nextPageCall() async {
//     if (allLoaded) {
//       return;
//     }
//     if (!mounted) return; setState(() {
//       isPopularEnd = true;
//     });
//     print('Next Page Call---');

//     final data = await Provider.of<ItemSearchProvider>(context, listen: false)
//         .getVendorCall();
//     if (data == 'No Data Found') {
//       print("This si the runsingljlfsf s");
//       if (!mounted) return; setState(() {
//         allLoaded = true;
//         isPopularEnd = false;
//       });
//     } else {
//       if (!mounted) return; setState(() {
//         isPopularEnd = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     mixMatchGroupList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final locationFromApiBusiness = Provider.of<AuthRequest>(
//       context,
//     ).locationFromApiGetter;
//     return TextFormField(
//       readOnly: true,
//       onTap: () {
//         showModalBottomSheet(
//           context: context,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//           ),
//           builder: (BuildContext _) {
//             return StatefulBuilder(builder: (BuildContext context,
//                 StateSetter if (!mounted) return; setState /*You can rename this!*/) {
//               return SizedBox(
//                 height: 400,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 20,
//                       width: MediaQuery.of(context).size.width * 2,
//                     ),
//                     Text(
//                       "Tags",
//                       style: Theme.of(context).textTheme.headline6!.copyWith(
//                             color: buttonColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                       width: MediaQuery.of(context).size.width * 2,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: TextFormField(
//                         readOnly: true,
//                         onTap: () async {
//                           final toDo = await showSearch(
//                             context: context,
//                             delegate: ToDoSearchDelegateofMixMatchGroup(),
//                           );
//                         },
//                         keyboardType: TextInputType.number,
//                         textInputAction: TextInputAction.next,
//                         decoration: const InputDecoration(
//                           hintText: 'Please enter Tag',
//                           labelText: 'Search by Tag',
//                         ),
//                         onFieldSubmitted: (value) {},
//                       ),
//                     ),
//                     if (Provider.of<ItemSearchProvider>(context)
//                         .vendorGetter!
//                         .isNotEmpty)
//                       Expanded(
//                         child: ListView.builder(
//                           controller: mixMatchscrollController,
//                           physics: const BouncingScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             print(
//                                 "Thi si the Length of List ${Provider.of<ItemSearchProvider>(context).mixMatchGroupListGetter!.length}");
//                             final getData =
//                                 Provider.of<ItemSearchProvider>(context)
//                                     .vendorGetter;
//                             return ListTile(
//                               leading: Text(
//                                 getData![index].id.toString(),
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .subtitle1!
//                                     .copyWith(color: Colors.white),
//                               ),
//                               title: Text(
//                                 getData[index].supplier,
//                                 style: Theme.of(context).textTheme.subtitle1,
//                               ),
//                               trailing: (getData[index].supplier ==
//                                       locationFromApiBusiness.name)
//                                   ? const Icon(
//                                       CupertinoIcons.check_mark_circled_solid,
//                                       color: Colors.green,
//                                     )
//                                   : const Icon(
//                                       CupertinoIcons.checkmark,
//                                       color: Colors.white,
//                                     ),
//                               onTap: () {
//                                 Navigator.of(context).pop();
//                                 // Navigator.of(context)
//                                 //     .pushNamed(PluGroupProductScreen.routeName);
//                               },
//                             );
//                           },
//                           itemCount: Provider.of<ItemSearchProvider>(context)
//                               .vendorGetter!
//                               .length,
//                         ),
//                       )
//                     else
//                       CircularProgressIndicator(),
//                     SizedBox(
//                       height: 20,
//                       width: MediaQuery.of(context).size.width * 2,
//                     ),
//                   ],
//                 ),
//               );
//             });
//           },
//           isScrollControlled: true,
//         );
//       },
//       decoration: const InputDecoration(
//         hintText: 'None Selected',
//         labelText: 'Search by Tag',
//         suffixIcon: Icon(
//           Icons.search,
//           color: buttonColor,
//         ),
//       ),
//     );
//   }
// }

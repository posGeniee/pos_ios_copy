import 'package:dummy_app/data/models/item%20search%20model/mix_match_group_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/data/network/business_provider.dart';
import 'package:dummy_app/helpers/helper%20function%20api/item_search_api_function.dart';
import 'package:dummy_app/ui/screens/item_search/mix_match_group_prod_screen.dart';
import 'package:dummy_app/ui/screens/item_search/plu_group_detail_prod_screen.dart';
import 'package:dummy_app/ui/screens/overview/sale_item_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToDoSearchDelegateofMixMatchGroup extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
        // close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<dynamic>?>(
      future: search(context),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!.length == 0) {
            return const Center(
              child: Text("No Data Found"),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].name),
                onTap: () {
                  // close(context, snapshot.data![index]);
                  Navigator.of(context).pushNamed(MixMatchProdScreen.routeName,
                      arguments:
                          ScreenArguments(snapshot.data![index].id.toString()));
                  // Navigator.of(context).pop();
                  // Navigator.of(context).pushNamed(
                  //   NewsDetailsPage.routeName,
                  //   arguments: snapshot.data![index],
                  // );
                },
              );
            },
            itemCount: snapshot.data!.length,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Future<List<dynamic>?> search(BuildContext context) async {
    final locationId = Provider.of<AuthRequest>(context, listen: false)
        .locationFromApiGetter
        .id;
    final token = Provider.of<AuthRequest>(context, listen: false)
        .signiModelGetter
        .data!
        .bearer;
    final String data = await ItemSearchApiFuncion()
        .mixMatchGroupListSearch(query, locationId.toString(), token);
    print("Search Delegate Data Returned --- $data");
    final newList = mixMatchGroupListModelFromMap(data);

    return newList.message!.data;
  }
}

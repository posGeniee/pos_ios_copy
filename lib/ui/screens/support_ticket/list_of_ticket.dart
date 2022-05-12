// import 'package:dummy_app/data/models/support/support_ticket_model.dart';
import 'package:dummy_app/data/models/support/support_ticket_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/support_ticket_api_functions.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/ui/screens/support_ticket/support_ticket_comment.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreviousTickets extends StatefulWidget {
  static const routeName = '/PreviousTickets';
  const PreviousTickets({Key? key}) : super(key: key);

  @override
  _PreviousTicketsState createState() => _PreviousTicketsState();
}

class _PreviousTicketsState extends State<PreviousTickets> {
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
          "Previous Ticket",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: FutureBuilder(
        builder: (context, snapshhot) {
          if (snapshhot.connectionState == ConnectionState.done) {
            final stringToJson =
                supportModelFromJson(snapshhot.data.toString());
            if (stringToJson.message.isNotEmpty) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          SupportCommentScreen.routeName,
                          arguments: stringToJson.message[index],
                        );
                      },
                      isThreeLine: true,
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          stringToJson.message[index].imageUrl,
                          fit: BoxFit.cover,
                          height: 30,
                          width: 30,
                        ),
                      ),
                      title: Text(stringToJson.message[index].name),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Subject : ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: stringToJson.message[index].subject,
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Priorty : ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: stringToJson.message[index].priority,
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Date : ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: formatofDateForView.format(
                                      stringToJson.message[index].createdAt),
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Status : ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: stringToJson.message[index].status,
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Status : ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: stringToJson.message[index].serviceName,
                                  style: Theme.of(context).textTheme.bodyText2,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: stringToJson.message.length);
            } else {
              return const Text('No Data Found');
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        future: SupportTicketsApiFunction()
            .getTickets(locationId.id.toString(), signInModelData.data!.bearer),
      ),
    );
  }
}

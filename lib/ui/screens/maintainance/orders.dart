import 'package:dummy_app/helpers/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaintainanceOrderCurrent extends StatefulWidget {
  static const routeName = '/MaintainanceOrderCurrent';
  const MaintainanceOrderCurrent({Key? key}) : super(key: key);

  @override
  State<MaintainanceOrderCurrent> createState() =>
      _MaintainanceOrderCurrentState();
}

class _MaintainanceOrderCurrentState extends State<MaintainanceOrderCurrent> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: buttonColor,
          statusBarIconBrightness: Brightness.light),
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: buttonColor,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            "Current Order",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              // leading: CircleAvatar(
              //   radius: 30,
              //   child: Image.network(
              //     'https://www.seekpng.com/png/full/60-604032_face-businessman-png-dummy-images-for-testimonials.png',
              //     fit: BoxFit.fill,
              //     height: 40,
              //     width: 40,
              //   ),
              // ),
              title: RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Job : ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Test Tech',
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
                ),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'Status : ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'UnAssign'),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'Customer : ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'UserGo'),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'Machines : ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'peop,daht'),
                      ],
                    ),
                  ),
                  Divider(),

                  // RichText(
                  //   text: TextSpan(
                  //     text: '',
                  //     style: DefaultTextStyle.of(context).style,
                  //     children: <TextSpan>[
                  //       const TextSpan(
                  //           text: 'In Process Job : ',
                  //           style: TextStyle(fontWeight: FontWeight.bold)),
                  //       TextSpan(text: ''),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      )),
    );
  }
}

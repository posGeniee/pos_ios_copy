import 'dart:async';

import 'package:dummy_app/data/models/support/comments/comment_model.dart';
import 'package:dummy_app/data/models/support/support_ticket_model.dart';
import 'package:dummy_app/data/network/auth_request.dart';
import 'package:dummy_app/helpers/helper%20function%20api/support_ticket_api_functions.dart';
import 'package:dummy_app/helpers/helper_funtions.dart';
import 'package:dummy_app/ui/screens/maintainance/parts_order/part_comments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String commmettype = '';

class SupportCommentScreen extends StatefulWidget {
  static const routeName = '/SupportCommentScreen';
  const SupportCommentScreen({Key? key}) : super(key: key);

  @override
  _SupportCommentScreenState createState() => _SupportCommentScreenState();
}

class _SupportCommentScreenState extends State<SupportCommentScreen> {
  ScrollController controller = ScrollController();

  void _scrollDown() {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Parts Comment",
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          IconButton(
            onPressed: _scrollDown,
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SupportTicketMessage(
              scrollController: controller,
            ),
          ),
          SupportTicketNewMessage(),
        ],
      ),
    );
  }
}

// class MessageBubble extends StatelessWidget {
//   final String message;
//   final bool isMe;

//   final String userName;
//   const MessageBubble(
//     this.message,
//     this.isMe,
//     this.userName, {
//     Key? key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(12),
//               topRight: Radius.circular(12),
//               bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
//               bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
//             ),
//           ),
//           width: 140,
//           margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
//           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//           child: Column(
//             crossAxisAlignment:
//                 isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//             children: [
//               Text(
//                 userName,
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: isMe
//                         ? Colors.black
//                         : Theme.of(context).textTheme.headline1!.color),
//               ),
//               Text(
//                 message,
//                 textAlign: isMe ? TextAlign.end : TextAlign.start,
//                 style: TextStyle(
//                     color: isMe
//                         ? Colors.black
//                         : Theme.of(context).accentTextTheme.headline1!.color),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

class SupportTicketMessage extends StatefulWidget {
  SupportTicketMessage({
    Key? key,
    this.scrollController,
  }) : super(
          key: key,
        );
  ScrollController? scrollController;
  @override
  _SupportTicketMessageState createState() => _SupportTicketMessageState();
}

class _SupportTicketMessageState extends State<SupportTicketMessage> {
  List<CommentMessage> message = [
    // CommentMessage('message', 1, 'Shahryar'),
    // CommentMessage('message', 1, 'Shahryar'),
    // CommentMessage('message', 2, 'Ali'),
    // CommentMessage('message', 1, 'Shahryar'),
    // CommentMessage('message', 2, 'Ali'),
  ];
  counter() async {
    await Future.delayed(Duration.zero);
    // print('object');
    final signInModelData =
        Provider.of<AuthRequest>(context, listen: false).signiModelGetter;
    final args = ModalRoute.of(context)!.settings.arguments as Message;
    String responseString = await SupportTicketsApiFunction()
        .getComments(args.id.toString(), signInModelData.data!.bearer);
    var list = commentModelFromJson(responseString);
    setState(() {
      list.map((e) {
        message.add(
          CommentMessage(e.comment, signInModelData.data!.id,
              signInModelData.data!.firstName),
        );
        commmettype = e.type;
        return;
      }).toList();
    });
    print(message.length);
    _scrollDown();

    // Timer.periodic(Duration(seconds: 3), (timer) {});
    // return message;
  }

  @override
  void initState() {
    counter();
    super.initState();
  }

  void _scrollDown() {
    Future.delayed(Duration(seconds: 1), () {
      widget.scrollController!.animateTo(
        widget.scrollController!.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // StreamBuilder(
    // builder: (context, chatSnapshot) {
    //   if (chatSnapshot.connectionState == ConnectionState.waiting) {
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   }

    // List<CommentMessage> chatDocs =
    //     chatSnapshot.data as List<CommentMessage>;

    return ListView.builder(
      reverse: false,
      controller: widget.scrollController,
      itemBuilder: (context, index) {
        return MessageBubble(
          message[index].message,
          message[index].id == 1,
          message[index].userName,
          key: UniqueKey(),
        );
      },
      itemCount: message.length,
    );
    // },
    //   stream: Stream.periodic(const Duration(seconds: 1))
    //       .asyncMap((event) => counter()),
    // );
  }
}

class SupportTicketNewMessage extends StatefulWidget {
  const SupportTicketNewMessage({Key? key}) : super(key: key);

  @override
  _SupportTicketNewMessageState createState() =>
      _SupportTicketNewMessageState();
}

class _SupportTicketNewMessageState extends State<SupportTicketNewMessage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  var _enteredMessage = '';
  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    // if (_formKey.currentState!.validate()) {
    final args = ModalRoute.of(context)!.settings.arguments as Message;
    print(args.id);
    if (!mounted) return;
    showLoading();
    final signInModelData =
        Provider.of<AuthRequest>(context, listen: false).signiModelGetter;

    await SupportTicketsApiFunction().createComment(
        args.id.toString(),
        commmettype,
        signInModelData.data!.username,
        _controller.text,
        signInModelData.data!.bearer);
    dismissLoading();

    // } else {}

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                if (!mounted) return;
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}

class CommentMessage {
  final String message;
  final int id;
  final String userName;

  CommentMessage(this.message, this.id, this.userName);
}

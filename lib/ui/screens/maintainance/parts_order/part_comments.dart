import 'dart:async';

import 'package:flutter/material.dart';

class PartCommentScreen extends StatefulWidget {
  static const routeName = '/PartCommentScreen';
  const PartCommentScreen({Key? key}) : super(key: key);

  @override
  _PartCommentScreenState createState() => _PartCommentScreenState();
}

class _PartCommentScreenState extends State<PartCommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Parts Comment",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  final String userName;
  const MessageBubble(
    this.message,
    this.isMe,
    this.userName, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          width: 140,
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMe
                        ? Colors.black
                        : Theme.of(context).textTheme.headline1!.color),
              ),
              Text(
                message,
                textAlign: isMe ? TextAlign.end : TextAlign.start,
                style: TextStyle(
                    color: isMe
                        ? Colors.black
                        : Theme.of(context).accentTextTheme.headline1!.color),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  List<CommentMessage> message = [
    CommentMessage('message', 1, 'Shahryar'),
    CommentMessage('message', 1, 'Shahryar'),
    CommentMessage('message', 2, 'Ali'),
    CommentMessage('message', 1, 'Shahryar'),
    CommentMessage('message', 2, 'Ali'),
  ];
  counter() {
    Timer.periodic(Duration(seconds: 10), (timer) {
      message.insert(
        0,
        CommentMessage('message', 1, 'Shahryar'),
      );
    });
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<CommentMessage> chatDocs =
            chatSnapshot.data as List<CommentMessage>;

        return ListView.builder(
          reverse: true,
          itemBuilder: (context, index) {
            return MessageBubble(
              chatDocs[index].message,
              chatDocs[index].id == 1,
              chatDocs[index].userName,
              key: UniqueKey(),
            );
          },
          itemCount: chatDocs.length,
        );
      },
      stream: Stream.periodic(const Duration(seconds: 1))
          .asyncMap((event) => counter()),
    );
  }
}

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = '';
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    // final user = FirebaseAuth.instance.currentUser;
    // final userName = await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(user.uid)
    //     .get();
    // // print(userName.get('username'));
    // FirebaseFirestore.instance.collection('chat').add({
    //   'text': _enteredMessage,
    //   'createdAt': Timestamp.now(),
    //   'userId': user.uid,
    //   'username': userName.get('username'),
    // });
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
                if (!mounted) return; setState(() {
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

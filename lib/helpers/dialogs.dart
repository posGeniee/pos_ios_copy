import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> showErrorDialog(
      BuildContext context, GlobalKey key, String errorMessage,
      {String? stringText, Function? onTap}) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        dialogContent(BuildContext context) {
          return Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                  top: Consts.avatarRadius + Consts.padding,
                  bottom: Consts.padding,
                  left: Consts.padding,
                  right: Consts.padding,
                ),
                margin: const EdgeInsets.only(top: Consts.avatarRadius),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(Consts.padding),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // To make the card compact
                  children: <Widget>[
                    Icon(
                      Icons.error,
                      size: 48,
                      color: Theme.of(context).errorColor,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16.0, color: Colors.red),
                    ),
                    const SizedBox(height: 24.0),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // To close the dialog
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        stringText ?? 'OKAY',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: Consts.padding,
                right: Consts.padding,
                child: CircleAvatar(
                  // backgroundImage:
                  //     AssetImage('assets/images/nhwlogo_global.png'),
                  backgroundColor: Colors.transparent,
                  radius: Consts.avatarRadius,
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
              ),
            ],
          );
        }

        return Dialog(
          key: key,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Consts.padding),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: dialogContent(context),
        );
      },
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

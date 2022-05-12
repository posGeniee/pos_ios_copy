// import 'package:flutter/cupertino.dart';
import 'package:dummy_app/helpers/const.dart';
import 'package:flutter/material.dart';

class RegistererMainWidget extends StatelessWidget {
  const RegistererMainWidget({Key? key}) : super(key: key);

  _getSizes() {}

  _getPositions() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0.0, bottom: 8.0, right: 16.0),
      decoration: BoxDecoration(color: buttonColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            '0.00',
            style: TextStyle(
                color: Colors.white,
                fontSize: 50.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            'Current Balance',
            style: TextStyle(
                color: Colors.white,
                fontSize: 26.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

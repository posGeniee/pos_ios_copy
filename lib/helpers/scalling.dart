import 'package:flutter/widgets.dart';
 late MediaQueryData _mediaQueryData;
 late double screenWidth;
 late double screenHeight;
 late double blockSizeHorizontal;
 late double blockSizeVertical;
 late double safeAreaHorizontal;
 late double safeAreaVertical;
 late double safeBlockHorizontal;
 late double safeBlockVertical;
 late double totalPixel;
 double dHeight=812;
 double dWidth=375;
  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth/100;
    blockSizeVertical = screenHeight/100;
    safeAreaHorizontal = _mediaQueryData.padding.left +
        _mediaQueryData.padding.right;
    safeAreaVertical = _mediaQueryData.padding.top +
        _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - safeAreaHorizontal)/100;
    safeBlockVertical = (screenHeight - safeAreaVertical)/100;
    totalPixel =(screenHeight*screenWidth);
  }
  double pixel(double size){
   return (totalPixel/((dHeight*dWidth)/size));
  }
  double height(double height){
    return (screenHeight/(dHeight/height));
  }
  double width(double width){
    return (screenWidth/(dWidth/width));
  }

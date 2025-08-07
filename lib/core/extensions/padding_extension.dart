import 'package:flutter/cupertino.dart';

extension PaddingExtension on Widget{
  Widget addPadding({double? left, double? right, double? top, double? bottom}){
    return Padding(
      padding: EdgeInsets.only(left: left ?? 0, right: right ?? 0, top: top ?? 0, bottom: bottom ?? 0),child: this,);
  }
}
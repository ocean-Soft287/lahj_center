import 'package:flutter/cupertino.dart';

void navigato(context, Widget screen) {
  Navigator.push(
    context,
    CupertinoPageRoute(builder: (context) {
      return screen;
    }),
  );
}

void navigatofinsh(
    context,
    Widget screen,
    bool routeee,
    ) {
  Navigator.pushAndRemoveUntil(
    context,
    CupertinoPageRoute(builder: (context) {
      return screen;
    }),
        (route) => routeee,
  );
}

void navigapop(context) {
  Navigator.pop(context);
}

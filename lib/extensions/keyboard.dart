import 'package:flutter/widgets.dart';

extension Keyboard on BuildContext {
  downKeyboard() {
    final FocusScopeNode focus = FocusScope.of(this);
    if (!focus.hasPrimaryFocus && focus.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
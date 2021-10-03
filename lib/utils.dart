import 'dart:io';

import 'package:flutter/widgets.dart';

bool isMobile() {
  return Platform.isAndroid || Platform.isIOS;
}

bool isDesktop() {
  return Platform.isLinux || Platform.isWindows || Platform.isMacOS;
}

Widget createPlatformBody({required Widget desktop, required Widget mobile}) {
  return isMobile() ? mobile : desktop;
}

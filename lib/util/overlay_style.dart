import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';

void setOverlayStyle(Brightness brightness) {
  try {
    if (!kIsWeb && !kIsWasm && Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemStatusBarContrastEnforced: false,
          statusBarBrightness: brightness,
          statusBarIconBrightness: brightness == .light ? .dark : .light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarContrastEnforced: false,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
      );
    }
  } catch (_) {}
}

void setOverlayStyleOf(BuildContext context) => setOverlayStyle(context.theme.brightness);

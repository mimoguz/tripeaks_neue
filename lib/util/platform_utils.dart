import 'dart:io';

import 'package:flutter/foundation.dart';

final isWeb = kIsWeb || kIsWasm;

final isDesktop = !isWeb && (Platform.isLinux || Platform.isWindows || Platform.isMacOS);

final isDesktopOrWeb = kIsWasm || kIsWeb || Platform.isLinux || Platform.isWindows || Platform.isMacOS;

final canExit = !(isWeb || Platform.isIOS);

import 'dart:io';

import 'package:flutter/foundation.dart';

final isDesktopOrWeb = kIsWasm || kIsWeb || Platform.isLinux || Platform.isWindows || Platform.isMacOS;

final canExit = !(kIsWeb || kIsWasm || Platform.isIOS);

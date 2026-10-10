import 'dart:io';

import 'package:flutter/foundation.dart';

bool isDesktopOrWeb() => kIsWasm || kIsWeb || Platform.isLinux || Platform.isWindows || Platform.isMacOS;

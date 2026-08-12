import 'dart:io';

import 'package:tripeaks_neue/util/abstract_file_picker.dart';
import 'package:tripeaks_neue/util/linux_file_picker.dart' as linux;
import 'package:tripeaks_neue/util/generic_file_picker.dart' as generic;

AbstractFilePicker getFilePicker() => Platform.isLinux ? linux.getFilePicker() : generic.getFilePicker();

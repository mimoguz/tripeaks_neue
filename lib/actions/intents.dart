import 'package:flutter/material.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/pin.dart';

final class TakeIntent extends Intent {
  const TakeIntent(this.pin);

  final Pin pin;
}

final class DrawIntent extends Intent {
  const DrawIntent();
}

final class RollbackIntent extends Intent {
  const RollbackIntent();
}

final class NewGameIntent extends Intent {
  const NewGameIntent();
}

final class NewGameWithLayoutIntent extends Intent {
  const NewGameWithLayoutIntent();
}

final class RestartIntent extends Intent {
  const RestartIntent();
}

final class ExitIntent extends Intent {
  const ExitIntent();
}

final class NavigateToHomeIntent extends Intent {
  const NavigateToHomeIntent({this.replace = false});

  final bool replace;
}

final class NavigateToStatisticsIntent extends Intent {
  const NavigateToStatisticsIntent({this.replace = false});

  final bool replace;
}

final class NavigateToSettingsIntent extends Intent {
  const NavigateToSettingsIntent({this.replace = false});

  final bool replace;
}

final class NavigateToInfoIntent extends Intent {
  const NavigateToInfoIntent({this.replace = false});

  final bool replace;
}

final class SetThemeModeIntent extends Intent {
  const SetThemeModeIntent(this.mode);

  final ThemeMode mode;
}

final class SetShowAllIntent extends Intent {
  const SetShowAllIntent(this.value);

  final bool value;
}

final class SetStartEmptyIntent extends Intent {
  const SetStartEmptyIntent(this.value);

  final bool value;
}

final class SetSoundModeIntent extends Intent {
  const SetSoundModeIntent(this.value);

  final bool value;
}

final class SetDecorIntent extends Intent {
  const SetDecorIntent(this.value);

  final Decor value;
}

final class SetLayoutIntent extends Intent {
  const SetLayoutIntent(this.value);

  final Peaks value;
}

final class ShowNavigationDrawerIntent extends Intent {
  const ShowNavigationDrawerIntent();
}

final class GoBackIntent extends Intent {
  const GoBackIntent();
}

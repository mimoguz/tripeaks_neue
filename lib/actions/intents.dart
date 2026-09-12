import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/pin.dart';

final class const TakeIntent(final Pin pin) extends Intent {}

final class const DrawIntent() extends Intent;

final class const RollbackIntent() extends Intent;

final class const NewGameIntent() extends Intent;

final class const NewGameWithLayoutIntent() extends Intent;

final class const RestartIntent() extends Intent;

final class const ExitIntent() extends Intent;

final class const NavigateToHomeIntent({final bool replace = false}) extends Intent {}

final class const NavigateToStatisticsIntent({final bool replace = false}) extends Intent {}

final class const NavigateToSettingsIntent({final bool replace = false}) extends Intent {}

final class const NavigateToInfoIntent({final bool replace = false}) extends Intent {}

final class const SetThemeModeIntent(final ThemeMode mode) extends Intent {}

final class const SetShowAllIntent(final bool value) extends Intent {}

final class const SetStartEmptyIntent(final bool value) extends Intent {}

final class const SetSoundModeIntent(final bool value) extends Intent {}

final class const SetDecorIntent(final Decor value) extends Intent {}

final class const SetDecorColourIntent(final DecorColour value) extends Intent {}

final class const SetLayoutIntent(final Peaks value) extends Intent {}

final class const ShowNavigationDrawerIntent() extends Intent;

final class const GoBackIntent({final bool saveSettings = false}) extends Intent {}

final class const ImportStatsIntent() extends Intent;

final class const ExportStatsIntent() extends Intent;

final class const ClearStatsIntent() extends Intent;

import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/util/platform_utils.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colours => Theme.of(this).colorScheme;
  TextTheme get styles => Theme.of(this).textTheme;
  AppLocalizations get strings => AppLocalizations.of(this)!;
}

extension ColorSchemeExt on ColorScheme {
  Color get pageBackground => surface;
  Color get barrier => isDesktop ? Colors.transparent : _barrier;
  Color get dialogBackground => brightness == .dark ? surfaceContainerHigh : surfaceContainer;
  Color get dialogHeader => surfaceContainerHighest;
  Color get sheetBackground => brightness == .dark ? surfaceContainerHigh : surfaceContainer;
  Color get sheetHeader => surfaceContainerHighest;
  Color get faintButtonBackground => onSurface.withAlpha(25);
  Color get faintButtonForeground => onSurface;
  Color get faintButttonIcon => onSurfaceVariant;
  Color get dialogDivider => outlineVariant;
  Color get panelDivider => surfaceDim;
  Color get panelBackground => brightness == .dark ? surfaceContainerHigh : surfaceContainerLowest;
}

const _barrier = Color(0x70000003);

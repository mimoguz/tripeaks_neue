import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colours => Theme.of(this).colorScheme;
  TextTheme get styles => Theme.of(this).textTheme;
  AppLocalizations get strings => AppLocalizations.of(this)!;
}

extension ColorSchemeExt on ColorScheme {
  Color get pageBackground => surface;
  Color get barrier => surface.withAlpha(130);
  Color get dialogBackground => brightness == .dark ? surfaceContainerHighest : surfaceContainer;
  Color get sheetBackground => brightness == .dark ? surfaceContainerHighest : surfaceContainer;
  Color get faintButtonBackground => onSurface.withAlpha(25);
  Color get faintButtonForeground => onSurface;
  Color get faintButttonIcon => onSurfaceVariant;
  Color get dialogDivider => onSurface.withAlpha(40);
  Color get panelDivider => surfaceDim;
  Color get panelBackground => brightness == .dark ? surfaceContainerHigh : surfaceContainerLowest;
}

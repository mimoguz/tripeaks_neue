import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colours => Theme.of(this).colorScheme;
  TextTheme get styles => Theme.of(this).textTheme;
  AppLocalizations get strings => AppLocalizations.of(this)!;
}

extension ColorSchemeExt on ColorScheme {
  Color get barrier => surfaceContainerLow.withAlpha(130);
  Color get dialogBackground => surfaceContainerHighest;
  Color get sheetBackground => surfaceContainerHighest;
  Color get faintButtonBackground => onSurface.withAlpha(25);
  Color get faintButtonForeground => onSurface;
  Color get faintButttonIcon => onSurfaceVariant;
  Color get dialogDivider => onSurface.withAlpha(40);
  Color get panelDivider => surfaceDim;
}

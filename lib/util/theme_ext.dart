import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colours => Theme.of(this).colorScheme;
  TextTheme get styles => Theme.of(this).textTheme;
  AppLocalizations get strings => AppLocalizations.of(this)!;
}

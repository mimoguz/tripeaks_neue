import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

final class const OnOffIcon({
  super.key,
  required final IconData onIcon,
  required final IconData offIcon,
  required final bool isOn,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedSwitcher(
      duration: Durations.medium1,
      transitionBuilder: ((child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: Tween<double>(begin: 0.4, end: 1.0).animate(animation), child: child),
      )),
      child: Icon(
        isOn ? onIcon : offIcon,
        color: isOn ? theme.colorScheme.primary : theme.unselectedWidgetColor,
        key: ValueKey(isOn),
      ),
    );
  }
}

final class const MyRadioListTile<T>({
  super.key,
  required final T value,
  required final bool isChecked,
  required final Widget label,
  final void Function(T)? onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      titleTextStyle: theme.textTheme.bodyMedium,
      title: label,
      visualDensity: .compact,
      minLeadingWidth: 24,
      horizontalTitleGap: c.DialogMetrics.horizontalPadding,
      contentPadding: c.DialogMetrics.contentPaddingTight,
      onTap: onTap != null ? (() => onTap?.call(value)) : null,
      leading: OnOffIcon(
        onIcon: Icons.radio_button_checked,
        offIcon: Icons.radio_button_off,
        isOn: isChecked,
      ),
    );
  }
}

class const MyCheckBoxListTile({
  super.key,
  required final bool isChecked,
  required final Widget label,
  final VoidCallback? onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      titleTextStyle: theme.textTheme.bodyMedium,
      title: label,
      visualDensity: .compact,
      onTap: onTap,
      minLeadingWidth: 24,
      horizontalTitleGap: c.DialogMetrics.horizontalPadding,
      contentPadding: c.DialogMetrics.contentPaddingTight,
      leading: OnOffIcon(onIcon: Icons.check_box, offIcon: Icons.check_box_outline_blank, isOn: isChecked),
    );
  }
}

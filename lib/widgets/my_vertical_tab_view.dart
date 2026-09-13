import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class const MyVerticalTabView({
  super.key,
  required final List<Widget> tabs,
  required final List<Widget> contents,
  final double width = 150,
}) extends StatefulWidget {
  @override
  State<MyVerticalTabView> createState() => _MyVerticalTabViewState();
}

class _MyVerticalTabViewState extends State<MyVerticalTabView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final backgroundColour = context.colours.surfaceContainerLow;
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                color: backgroundColour,
                width: widget.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: c.utilPageMargin),
                  child: ListView(
                    children: [
                      for (final (index, tab) in widget.tabs.indexed)
                        TabHeader(
                          tab: tab,
                          isSelected: index == _currentIndex,
                          width: widget.width,
                          onTap: () => setState(() => _currentIndex = index),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: backgroundColour,
                  child: AnimatedSwitcher(
                    duration: Durations.medium3,
                    transitionBuilder: (child, animation) => SlideTransition(
                      position: Tween(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
                      child: child,
                    ),
                    child: widget.contents.isEmpty ? SizedBox() : widget.contents[_currentIndex],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class const TabHeader({
  super.key,
  required final Widget tab,
  final double width = 150,
  final double height = 42,
  final bool isSelected = false,
  final VoidCallback? onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: isSelected ? null : onTap,
        child: SizedBox(
          width: width,
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: c.cardPaddingHorizontal, right: c.utilPageMargin),
                child: DefaultTextStyle(
                  textAlign: TextAlign.left,
                  style: isSelected
                      ? theme.textTheme.bodyMedium!
                      : theme.textTheme.bodyMedium!.copyWith(color: theme.hintColor),
                  child: tab,
                ),
              ),
              AnimatedSize(
                duration: Durations.medium3,
                curve: Curves.easeInOut,
                child: Container(
                  width: 3,
                  height: isSelected ? height : 0,
                  decoration: BoxDecoration(borderRadius: _indicatorBorder, color: theme.colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const _indicatorBorder = BorderRadius.only(
    topLeft: Radius.circular(3),
    bottomLeft: Radius.circular(3),
  );
}

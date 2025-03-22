import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class MyVerticalTabView extends StatefulWidget {
  const MyVerticalTabView({super.key, required this.tabs, required this.contents, this.width = 150});

  final List<Widget> tabs;
  final List<Widget> contents;
  final double width;

  @override
  State<MyVerticalTabView> createState() => _MyVerticalTabViewState();
}

class _MyVerticalTabViewState extends State<MyVerticalTabView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
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
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  child: AnimatedSwitcher(
                    duration: Durations.medium3,
                    transitionBuilder:
                        (child, animation) => SlideTransition(
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

class TabHeader extends StatelessWidget {
  const TabHeader({
    super.key,
    required this.tab,
    this.width = 150,
    this.height = 42,
    this.isSelected = false,
    this.onTap,
  });

  final Widget tab;
  final double width;
  final double height;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isSelected ? null : onTap,
      child: Container(
        color: Colors.transparent,
        width: width,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: c.utilPageMargin),
              child: DefaultTextStyle(
                textAlign: TextAlign.left,
                style:
                    isSelected
                        ? Theme.of(context).textTheme.bodyMedium!
                        : Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).hintColor),
                child: tab,
              ),
            ),
            AnimatedSize(
              duration: Durations.medium3,
              curve: Curves.easeInOut,
              child: Container(
                width: 3,
                height: isSelected ? height : 0,
                decoration: BoxDecoration(
                  borderRadius: _indicatorBorder,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _indicatorBorder = BorderRadius.only(
    topLeft: Radius.circular(3),
    bottomLeft: Radius.circular(3),
  );
}

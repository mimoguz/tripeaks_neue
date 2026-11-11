import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/util/format_ext.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constrained.dart';
import 'package:tripeaks_neue/widgets/dividers.dart';
import 'package:tripeaks_neue/widgets/my_card.dart';

class const MyScoreTable({
  super.key,
  required final List<SingleGameStatistics> games,
  final bool showRank = true,
  final bool showLayout = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedItem(
      child: MyCard(
        child: Column(
          spacing: 6,
          children: [
            _Th(key: _headingKey, game: games.last, showRank: showRank),
            for (final (i, game) in games.indexed) ...[
              CardDivider(),
              _Td(key: ValueKey(i), game: game, rank: i + 1, showRank: showRank, showLayout: showLayout),
            ],
          ],
        ),
      ),
    );
  }

  static const _headingKey = ValueKey("th");
}

class const _HeaderIcon({
  super.key,
  required final double width,
  required final String tooltip,
  required final IconData icon,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colours = context.colours;
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: .end,
        children: [
          Transform.translate(
            offset: _offset,
            child: Tooltip(
              message: tooltip,
              child: Icon(icon, size: 24, color: colours.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }

  static const _offset = Offset(1, 0);
}

final class const _ResultIcon(final bool result, final AppLocalizations strings, {super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colourExt = theme.extension<MyColourThemeExt>()!;
    return Tooltip(
      message: result ? strings.gameClearedLabel : strings.gameNotClearedLabel,
      child: Container(
        decoration: BoxDecoration(
          shape: .circle,
          color: result ? Colors.lightGreen.shade500 : theme.colorScheme.onSurfaceVariant,
        ),
        width: 22,
        height: 22,
        padding: _padding,
        child: Icon(
          result ? CustomIcons.check12 : CustomIcons.cross12,
          color: colourExt.cardBackground,
          size: 12,
        ),
      ),
    );
  }

  static const _padding = EdgeInsets.all(5);
}

final class const _Th({super.key, required final SingleGameStatistics game, final bool showRank = true})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = theme.textTheme.titleSmall;
    final s = context.strings;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: _rowHeight),
      child: Row(
        spacing: _cellSpacing,
        children: <Widget>[
          if (showRank)
            SizedBox(
              width: _col1Width,
              child: Text("#", style: style),
            ),
          Expanded(child: Text(s.gameLabel, style: style)),
          _HeaderIcon(key: _starKey, width: _col3Width, tooltip: s.scoreTooltip, icon: CustomIcons.star),
          _HeaderIcon(key: _chainKey, width: _col4Width, tooltip: s.chainTooltip, icon: CustomIcons.chain),
        ],
      ),
    );
  }

  static const _chainKey = ValueKey("chain");
  static const _starKey = ValueKey("star");
}

final class const _Td({
  super.key,
  required final SingleGameStatistics game,
  required final int rank,
  final bool showRank = true,
  final bool showLayout = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textExt = theme.extension<MyTextThemeExt>()!;
    final textStyle = theme.textTheme.bodyMedium;
    final numberStyle = textExt.numericBody;
    final rankStyle = textExt.numericBody;
    final s = context.strings;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: _rowHeight),
      child: Row(
        spacing: _cellSpacing,
        children: <Widget>[
          if (showRank) ...[
            SizedBox(
              width: _col1Width,
              child: Text(rank.toString(), style: rankStyle),
            ),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .center,
              children: [
                if (showLayout)
                  Text(
                    game.layout.label(context.strings),
                    overflow: .fade,
                    softWrap: false,
                    style: textStyle,
                  ),
                Text(game.ended.formatted, overflow: .fade, softWrap: false, style: textStyle),
              ],
            ),
          ),
          _ResultIcon(game.isCleared, s, key: ValueKey(rank)),
          SizedBox(
            width: _col3Width,
            child: Text(game.score.toString(), textAlign: .right, style: numberStyle),
          ),
          SizedBox(
            width: _col4Width,
            child: Text(game.longestChain.toString(), textAlign: .right, style: numberStyle),
          ),
        ],
      ),
    );
  }
}

const _rowHeight = 32.0;
const _col1Width = 24.0;
const _col3Width = 44.0;
const _col4Width = 40.0;
const _cellSpacing = 8.0;

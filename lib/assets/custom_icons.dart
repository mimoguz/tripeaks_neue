import 'package:flutter/widgets.dart';
import 'package:tripeaks_neue/stores/data/card_value.dart';
import 'package:tripeaks_neue/stores/settings.dart';

class CustomIcons {
  const CustomIcons._();

  static const rank2 = IconData(0xe927, fontFamily: _cards);
  static const rank3 = IconData(0xe928, fontFamily: _cards);
  static const rank4 = IconData(0xe929, fontFamily: _cards);
  static const rank5 = IconData(0xe92a, fontFamily: _cards);
  static const rank6 = IconData(0xe92b, fontFamily: _cards);
  static const rank7 = IconData(0xe92c, fontFamily: _cards);
  static const rank8 = IconData(0xe92d, fontFamily: _cards);
  static const rank9 = IconData(0xe92e, fontFamily: _cards);
  static const rank10 = IconData(0xe92f, fontFamily: _cards);
  static const rankA = IconData(0xe930, fontFamily: _cards);
  static const rankJ = IconData(0xe931, fontFamily: _cards);
  static const rankK = IconData(0xe932, fontFamily: _cards);
  static const rankQ = IconData(0xe933, fontFamily: _cards);

  static const club36v1 = IconData(0xe917, fontFamily: _cards);
  static const club36v2 = IconData(0xe918, fontFamily: _cards);
  static const club36v3 = IconData(0xe919, fontFamily: _cards);
  static const club36v4 = IconData(0xe91a, fontFamily: _cards);
  static const diamond36v1 = IconData(0xe91b, fontFamily: _cards);
  static const diamond36v2 = IconData(0xe91c, fontFamily: _cards);
  static const diamond36v3 = IconData(0xe91d, fontFamily: _cards);
  static const diamond36v4 = IconData(0xe91e, fontFamily: _cards);
  static const heart36v1 = IconData(0xe91f, fontFamily: _cards);
  static const heart36v2 = IconData(0xe920, fontFamily: _cards);
  static const heart36v3 = IconData(0xe921, fontFamily: _cards);
  static const heart36v4 = IconData(0xe922, fontFamily: _cards);
  static const spade36v1 = IconData(0xe923, fontFamily: _cards);
  static const spade36v2 = IconData(0xe924, fontFamily: _cards);
  static const spade36v3 = IconData(0xe926, fontFamily: _cards);
  static const spade36v4 = IconData(0xe925, fontFamily: _cards);

  static const heartsSm = IconData(0xe904, fontFamily: _cards);
  static const diamondsSm = IconData(0xe905, fontFamily: _cards);
  static const spadesSm = IconData(0xe906, fontFamily: _cards);
  static const clubsSm = IconData(0xe907, fontFamily: _cards);

  static const backCheckered = IconData(0xe908, fontFamily: _cards);
  static const backDotMatrix = IconData(0xe909, fontFamily: _cards);
  static const backEnnui = IconData(0xe90a, fontFamily: _cards);
  static const backEnnuiAlt = IconData(0xe90b, fontFamily: _cards);
  static const backItsKnot = IconData(0xe90c, fontFamily: _cards);
  static const backNeue = IconData(0xe90d, fontFamily: _cards);
  static const backSolar = IconData(0xe90e, fontFamily: _cards);

  static const algorithm16 = IconData(0xe900, fontFamily: _actions);
  static const chain16 = IconData(0xe917, fontFamily: _actions);
  static const check12 = IconData(0xe90e, fontFamily: _actions);
  static const copy16 = IconData(0xe901, fontFamily: _actions);
  static const cross12 = IconData(0xe90f, fontFamily: _actions);
  static const draw = IconData(0xe90c, fontFamily: _actions);
  static const draw16 = IconData(0xe902, fontFamily: _actions);
  static const empty16 = IconData(0xe903, fontFamily: _actions);
  static const filled16 = IconData(0xe904, fontFamily: _actions);
  static const invisible16 = IconData(0xe905, fontFamily: _actions);
  static const link20 = IconData(0xe916, fontFamily: _actions);
  static const menu = IconData(0xe911, fontFamily: _actions);
  static const menu16 = IconData(0xe906, fontFamily: _actions);
  static const newGame = IconData(0xe912, fontFamily: _actions);
  static const overwrite = IconData(0xe913, fontFamily: _actions);
  static const pickAndPlay = IconData(0xe914, fontFamily: _actions);
  static const random16 = IconData(0xe907, fontFamily: _actions);
  static const star16 = IconData(0xe90d, fontFamily: _actions);
  static const undo = IconData(0xe915, fontFamily: _actions);
  static const undo16 = IconData(0xe908, fontFamily: _actions);
  static const visible16 = IconData(0xe909, fontFamily: _actions);
  static const volumeOff16 = IconData(0xe90a, fontFamily: _actions);
  static const volumeOn16 = IconData(0xe90b, fontFamily: _actions);

  static const _actions = "Actions";
  static const _cards = "Cards";

  static const _hearts = [heart36v1, heart36v2, heart36v3, heart36v4];
  static const _diamonds = [diamond36v1, diamond36v2, diamond36v3, diamond36v4];
  static const _spades = [spade36v1, spade36v2, spade36v3, spade36v4];
  static const _clubs = [club36v1, club36v2, club36v3, club36v4];
  static const _ranks = <Rank, IconData>{
    .ace: rankA,
    .two: rank2,
    .three: rank3,
    .four: rank4,
    .five: rank5,
    .six: rank6,
    .seven: rank7,
    .eight: rank8,
    .nine: rank9,
    .ten: rank10,
    .jack: rankJ,
    .queen: rankQ,
    .king: rankK,
  };

  static IconData suitIcon(Suit suit, SuitIconTheme variant) => switch (suit) {
    Suit.clubs => _clubs[variant.index],
    Suit.diamonds => _diamonds[variant.index],
    Suit.hearts => _hearts[variant.index],
    Suit.spades => _spades[variant.index],
  };

  static IconData rankIcon(Rank rank) => _ranks[rank]!;
}

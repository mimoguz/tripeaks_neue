
import 'package:tripeaks_neue/util/json_object.dart';

enum Rank {
  two._("2"),
  three._("3"),
  four._("4"),
  five._("5"),
  six._("6"),
  seven._("7"),
  eight._("8"),
  nine._("9"),
  ten._("10"),
  jack._("J"),
  queen._("Q"),
  king._("K"),
  ace._("A");

  final String character;

  const Rank._(this.character);

  bool checkAdjacent(Rank other) =>
      (index - other.index).abs() == 1 || this == ace && other == two || this == two && other == ace;

  bool checkAdjacentFromDirection(Rank other, bool plus) =>
      plus
          ? index - other.index == 1 || this == ace && other == two
          : other.index - index == 1 || other == ace && this == two;

  (Rank previous, Rank next) get neighbours => (
    this == two ? ace : values[index - 1],
    values[(index + 1) % 13],
  );
}

enum Suit {
  clubs._(false),
  diamonds._(true),
  hearts._(true),
  spades._(false);

  final bool isRed;

  const Suit._(this.isRed);
}

final class CardValue {
  const CardValue({required this.rank, required this.suit});

  final Rank rank;
  final Suit suit;

  @override
  bool operator ==(Object other) => other is CardValue && rank == other.rank && suit == other.suit;

  @override
  int get hashCode => (suit.index << 16) & rank.index;

  bool checkAdjacent(CardValue other) => rank.checkAdjacent(other.rank);

  bool checkAdjacentFromDirection(CardValue other, bool plus) =>
      rank.checkAdjacentFromDirection(other.rank, plus);

  JsonObject toJsonObject() => {"rank": rank.index, "suit": suit.index};

  factory CardValue.fromJsonObject(JsonObject jsonObject) =>
      CardValue(rank: Rank.values[jsonObject["rank"] as int], suit: Suit.values[jsonObject["suit"] as int]);
}

List<CardValue> getDeck() {
  return Suit.values.expand((suit) {
    return Rank.values.map((rank) => CardValue(rank: rank, suit: suit));
  }).toList();
}

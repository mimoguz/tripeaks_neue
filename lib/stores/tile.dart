import "package:tripeaks_neue/stores/data/card_value.dart";
import "package:tripeaks_neue/stores/data/layout.dart";
import "package:tripeaks_neue/stores/data/pin.dart";
import "package:mobx/mobx.dart";
import "package:tripeaks_neue/util/json_object.dart";

part "tile.g.dart";

class Tile extends _Tile with _$Tile {
  Tile({required super.card, required super.pin});

  JsonObject toJsonObject() => {
    "card": card.toJsonObject(),
    "pin": pin.index,
    "isOpen": _isOpen,
    "isVisible": _isVisible,
  };

  factory Tile.fromJsonObject(JsonObject jsonObject, Layout layout) {
    final card = CardValue.fromJsonObject(jsonObject["card"] as JsonObject);
    final pinIndex = jsonObject.read<int>("pin");
    final pin = pinIndex >= 0 ? layout.pins[pinIndex] : Pin.unpin;
    final tile = Tile(card: card, pin: pin);
    if (!jsonObject.read<bool>("isVisible")) {
      tile.take();
    }
    if (jsonObject.read<bool>("isOpen")) {
      tile.open();
    }
    return tile;
  }
}

abstract class _Tile with Store {
  _Tile({required this.card, required this.pin});

  final CardValue card;
  final Pin pin;

  @observable
  DateTime? lastError;

  @readonly
  bool _isOpen = false;

  @readonly
  bool _isVisible = true;

  @action
  void open() {
    if (!_isOpen) {
      _isOpen = true;
    }
  }

  @action
  void close() {
    if (_isOpen) {
      _isOpen = false;
    }
  }

  @action
  void take() {
    if (_isVisible) {
      _isVisible = false;
    }
  }

  @action
  void put() {
    if (!_isVisible) {
      _isVisible = true;
    }
  }

  /// This is a hack for the delayed board animation
  @action
  void hide() {
    if (_isVisible) {
      _isVisible = false;
    }
  }

  /// This is a hack for the delayed board animation
  @action
  void show() {
    if (!_isVisible) {
      _isVisible = true;
    }
  }

  Tile clone() {
    return Tile(card: card, pin: pin);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tile.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Tile on _Tile, Store {
  late final _$lastErrorAtom = Atom(name: '_Tile.lastError', context: context);

  @override
  DateTime? get lastError {
    _$lastErrorAtom.reportRead();
    return super.lastError;
  }

  @override
  set lastError(DateTime? value) {
    _$lastErrorAtom.reportWrite(value, super.lastError, () {
      super.lastError = value;
    });
  }

  late final _$_isOpenAtom = Atom(name: '_Tile._isOpen', context: context);

  bool get isOpen {
    _$_isOpenAtom.reportRead();
    return super._isOpen;
  }

  @override
  bool get _isOpen => isOpen;

  @override
  set _isOpen(bool value) {
    _$_isOpenAtom.reportWrite(value, super._isOpen, () {
      super._isOpen = value;
    });
  }

  late final _$_isVisibleAtom =
      Atom(name: '_Tile._isVisible', context: context);

  bool get isVisible {
    _$_isVisibleAtom.reportRead();
    return super._isVisible;
  }

  @override
  bool get _isVisible => isVisible;

  @override
  set _isVisible(bool value) {
    _$_isVisibleAtom.reportWrite(value, super._isVisible, () {
      super._isVisible = value;
    });
  }

  late final _$_TileActionController =
      ActionController(name: '_Tile', context: context);

  @override
  void open() {
    final _$actionInfo =
        _$_TileActionController.startAction(name: '_Tile.open');
    try {
      return super.open();
    } finally {
      _$_TileActionController.endAction(_$actionInfo);
    }
  }

  @override
  void close() {
    final _$actionInfo =
        _$_TileActionController.startAction(name: '_Tile.close');
    try {
      return super.close();
    } finally {
      _$_TileActionController.endAction(_$actionInfo);
    }
  }

  @override
  void take() {
    final _$actionInfo =
        _$_TileActionController.startAction(name: '_Tile.take');
    try {
      return super.take();
    } finally {
      _$_TileActionController.endAction(_$actionInfo);
    }
  }

  @override
  void put() {
    final _$actionInfo = _$_TileActionController.startAction(name: '_Tile.put');
    try {
      return super.put();
    } finally {
      _$_TileActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lastError: ${lastError}
    ''';
  }
}

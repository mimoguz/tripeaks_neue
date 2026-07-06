import 'dart:collection';

// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:logger/logger.dart';

sealed class SoundEffects {
  Future<void> load();
  Future<void> dispose();
  // Play a 'take' sound. 1-indexed.
  Future<void> playTake(int n);
  Future<void> playDraw();
  Future<void> playRollback();
  Future<void> playError();
  Future<void> playWin();
  Future<void> playGameOver();
  Future<void> playStart();
}

final class Silent implements SoundEffects {
  @override
  Future<void> load() => Future.value();

  @override
  Future<void> dispose() async {}

  @override
  Future<void> playTake(int n) => Future.value();

  @override
  Future<void> playDraw() => Future.value();

  @override
  Future<void> playRollback() => Future.value();

  @override
  Future<void> playError() => Future.value();

  @override
  Future<void> playWin() => Future.value();

  @override
  Future<void> playGameOver() => Future.value();

  @override
  Future<void> playStart() => Future.value();
}

final class SoundOn implements SoundEffects {
  final HashMap<String, AudioSource> _sources = HashMap();
  late final _logger = Logger();

  @override
  Future<void> dispose() async {
    SoLoud.instance.deinit();
    _sources.clear();
  }

  @override
  Future<void> load() async {
    await dispose();
    await SoLoud.instance.init();
    for (var asset in _assets) {
      try {
        final src = await SoLoud.instance.loadAsset(asset);
        _sources[asset] = src;
      } on FlutterError {
        _logger.log(Level.error, "$asset was not found");
      } on SoLoudTemporaryFolderFailedException catch (e) {
        _logger.log(Level.error, "Couldn't create temp file for $asset:\n ${e.description}");
      } on SoLoudFileLoadFailedException catch (e) {
        _logger.log(Level.error, "Couldn't load $asset:\n ${e.description}");
      }
    }
  }

  @override
  Future<void> playDraw() async {
    play(_sources[_draw]);
  }

  @override
  Future<void> playError() async {
    play(_sources[_error]);
  }

  @override
  Future<void> playGameOver() async {
    play(_sources[_gameOver]);
  }

  @override
  Future<void> playRollback() async {
    play(_sources[_rollback]);
  }

  @override
  Future<void> playStart() async {
    play(_sources[_start]);
  }

  @override
  Future<void> playTake(int n) async {
    final asset = _takes[n % _takes.length];
    play(_sources[asset]);
  }

  @override
  Future<void> playWin() async {
    play(_sources[_win]);
  }

  void play(AudioSource? src) {
    if (src is AudioSource) {
      try {
        SoLoud.instance.play(src);
      } catch (e) {
        _logger.log(Level.error, "Can't play sound effect:\n $e");
      }
    }
  }

  static const String _draw = "sounds/draw.mp3";
  static const String _error = "sounds/error.mp3";
  static const String _gameOver = "sounds/gameover.mp3";
  static const String _rollback = "sounds/undo.mp3";
  static const String _start = "sounds/start.mp3";
  static const String _take1 = "sounds/take1.mp3";
  static const String _take2 = "sounds/take2.mp3";
  static const String _take3 = "sounds/take3.mp3";
  static const String _win = "sounds/win.mp3";
  static const List<String> _assets = [
    _draw,
    _error,
    _gameOver,
    _rollback,
    _start,
    _take1,
    _take2,
    _take3,
    _win,
  ];
  static const List<String> _takes = [_take1, _take2, _take3];
}

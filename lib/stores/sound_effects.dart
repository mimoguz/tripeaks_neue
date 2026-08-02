import 'dart:collection';

import 'package:audioplayers/audioplayers.dart';
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
  Future<void> dispose() => Future.value();

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
  late final AudioCache _cache;
  late final AudioPlayer _player;
  late final _logger = Logger();
  final HashMap<String, AssetSource> _assets = HashMap();
  bool loaded = false;

  @override
  Future<void> load() async {
    if (loaded) {
      return;
    }
    _cache = AudioCache(prefix: "sounds/");
    _player = AudioPlayer()
      ..audioCache = _cache
      ..setReleaseMode(ReleaseMode.stop)
      ..setPlayerMode(PlayerMode.lowLatency);
    await _cache.loadAll(_soundList);

    for (var sound in _soundList) {
      _assets[sound] = AssetSource(sound);
    }

    _prePlay();
    loaded = true;
  }

  @override
  Future<void> dispose() async {
    _player.release();
    _cache.clearAll();
    loaded = false;
  }

  @override
  Future<void> playDraw() async {
    try {
      await _player.stop();
      await _player.play(_assets[_draw]!, volume: 1.0);
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playError() async {
    try {
      await _player.stop();
      await _player.play(_assets[_error]!, volume: 1.0);
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playGameOver() async {
    try {
      await _player.stop();
      await _player.play(_assets[_gameOver]!, volume: 1.0);
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playRollback() async {
    try {
      await _player.stop();
      await _player.play(_assets[_rollback]!, volume: 1.0);
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playStart() async {
    try {
      await _player.stop();
      await _player.play(_assets[_start]!, volume: 1.0);
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playTake(int n) async {
    try {
      await _player.stop();
      final sound = _takes[(n - 1) % _takes.length];
      await _player.play(_assets[sound]!, volume: 1.0);
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playWin() async {
    try {
      await _player.stop();
      await _player.play(_assets[_win]!, volume: 1.0);
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  Future<void> _prePlay() async {
    for (final sound in _soundList) {
      try {
        await _player.play(_assets[sound]!, volume: 0.0);
        await _player.stop();
      } catch (e) {
        _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
      }
    }
  }

  static const String _take1 = "take1.mp3";
  static const String _take2 = "take2.mp3";
  static const String _take3 = "take3.mp3";
  static const String _draw = "draw.mp3";
  static const String _rollback = "undo.mp3";
  static const String _error = "error.mp3";
  static const String _win = "win.mp3";
  static const String _gameOver = "gameover.mp3";
  static const String _start = "start.mp3";
  static const List<String> _soundList = [
    _take1,
    _take2,
    _take3,
    _draw,
    _rollback,
    _error,
    _win,
    _gameOver,
    _start,
  ];
  static const List<String> _takes = [_take1, _take2, _take3];
}

import 'package:audioplayers/audioplayers.dart';
import 'package:logger/logger.dart';

sealed class SoundEffects {
  Future<void> load();
  void dispose();
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
  void dispose() {}

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
  bool loaded = false;

  @override
  Future<void> load() async {
    if (loaded) {
      return;
    }
    _cache = AudioCache(prefix: "sounds/");
    _player = AudioPlayer();
    _player.audioCache = _cache;
    _player.setReleaseMode(ReleaseMode.stop);
    _player.setPlayerMode(PlayerMode.lowLatency);
    await _cache.loadAll(_sounds);
    _prePlay();
  }

  @override
  void dispose() {
    _player.release();
    _cache.clearAll();
  }

  @override
  Future<void> playDraw() async {
    try {
      await _player.stop();
      await _player.play(AssetSource(_draw), volume: 1.0);
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playError() async {
    try {
      await _player.stop();
      await _player.play(AssetSource(_error), volume: 1.0);
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playGameOver() async {
    try {
      await _player.stop();
      await _player.play(AssetSource(_gameOver), volume: 1.0);
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playRollback() async {
    try {
      await _player.stop();
      await _player.play(AssetSource(_rollback), volume: 1.0);
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playStart() async {
    try {
      await _player.stop();
      await _player.play(AssetSource(_start), volume: 1.0);
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playTake(int n) async {
    try {
      await _player.stop();
      await _player.play(AssetSource(_takes[(n - 1) % _takes.length]), volume: 1.0);
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playWin() async {
    try {
      await _player.stop();
      await _player.play(AssetSource(_win), volume: 1.0);
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  Future<void> _prePlay() async {
    for (final sound in _sounds) {
      await _player.play(AssetSource(sound), volume: 0.0);
      await _player.stop();
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
  static const List<String> _sounds = [
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

import 'package:audioplayers/audioplayers.dart';
import 'package:logger/logger.dart';

sealed class SoundEffects {
  Future<void> load();
  void dispose();
  Future<void> playTake();
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
  Future<void> playTake() => Future.value();

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
    await _cache.loadAll(_sounds);
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
      await _player.play(AssetSource(_draw));
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playError() async {
    try {
      await _player.stop();
      await _player.play(AssetSource(_error));
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playGameOver() async {
    try {
      await _player.stop();
      await _player.play(AssetSource(_gameOver));
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playRollback() async {
    try {
      await _player.stop();
      await _player.play(AssetSource(_rollback));
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playStart() async {
    try {
      await _player.stop();
      await _player.play(AssetSource(_start));
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playTake() async {
    try {
      await _player.stop();
      await _player.play(AssetSource(_take));
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  @override
  Future<void> playWin() async {
    try {
      await _player.stop();
      await _player.play(AssetSource(_win));
    } catch (e) {
      _logger.e("Can'y play sound: $e\n${e is Error ? e.stackTrace : null}");
    }
  }

  static const String _take = "608433__plasterbrain__nintendo-coin-pickup.mp3";
  static const String _draw = "608431__plasterbrain__shiny-coin-pickup.mp3";
  static const String _rollback = "50559__broumbroum__sf3-sfx-menu-select-l.mp3";
  static const String _error = "423169__plasterbrain__pc-game-ui-error.mp3";
  static const String _win = "138410__cameronmusic__item-collect-2.mp3";
  static const String _gameOver = "138490__justinvoke__powerdown-2.mp3";
  static const String _start = "656394__nikos34__select-2.mp3";
  static const List<String> _sounds = [_take, _draw, _rollback, _error, _win, _gameOver, _start];
}

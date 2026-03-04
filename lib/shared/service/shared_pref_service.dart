import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/shared/service/local_database_service.dart';

part 'shared_pref_service.g.dart';

@Riverpod(keepAlive: true)
LocalDatabaseService localDatabaseService(Ref ref) {
  final SharedPrefService service = SharedPrefService();
  service.init();

  return service;
}

class SharedPrefService implements LocalDatabaseService {
  final Completer<SharedPreferences> _completer = Completer<SharedPreferences>();

  @override
  void init() {
    _completer.complete(SharedPreferences.getInstance());
  }

  @override
  Future<Object?> read({required String key}) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getStringList(key);
  }

  @override
  Future<void> write({required String key, required Object value}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setStringList(key, value as List<String>);
  }

  Future<SharedPreferences> get _prefs async {
    return await _completer.future;
  }
}

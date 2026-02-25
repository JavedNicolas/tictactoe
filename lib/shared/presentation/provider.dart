import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/shared/service/local_database_service.dart';
import 'package:tictactoe/shared/service/shared_pref_service.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
LocalDatabaseService localDatabaseService(Ref ref) {
  final SharedPrefService service = SharedPrefService();
  service.init();

  return service;
}

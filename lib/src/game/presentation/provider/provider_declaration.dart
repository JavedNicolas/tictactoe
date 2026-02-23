import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/src/game/data/datasource/local_datasource.dart';
import 'package:tictactoe/src/game/data/datasource/shared_prefs_datasource.dart';
import 'package:tictactoe/src/game/data/game_repository_impl.dart';

final localDatasourceProvider = Provider<LocalDatasource>((ref) => SharedPrefsDatasource());
final gameStateRepositoryProvider = Provider(
  (ref) => GameStateRepositoryImpl(datasource: ref.watch(localDatasourceProvider)),
);

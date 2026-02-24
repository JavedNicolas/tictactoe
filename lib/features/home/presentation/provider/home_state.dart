enum HomeStatus { loading, loaded, error }

class HomeState {
  HomeState({
    required this.hasOngoingGame,
    required this.status,
  });

  final bool hasOngoingGame;
  final HomeStatus status;

  bool get isLoading => status == HomeStatus.loading;
  bool get isLoaded => status == HomeStatus.loaded;
  bool get isError => status == HomeStatus.error;
}

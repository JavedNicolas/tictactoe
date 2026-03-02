enum HomeStatus { loading, loaded, error }

class HomeState {
  HomeState({
    required this.hasOngoingGame,
    required this.status,
  });

  factory HomeState.initial() {
    return HomeState(
      hasOngoingGame: false,
      status: HomeStatus.loading,
    );
  }

  final bool hasOngoingGame;
  final HomeStatus status;

  bool get isLoading => status == HomeStatus.loading;
  bool get isLoaded => status == HomeStatus.loaded;
  bool get hasError => status == HomeStatus.error;

  HomeState copyWith({
    bool? hasOngoingGame,
    HomeStatus? status,
  }) {
    return HomeState(
      hasOngoingGame: hasOngoingGame ?? this.hasOngoingGame,
      status: status ?? this.status,
    );
  }
}

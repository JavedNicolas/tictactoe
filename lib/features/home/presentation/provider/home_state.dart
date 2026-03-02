enum HomeStatus { loading, loaded, error }

class HomeState {
  HomeState({
    required this.hasOngoingGame,
    required this.status,
    this.errorMessage,
  });

  factory HomeState.initial() {
    return HomeState(
      hasOngoingGame: false,
      status: HomeStatus.loading,
    );
  }

  final bool hasOngoingGame;
  final HomeStatus status;
  final String? errorMessage;

  bool get isLoading => status == HomeStatus.loading;
  bool get isLoaded => status == HomeStatus.loaded;
  bool get isError => status == HomeStatus.error;

  HomeState copyWith({
    bool? hasOngoingGame,
    HomeStatus? status,
    String? errorMessage,
  }) {
    return HomeState(
      hasOngoingGame: hasOngoingGame ?? this.hasOngoingGame,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

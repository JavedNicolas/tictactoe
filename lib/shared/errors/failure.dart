class Failure extends Error {
  Failure({required this.message});

  final String message;
}

class DatabaseQueryFailure extends Failure {
  DatabaseQueryFailure({required super.message});
}

class DataNotFoundFailure extends Failure {
  DataNotFoundFailure({required super.message});
}

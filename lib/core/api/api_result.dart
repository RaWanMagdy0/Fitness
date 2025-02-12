sealed class Result<T> {}

class Success<T> implements Result<T> {
  final T? data;
  Success({this.data});
}

class Fail<T> implements Result<T> {
  final Exception? exception;
  Fail({this.exception});
}

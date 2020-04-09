class NetworkResult<T> {
  NetworkResult._();

  factory NetworkResult.success(T value) = Success<T>;

  factory NetworkResult.error(Exception exception) = Failure<T>;

  NetworkResult<T> doOnSuccess(Function onSuccess) {
    if (this is Success) {
      onSuccess.call((this as Success).value);
    }
    return this;
  }

  dynamic doNextOnSuccess(Function onSuccess) {
    if (this is Success) {
      return onSuccess.call((this as Success).value);
    }
    return this;
  }

  NetworkResult<T> doOnFailure(Function onFailure) {
    if (this is Failure) {
      onFailure.call((this as Failure).exception);
    }
    return this;
  }
}

class Failure<T> extends NetworkResult<T> {
  Failure(this.exception) : super._();
  final Exception exception;
}

class Success<T> extends NetworkResult<T> {
  Success(this.value) : super._();
  final T value;
}

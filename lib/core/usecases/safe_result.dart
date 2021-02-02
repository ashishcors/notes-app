abstract class SafeResult<T> {
  const SafeResult();

  B fold<B>(onSuccess(T value), onFailure(Exception exception));
}

class Success<T> extends SafeResult<T> {
  final T value;

  Success(this.value);

  @override
  B fold<B>(onSuccess(T value), onFailure(Exception exception)) =>
      onSuccess(value);
}

class Failure<T> extends SafeResult<T> {
  final Exception exception;

  Failure(this.exception);

  @override
  B fold<B>(onSuccess(T value), onFailure(Exception exception)) =>
      onFailure(exception);
}

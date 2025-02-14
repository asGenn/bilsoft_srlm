abstract class Result<T> {
  final T? data;
  final String? error;

  const Result({this.data, this.error});

  factory Result.success(T data) => Success(data);
  factory Result.failure(String error) => Failure(error);

  bool get isSuccess => this is Success;
  bool get isError => this is Failure;

  void fold ({required Function(T data) onSuccess, required Function(String error) onFailure}) {
    if (isSuccess) {
      onSuccess((this as Success).data);
    } else {
      onFailure(error!);
    }
  }

}

class Success<T> extends Result<T> {
  const Success(T data) : super(data: data);
}

class Failure<T> extends Result<T> {
  const Failure(String error) : super(error: error);
}

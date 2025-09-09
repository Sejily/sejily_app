import '../newtorking/api_error.dart';

class Result<T> {
  final T? data;
  final ApiError? error;
  Result({this.data, this.error});
}

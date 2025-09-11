import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sejily/core/newtorking/api_error_model.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.failure(ApiErrorModel exception) = Failure;
  const factory AuthState.success() = Success;
}

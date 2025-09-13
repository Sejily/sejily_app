import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/newtorking/api_result.dart';
import '../../../../../../core/newtorking/api_error_model.dart';
import '../../../data/models/user_model.dart';
import '../../../../../authentication/data/repository/auth_repository.dart';

final userProfileProvider = FutureProvider<ApiResult<UserModel>>((ref) async {
  final repo = ref.watch(authRepositoryProvider);

  final result = await repo.getProfile();
  if (result is ApiSuccess<UserModel> && result.data != null) {
    return ApiSuccess(result.data);
  } else {
    return ApiFailure(ApiErrorModel(message: "لم يتم تحميل بيانات المستخدم"));
  }
});

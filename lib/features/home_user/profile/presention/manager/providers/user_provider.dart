import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/newtorking/api_error_handler.dart';
import '../../../../../../core/newtorking/api_error_model.dart';
import '../../../../../../core/newtorking/api_result.dart';
import '../../../../../authentication/data/repository/auth_repository.dart';
import '../../../data/models/user_model.dart';

final userProfileProvider = FutureProvider<ApiResult<UserModel>>((ref) async {
  final repo = ref.watch(authRepositoryProvider);

  try {
    final result = await repo.getProfile();

    if (result is ApiSuccess<UserModel> && result.data != null) {
      return ApiSuccess(result.data);
    } else {
      return ApiFailure(ApiErrorModel(message: "لم يتم تحميل بيانات المستخدم"));
    }
  } catch (e) {
    return ApiFailure(ApiErrorHandler.handle(e));
  }
});

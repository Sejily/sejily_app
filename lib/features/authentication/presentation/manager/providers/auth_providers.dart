import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sejily/core/newtorking/api_result.dart';
import 'package:sejily/features/authentication/data/models/login_response.dart';
import 'package:sejily/features/authentication/data/repository/auth_repository.dart';

final loginProvider = FutureProvider.family
    .autoDispose<ApiResult<LoginResponse>, Map<String, String>>((
      ref,
      credentials,
    ) async {
      final repo = ref.read(authRepositoryProvider);
      return await repo.login(credentials["email"]!, credentials["password"]!);
    });

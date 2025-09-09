import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:sejily/core/result/result.dart';
import '../../../../../core/newtorking/dio_factory.dart';
import '../../../../../core/repository/auth_repository.dart';
import '../../../data/auth_api.dart';

final dioProvider = Provider<Dio>((ref) => DioFactory.getDio());
final authApiProvider = Provider<AuthApi>(
  (ref) => AuthApi(ref.read(dioProvider)),
);
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.read(authApiProvider)),
);

final loginProvider = FutureProvider.family
    .autoDispose<Result<Map<String, dynamic>>, Map<String, String>>((
      ref,
      credentials,
    ) async {
      final repo = ref.read(authRepositoryProvider);
      return await repo.login(credentials["email"]!, credentials["password"]!);
    });

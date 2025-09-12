import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sejily/core/newtorking/api_error_model.dart';

final fileUploadProvider =
    StateNotifierProvider<FileUploadNotifier, List<PlatformFile>>((ref) {
      return FileUploadNotifier();
    });

class FileUploadNotifier extends StateNotifier<List<PlatformFile>> {
  FileUploadNotifier() : super([]);

  final int _maxSizeBytes = 25 * 1024 * 1024;

  Future<ApiErrorModel?> addFiles(List<PlatformFile> newFiles) async {
    final totalSize =
        state.fold<int>(0, (prev, file) => prev + file.size) +
        newFiles.fold<int>(0, (prev, file) => prev + file.size);

    if (totalSize > _maxSizeBytes) {
      return ApiErrorModel(message: "الملفات يجب ألا تتعدى 25 ميجا");
    }

    state = [...state, ...newFiles];
    return null;
  }

  void removeFile(PlatformFile file) {
    state = state.where((f) => f.identifier != file.identifier).toList();
  }

  void clear() => state = [];
}

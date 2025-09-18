import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:sejily/features/ai/presentation/manager/ai_notifier.dart';
import 'package:sejily/features/ai/data/models/ai_upload_response.dart';

// Uploaded file model that includes fileId
class UploadedFile {
  final PlatformFile platformFile;
  final String fileId;

  UploadedFile({required this.platformFile, required this.fileId});
}

// File upload state class
class FileUploadState {
  final List<UploadedFile> files;
  final bool isUploading;
  final String? errorMessage;
  final String? currentUploadingFile;
  final double uploadProgress;

  const FileUploadState({
    this.files = const [],
    this.isUploading = false,
    this.errorMessage,
    this.currentUploadingFile,
    this.uploadProgress = 0.0,
  });

  FileUploadState copyWith({
    List<UploadedFile>? files,
    bool? isUploading,
    String? errorMessage,
    String? currentUploadingFile,
    double? uploadProgress,
  }) {
    return FileUploadState(
      files: files ?? this.files,
      isUploading: isUploading ?? this.isUploading,
      errorMessage: errorMessage,
      currentUploadingFile: currentUploadingFile,
      uploadProgress: uploadProgress ?? this.uploadProgress,
    );
  }
}

final fileUploadProvider =
    StateNotifierProvider<FileUploadNotifier, FileUploadState>((ref) {
      return FileUploadNotifier();
    });

class FileUploadNotifier extends StateNotifier<FileUploadState> {
  FileUploadNotifier() : super(const FileUploadState());

  final int _maxSizeBytes = 25 * 1024 * 1024;

  Future<void> addFile(PlatformFile newFile, WidgetRef ref) async {
    final totalSize =
        state.files.fold<int>(
          0,
          (prev, file) => prev + file.platformFile.size,
        ) +
        newFile.size;

    if (totalSize > _maxSizeBytes) {
      state = state.copyWith(errorMessage: "الملفات يجب ألا تتعدى 25 ميجا");
      return;
    }

    if (newFile.path == null) {
      state = state.copyWith(errorMessage: "مسار الملف غير صحيح");
      return;
    }

    // Start uploading with progress simulation
    state = state.copyWith(
      isUploading: true,
      currentUploadingFile: newFile.name,
      errorMessage: null,
      uploadProgress: 0.0,
    );

    try {
      final file = File(newFile.path!);
      final aiNotifier = ref.read(aiNotifierProvider.notifier);

      // Simulate upload progress while the actual upload happens
      _simulateUploadProgress();

      await aiNotifier.uploadFile(file);

      // Complete progress to 100%
      state = state.copyWith(uploadProgress: 1.0);

      // Small delay to show 100% completion
      await Future.delayed(const Duration(milliseconds: 300));

      // Get the upload response from AI notifier
      final uploadState = ref.read(aiNotifierProvider);

      if (uploadState.hasValue) {
        final uploadResponse = uploadState.value;
        if (uploadResponse is AIUploadResponse) {
          // Success - add file with fileId and stop loading
          final uploadedFile = UploadedFile(
            platformFile: newFile,
            fileId: uploadResponse.fileId,
          );

          state = state.copyWith(
            files: [...state.files, uploadedFile],
            isUploading: false,
            currentUploadingFile: null,
            uploadProgress: 0.0,
          );
        } else {
          state = state.copyWith(
            isUploading: false,
            currentUploadingFile: null,
            uploadProgress: 0.0,
            errorMessage: "فشل في رفع الملف: استجابة غير متوقعة",
          );
        }
      } else {
        state = state.copyWith(
          isUploading: false,
          currentUploadingFile: null,
          uploadProgress: 0.0,
          errorMessage: "فشل في رفع الملف: لا توجد استجابة",
        );
      }
    } catch (e) {
      // Error - stop loading and show error
      state = state.copyWith(
        isUploading: false,
        currentUploadingFile: null,
        uploadProgress: 0.0,
        errorMessage: "فشل في رفع الملف: ${e.toString()}",
      );
    }
  }

  // Simulate upload progress with incremental updates
  void _simulateUploadProgress() async {
    const steps = 20; // Number of progress steps
    const stepDelay = Duration(milliseconds: 100); // Delay between steps

    for (int i = 1; i <= steps; i++) {
      if (!state.isUploading) break; // Stop if upload is cancelled/completed

      await Future.delayed(stepDelay);

      // Update progress incrementally (0.0 to 0.95, leaving final 5% for actual completion)
      final progress = (i / steps) * 0.95;
      state = state.copyWith(uploadProgress: progress);
    }
  }

  void removeFile(PlatformFile file) {
    state = state.copyWith(
      files: state.files
          .where((f) => f.platformFile.identifier != file.identifier)
          .toList(),
    );
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  void clear() {
    state = const FileUploadState();
  }
}

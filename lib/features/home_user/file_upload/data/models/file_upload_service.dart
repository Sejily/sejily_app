import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/manager/providers/file_upload_provider.dart';

class FileUploadService {
  static Future<String?> pickFiles(
    BuildContext context,
    WidgetRef ref,
    String type,
  ) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png', 'doc', 'docx'],
    );

    if (result != null && result.files.isNotEmpty) {
      final error = await ref
          .read(fileUploadProvider.notifier)
          .addFiles(result.files);
      if (error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error as String)));
      }
    }
    return null;
  }
}

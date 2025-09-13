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
      for (final file in result.files) {
        await ref.read(fileUploadProvider.notifier).addFile(file, ref);
      }
    }
    return null;
  }
}

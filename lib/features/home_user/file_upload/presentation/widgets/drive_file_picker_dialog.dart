import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:sejily/core/utils/app_colors.dart';
import '../../data/models/google_drive_service.dart';

class DriveFilePickerDialog extends StatefulWidget {
  final WidgetRef ref;
  const DriveFilePickerDialog({super.key, required this.ref});

  @override
  State<DriveFilePickerDialog> createState() => _DriveFilePickerDialogState();
}

class _DriveFilePickerDialogState extends State<DriveFilePickerDialog> {
  final GoogleDriveService _service = GoogleDriveService();
  bool _loading = true;
  List<drive.File> _files = [];
  final Set<String> _selectedIds = {};

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    final success = await _service.signIn();
    if (!success) {
      setState(() => _loading = false);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل تسجيل الدخول في Google Drive')),
        );
      }
      return;
    }

    final files = await _service.listFiles();
    setState(() {
      _files = files;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 500),
        width: double.maxFinite,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'اختر ملفات من Google Drive',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            if (_loading) const Center(child: CircularProgressIndicator()),
            if (!_loading && _files.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('لا توجد ملفات للعرض'),
              ),
            if (!_loading && _files.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _files.length,
                  itemBuilder: (context, idx) {
                    final f = _files[idx];
                    final selected =
                        f.id != null && _selectedIds.contains(f.id);
                    final sizeText = f.size == null
                        ? ''
                        : ' - ${(int.parse(f.size!) / 1024).toStringAsFixed(2)} KB';
                    return CheckboxListTile(
                      value: selected,
                      title: Text(f.name ?? 'بدون اسم'),
                      subtitle: Text('${f.mimeType ?? ''}$sizeText'),
                      onChanged: (v) {
                        setState(() {
                          if (f.id == null) return;
                          if (v == true) {
                            _selectedIds.add(f.id!);
                          } else {
                            _selectedIds.remove(f.id!);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('إلغاء'),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _selectedIds.isEmpty
                      ? null
                      : () {
                          Navigator.of(context).pop();
                          final selectedFiles = _files
                              .where(
                                (f) =>
                                    f.id != null && _selectedIds.contains(f.id),
                              )
                              .toList();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'تم اختيار ${selectedFiles.length} ملف',
                              ),
                            ),
                          );
                        },
                  child: const Text('إضافة الملفات'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

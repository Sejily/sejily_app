extension StringExtensions on String? {
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

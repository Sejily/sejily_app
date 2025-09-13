import 'package:sejily/features/ai/data/models/ai_fhir_search_response.dart';

/// Helper class for translating medical dosage instructions from English to Arabic
class MedicalTranslationHelper {
  static String translateDosageText(String text) {
    if (_isArabicText(text)) {
      return text;
    }
    String translated = text.toLowerCase();

    if (translated.contains('instill 3 drops into each eye 3 times daily')) {
      return 'ضع 3 قطرات في كل عين 3 مرات يومياً';
    }
    if (translated.contains('take 1 tablet 2 times daily after food')) {
      return 'تناول حبة واحدة مرتين يومياً بعد الطعام';
    }
    if (translated.contains('apply ointment once nightly')) {
      return 'ضع المرهم مرة واحدة ليلاً';
    }
    String result = '';

    // Extract and translate action
    result += _translateAction(translated);

    // Extract and translate quantity/medication type
    result += _translateQuantityAndType(translated);

    // Extract and translate route/location
    result += _translateRoute(translated);

    // Extract and translate frequency
    result += _translateFrequency(translated);

    // Extract and translate timing
    result += _translateTiming(translated);

    // If we couldn't translate or result is empty, return a default Arabic message
    return result.trim().isNotEmpty
        ? result.trim()
        : 'تعليمات الجرعة غير واضحة';
  }

  /// Translate gender from English to Arabic
  static String translateGender(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return 'ذكر';
      case 'female':
        return 'أنثى';
      case 'unknown':
        return 'غير محدد';
      default:
        return gender;
    }
  }

  /// Check if text contains Arabic characters
  static bool _isArabicText(String text) {
    return text.contains(RegExp(r'[\u0600-\u06FF]'));
  }

  /// Helper function to translate action verbs
  static String _translateAction(String text) {
    if (text.contains('instill') || text.contains('apply')) {
      return 'ضع ';
    } else if (text.contains('take')) {
      return 'تناول ';
    } else if (text.contains('use')) {
      return 'استخدم ';
    } else if (text.contains('inject')) {
      return 'احقن ';
    }
    return '';
  }

  /// Helper function to translate quantity and medication type
  static String _translateQuantityAndType(String text) {
    final quantityTypes = <String, String>{
      '1 drop': 'قطرة واحدة',
      '2 drops': 'قطرتان',
      '3 drops': '3 قطرات',
      '4 drops': '4 قطرات',
      '5 drops': '5 قطرات',
      '1 tablet': 'حبة واحدة',
      '2 tablets': 'حبتان',
      '3 tablets': '3 حبات',
      '1 capsule': 'كبسولة واحدة',
      '2 capsules': 'كبسولتان',
      '1 pill': 'حبة واحدة',
      'ointment': 'المرهم',
      'cream': 'الكريم',
      'gel': 'الجل',
      '1 ml': '1 مل',
      '2 ml': '2 مل',
      '5 ml': '5 مل',
    };

    for (final entry in quantityTypes.entries) {
      if (text.contains(entry.key)) {
        return '${entry.value} ';
      }
    }
    return '';
  }

  /// Helper function to translate route to Arabic
  static String _translateRoute(String text) {
    final routes = <String, String>{
      'oral': 'عن طريق الفم',
      'ophthalmic': 'في العين',
      'eye drop': 'في العين',
      'eye ointment': 'في العين',
      'topical': 'موضعياً',
      'into each eye': 'في كل عين',
      'in each eye': 'في كل عين',
      'on the skin': 'على الجلد',
      'under the tongue': 'تحت اللسان',
      'nasal': 'في الأنف',
      'rectal': 'شرجياً',
      'intravenous': 'وريدياً',
      'intramuscular': 'عضلياً',
    };

    for (final entry in routes.entries) {
      if (text.contains(entry.key)) {
        return '${entry.value} ';
      }
    }
    return '';
  }

  /// Helper function to translate frequency to Arabic
  static String _translateFrequency(String text) {
    final frequencies = <String, String>{
      'once daily': 'مرة واحدة يومياً',
      'twice daily': 'مرتين يومياً',
      '2 times daily': 'مرتين يومياً',
      '3 times daily': '3 مرات يومياً',
      '4 times daily': '4 مرات يومياً',
      'once nightly': 'مرة واحدة ليلاً',
      'twice weekly': 'مرتين أسبوعياً',
      'once weekly': 'مرة واحدة أسبوعياً',
      'every 6 hours': 'كل 6 ساعات',
      'every 8 hours': 'كل 8 ساعات',
      'every 12 hours': 'كل 12 ساعة',
      'every 4 hours': 'كل 4 ساعات',
      'as needed': 'عند الحاجة',
    };

    for (final entry in frequencies.entries) {
      if (text.contains(entry.key)) {
        return '${entry.value} ';
      }
    }
    return '';
  }

  /// Helper function to translate timing to Arabic
  static String _translateTiming(String text) {
    final timings = <String, String>{
      'after food': 'بعد الطعام',
      'before food': 'قبل الطعام',
      'with food': 'مع الطعام',
      'on empty stomach': 'على معدة فارغة',
      'in the morning': 'في الصباح',
      'in the evening': 'في المساء',
      'at bedtime': 'عند النوم',
      'before sleep': 'قبل النوم',
      'after meals': 'بعد الوجبات',
      'before meals': 'قبل الوجبات',
      'with meals': 'مع الوجبات',
    };

    String result = '';
    for (final entry in timings.entries) {
      if (text.contains(entry.key)) {
        result += '${entry.value} ';
      }
    }
    return result;
  }

  /// Format FHIR timing structure to Arabic text
  static String? formatTiming(FhirTiming timing) {
    if (timing.repeat == null) return null;

    final repeat = timing.repeat!;
    final buffer = StringBuffer();

    if (repeat.frequency != null && repeat.frequency! > 0) {
      buffer.write('${repeat.frequency} ');
      if (repeat.frequency == 1) {
        buffer.write('مرة ');
      } else if (repeat.frequency == 2) {
        buffer.write('مرتان ');
      } else {
        buffer.write('مرات ');
      }
    }

    if (repeat.period != null &&
        repeat.period! > 0 &&
        repeat.periodUnit != null) {
      buffer.write('كل ${repeat.period} ');
      switch (repeat.periodUnit!.toLowerCase()) {
        case 'd':
        case 'day':
          buffer.write(repeat.period == 1 ? 'يوم' : 'أيام');
          break;
        case 'h':
        case 'hour':
          buffer.write(repeat.period == 1 ? 'ساعة' : 'ساعات');
          break;
        case 'wk':
        case 'week':
          buffer.write(repeat.period == 1 ? 'أسبوع' : 'أسابيع');
          break;
        default:
          buffer.write(repeat.periodUnit);
      }
    }

    return buffer.toString().trim().isNotEmpty
        ? buffer.toString().trim()
        : null;
  }
}

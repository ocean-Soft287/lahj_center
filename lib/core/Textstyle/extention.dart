enum AdCondition { newAd, used }

extension AdConditionExtension on AdCondition {
  String get arabicName {
    switch (this) {
      case AdCondition.newAd:
        return 'جديد';
      case AdCondition.used:
        return 'مستخدم';
    }
  }

 
  String get apiValue {
    switch (this) {
      case AdCondition.newAd:
        return 'New';
      case AdCondition.used:
        return 'Used';
    }
  }
}

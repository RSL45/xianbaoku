import 'package:flutter/material.dart';
import 'package:xianbaoku/utils/storage_util.dart';

class LocaleProvider extends ChangeNotifier {
  String? _locale;

  Locale? get locale {
    _locale = (StorageUtil.get('locale') as String?) ?? "system";
    switch (_locale) {
      case 'zh':
        return const Locale('zh');
      case 'en':
        return const Locale('en');
      default: // 选择系统设置语言
        return null;
    }
  }

  // 用户改变APP语言后，通知依赖项更新，新语言会立即生效
  ChangeLanguage(String? locale) async {
    if (locale != _locale) {
      _locale = locale;
      await StorageUtil.set('locale', locale);
      notifyListeners();
    }
  }
}

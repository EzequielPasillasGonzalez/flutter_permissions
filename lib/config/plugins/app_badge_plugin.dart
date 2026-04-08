import 'package:app_badge_plus/app_badge_plus.dart';

class AppBadgePlugin {
  static Future<bool> get isBadgeSupported {
    return AppBadgePlus.isSupported();
  }

  static void updateBadge(int count) async {
    if (!await isBadgeSupported) return;
    AppBadgePlus.updateBadge(count);
    return;
  }

  static void removeBadge() async {
    if (!await isBadgeSupported) return;
    AppBadgePlus.updateBadge(0);
    return;
  }
}

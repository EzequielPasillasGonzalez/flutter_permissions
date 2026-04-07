import 'package:share_plus/share_plus.dart';

class SharePlugin {
  static void shareLink({
    required String title,
    required String link,
    String? subject,
  }) {
    SharePlus.instance.share(
      ShareParams(title: title, text: link, subject: subject),
    );
  }
}

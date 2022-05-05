import '../exports/core.dart';

class UtilitiesServices {
  static const contactNumber = '+996548766248';
  static const contactEmail = 'app.freej@gmail.com';

  static String encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }

  static Future<void> contactFreej(context, {bool whatsapp = false}) async {
    ProgressDialog pr = ProgressDialog(context);
    if (!whatsapp) {
      Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: contactEmail,
        query: encodeQueryParameters(<String, String>{'subject': 'freej Support'}),
      );
      return Nav.openUrl(context, url: emailLaunchUri.toString(), errorMsg: "support-error".translate);
    } else {
      String whatsappUrl = Uri.parse("https://wa.me/$contactNumber").toString();
      Nav.openUrl(context, url: whatsappUrl, errorMsg: "error-no-whatsapp".translate);
    }
  }
}

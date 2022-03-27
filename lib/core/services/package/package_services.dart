import 'dart:developer';
import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:freej/core/localization/constants.dart';

import '../../../app/auth/services/auth_services.dart';
import '../../components/alert_dialog_box.dart';
import '../../models/system_config.dart';
import '../../util/navigators.dart';
import '../api/request_manager.dart';

enum AppVersionStatus { updated, canUpdate, mustUpdate }

class PackageService {
  static final configsUrl = '${RequestManger.baseUrl}/utilities/configs/';
  static const iosAppURL = 'https://apps.apple.com/us/app/yumealz/id1611997387';
  static const androidAppURL = 'https://play.google.com/store/apps/details?id=com.yumealz';

  static Future<List<dynamic>> getApplicationVersion() async {
    String url;
    Map<String, String> params = {'tag': 'mobile_app_version'};
    String query = params.entries.map((p) => '${p.key}=${p.value}').join('&');
    url = configsUrl + "?" + query;
    List<SystemConfig> configs = (await RequestManger.fetchList(
      url: url,
      method: Method.GET,
      needsAuth: false,
    ))
        .map((e) => SystemConfig.fromMap(e))
        .toList();
    return configs;
  }

  static Future<AppVersionStatus> needsUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    List<dynamic> apiVersion = await getApplicationVersion();
    int version = int.tryParse(packageInfo.version.replaceAll('.', '')) ?? 0;
    log("Current Version: $version");
    int minimalVersion = int.tryParse(
            apiVersion.firstWhere((element) => element.key == 'MINIMAL_APP_VERSION').value.replaceAll('.', '')) ??
        0;
    log("Minimal Version: $minimalVersion");
    int latestVersion = int.tryParse(
            apiVersion.firstWhere((element) => element.key == 'LATEST_APP_VERSION').value.replaceAll('.', '')) ??
        0;
    log("latest Version: $latestVersion");
    return compareVersions(version, minimalVersion, latestVersion);
  }

  static AppVersionStatus compareVersions(appVersion, minimalVersion, latestVersion) {
    if (appVersion < minimalVersion) {
      return AppVersionStatus.mustUpdate;
    } else if (appVersion < latestVersion) {
      return AppVersionStatus.canUpdate;
    } else {
      return AppVersionStatus.updated;
    }
  }

  static Future<bool> updateAction(context, versionStatus, userAction) async {
    if (versionStatus == AppVersionStatus.mustUpdate) {
      AuthServices.logout(context);
      if (Platform.isIOS) {
        Nav.openUrl(context, url: iosAppURL);
      } else if (Platform.isAndroid) {
        Nav.openUrl(context, url: androidAppURL);
      } else {
        Nav.openUrl(context, url: 'https://yumealz.com');
      }
    } else if (userAction == true && versionStatus == AppVersionStatus.canUpdate) {
      if (Platform.isIOS) {
        Nav.openUrl(context, url: iosAppURL);
      } else if (Platform.isAndroid) {
        Nav.openUrl(context, url: androidAppURL);
      } else {
        Nav.openUrl(context, url: 'https://yumealz.com');
      }
    }
    return true;
  }

  static void checkUpdates(context) async {
    try {
      AppVersionStatus versionStatus = await PackageService.needsUpdate();
      if (versionStatus != AppVersionStatus.updated) {
        bool result = await AlertDialogBox.showCustomAlert(
              context,
              message: versionStatus.toString().translate,
              isDismissible: versionStatus != AppVersionStatus.mustUpdate,
              continueButton: "update_now".translate,
              onContinueButton: () async => await PackageService.updateAction(context, versionStatus, true),
              cancelButton: "later".translate,
            ) ??
            false;
      }
    } catch (e) {
      log("Couldn't validate app version");
    }
  }
}

import 'package:freej/core/services/api/request_manager.dart';

import '../../models/system_config.dart';

class ConfigsService {
  static final _configsUrl = '${RequestManger.baseUrl}/utilities/configs/?tag=mobile_app_configs';

  static Future<List<SystemConfig>> getConfigs() async {
    return (await RequestManger.fetchList(url: _configsUrl, method: Method.GET, needsAuth: false))
        .map((e) => SystemConfig.fromMap(e))
        .toList();
  }
}

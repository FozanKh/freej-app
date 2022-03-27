import '../models/system_config.dart';
import '../services/api/configs_services.dart';

class ConfigsRepository {
  ConfigsRepository._();
  static ConfigsRepository? _instance;
  static ConfigsRepository get instance => _instance ??= ConfigsRepository._();
  List<SystemConfig> _configs = [];

  Future<void> init() async {
    await getConfigs();
  }

  Future<List<SystemConfig>> getConfigs({bool refresh = false}) async {
    if (_configs.isEmpty || refresh) {
      return _configs = await ConfigsService.getConfigs();
    } else {
      return _configs;
    }
  }

  void clear() {
    _configs.clear();
  }
}

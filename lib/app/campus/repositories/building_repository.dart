import '../../building/services/building_services.dart';
import '../models/building.dart';

class BuildingRepository {
  BuildingRepository._();
  static BuildingRepository? _instance;
  static BuildingRepository get instance => _instance ??= BuildingRepository._();
  List<Building> _buildings = [];

  Future<void> init() async {
    await getAllBuildings();
  }

  Future<List<Building>> getAllBuildings({bool refresh = false}) async {
    if (_buildings.isEmpty || refresh) {
      return _buildings = await BuildingServices.getAllBuildings();
    } else {
      return _buildings;
    }
  }
}

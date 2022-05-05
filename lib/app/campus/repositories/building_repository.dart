import '../../building/services/building_services.dart';
import '../models/building.dart';
import '../models/campus.dart';

class BuildingRepository {
  BuildingRepository._();
  static BuildingRepository? _instance;
  static BuildingRepository get instance => _instance ??= BuildingRepository._();
  List<Building> _buildings = [];
  List<Campus> _campuses = [];
  Map<int, List<Building>> _campusBuildings = {};

  Future<void> init() async {
    await getAllBuildings();
  }

  Future<List<Campus>> getAllCampuses({bool refresh = false}) async {
    if (_campuses.isEmpty || refresh) {
      return _campuses = await BuildingServices.getAllCampuses();
    } else {
      return _campuses;
    }
  }

  Future<List<Building>> getCampusBuildings(int campusId, {bool refresh = false}) async {
    if (_campusBuildings[campusId] == null || refresh) {
      return _campusBuildings[campusId] = await BuildingServices.getAllBuildings(campusId: campusId);
    } else {
      return _campusBuildings[campusId] ?? [];
    }
  }

  Future<List<Building>> getAllBuildings({bool refresh = false}) async {
    if (_buildings.isEmpty || refresh) {
      return _buildings = await BuildingServices.getAllBuildings();
    } else {
      return _buildings;
    }
  }
}

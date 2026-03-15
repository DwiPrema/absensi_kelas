import "package:absensi_kelas/features/school_classes/models/school_class_model.dart";
import "package:absensi_kelas/features/school_classes/services/school_class_service.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

final schClassProvider =
    AsyncNotifierProvider<SchClassNotifier, List<SchoolClass>>(
        SchClassNotifier.new);

class SchClassNotifier extends AsyncNotifier<List<SchoolClass>> {
  final service = SchoolClassService();

  @override
  Future<List<SchoolClass>> build() async {
    return service.getAllSchClassData();
  }

  Future<void> createData(SchoolClass schClass) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await service.createSchClassData(schClass);
      return service.getAllSchClassData();
    });
  }

  Future<void> deleteData(int id) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await service.deleteSchClassData(id);
      return service.getAllSchClassData();
    });
  }

  Future<void> updateData(SchoolClass schClass) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await service.updateSchClassData(schClass);
      return service.getAllSchClassData();
    });
  }
}

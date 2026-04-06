import 'package:absensi_kelas/core/database/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:absensi_kelas/core/database/app_database.dart';
import 'package:absensi_kelas/features/school_classes/services/school_class_service.dart';

final schoolClassProvider =
    AsyncNotifierProvider<SchoolClassNotifier, List<SchoolClassesData>>(
        SchoolClassNotifier.new);

class SchoolClassNotifier extends AsyncNotifier<List<SchoolClassesData>> {
  late final SchoolClassService service;

  @override
  Future<List<SchoolClassesData>> build() async {
    service = ref.read(schoolClassServiceProvider);
    return service.getAllClasses();
  }

  Future<void> addClass(String name) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await service.addClass(name);
      return service.getAllClasses();
    });
  }

  Future<void> updateClass(int id, String name) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await service.updateClass(id, name);
      return service.getAllClasses();
    });
  }

  Future<void> deleteClass(int id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await service.deleteClassCascade(id);
      return service.getAllClasses();
    });
  }
}
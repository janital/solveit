import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/models/project.dart';
import 'package:project/services/project_service.dart';

final projectProvider = Provider<ProjectService>((ref) {
  final ProjectService projectService = FirebaseProjectService();
  return projectService;
});

final currentProjectProvider =
    StateNotifierProvider<CurrentProjectNotifier, Stream<Project?>>((ref) {
  return CurrentProjectNotifier();
});

class CurrentProjectNotifier extends StateNotifier<Stream<Project?>> {
  CurrentProjectNotifier() : super(Stream<Project?>.value(Project()));

  void setProject(Stream<Project?> project) {
    state = project;
  }
}

final editProjectProvider =
    StateNotifierProvider<EditProjectNotifier, Project?>((ref) {
  return EditProjectNotifier();
});

class EditProjectNotifier extends StateNotifier<Project?> {
  EditProjectNotifier() : super(null);

  void setProject(Project? project) {
    state = project;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/data/project_avatar_options.dart';
import 'package:project/models/tag.dart';

/// The data content of a project in the application.
class Project {
  /// The id of the project.
  String projectId;

  /// The name of the project.
  String title;

  /// The list of tags in the project.
  List<Tag> tags;

  /// User id of the owner of this project.
  String owner;

  /// List of users collaborating on this project.
  List<String> collaborators;

  /// Path to project avatar.s
  String imageUrl;

  /// Description of the project.
  String description;

  /// Whether the project is public or not.
  bool isPublic;

  /// When the project was last updated.
  DateTime? lastUpdated;

  /// Creates an instance of [Project],
  Project({
    this.projectId = "",
    this.title = "",
    List<Tag>? tags,
    this.owner = "",
    List<String>? collaborators,
    String? imageUrl,
    this.description = "",
    DateTime? lastUpdated,
    this.isPublic = false,
  })  : imageUrl = imageUrl ?? projectAvatars[0],
        collaborators = collaborators ?? [],
        tags = tags ?? [],
        lastUpdated = lastUpdated ?? DateTime.now();

  /// Converts a [Map] object to a [Project] object.
  static Project? fromMap(Map<String, dynamic>? data) {
    if (null == data) {
      return null;
    }
    final String? id = data["projectId"];
    final String? title = data['title'];
    final String? description = data['description'] ?? "";
    final List<String>? collaborators = data["collaborators"] != null
        ? data["collaborators"].cast<String>()
        : <String>[];
    final bool? isPublic = data["isPublic"] ?? false;
    final String? owner = data["owner"];
    final DateTime lastUpdated = data['lastUpdated'] != null
        ? (data['lastUpdated'] as Timestamp).toDate()
        : DateTime.now();
    final String? imageUrl = data['imageUrl'];
    final List<Tag> tags =
        data["tags"] != null ? Tag.fromMaps(data["tags"]) : <Tag>[];

    if (id == null || title == null || owner == null) {
      return null;
    }

    return Project(
      projectId: id,
      title: title,
      imageUrl: imageUrl,
      description: description!,
      owner: owner,
      collaborators: collaborators,
      isPublic: isPublic!,
      lastUpdated: lastUpdated,
      tags: tags,
    );
  }

  /// Creates a list of projects from a list of maps.
  static List<Project> fromMaps(var data) {
    List<Project> projects = [];
    for (var value in data) {
      Project? project = fromMap(value.data());
      if (project != null) {
        projects.add(project);
      }
    }
    return projects;
  }

  /// Creates a map of string and dynamics of the project.
  Map<String, dynamic> toMap() {
    return {
      "projectId": projectId,
      "title": title,
      "tags": tags.map((e) => e.toMap()).toList(),
      "collaborators": collaborators,
      "owner": owner,
      "imageUrl": imageUrl,
      "description": description,
      "isPublic": isPublic,
      "lastUpdated": lastUpdated
    };
  }

  @override
  int get hashCode => projectId.hashCode;

  @override
  bool operator ==(Object other) {
    return projectId == (other as Project).projectId;
  }
}

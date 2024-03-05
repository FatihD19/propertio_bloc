import 'package:propertio_mobile/data/model/developer_model.dart';
import 'package:propertio_mobile/data/model/pagination_model.dart';
import 'package:propertio_mobile/data/model/proyek_model.dart';

class ListProjectModel {
  String? status;
  String? message;
  Data? data;

  ListProjectModel({
    this.status,
    this.message,
    this.data,
  });

  factory ListProjectModel.fromJson(Map<String, dynamic> json) =>
      ListProjectModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<ProjectModel>? projectsRecomendation;
  List<ProjectModel>? projects;
  List<DeveloperModel>? developers;
  Pagination? pagination;

  Data({
    this.projectsRecomendation,
    this.projects,
    this.developers,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        projectsRecomendation: json["projects_recomendation"] == null
            ? []
            : List<ProjectModel>.from(json["projects_recomendation"]!
                .map((x) => ProjectModel.fromJson(x))),
        projects: json["projects"] == null
            ? []
            : List<ProjectModel>.from(
                json["projects"]!.map((x) => ProjectModel.fromJson(x))),
        developers: json["developers"] == null
            ? []
            : List<DeveloperModel>.from(
                json["developers"]!.map((x) => DeveloperModel.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "projects_recomendation": projectsRecomendation == null
            ? []
            : List<dynamic>.from(projectsRecomendation!.map((x) => x.toJson())),
        "projects": projects == null
            ? []
            : List<dynamic>.from(projects!.map((x) => x.toJson())),
        "developers": developers == null
            ? []
            : List<dynamic>.from(developers!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

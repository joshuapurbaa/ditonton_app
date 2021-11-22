import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_crew.dart';

class CrewModel extends Equatable {
  CrewModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.department,
    required this.job,
    required this.profilePath,
  });

  final int id;
  final String creditId;
  final String name;
  final String department;
  final String? job;
  final String? profilePath;

  factory CrewModel.fromJson(Map<String, dynamic> json) => CrewModel(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        department: json["department"],
        job: json["job"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "department": department,
        "job": job,
        "profile_path": profilePath,
      };
  Crew toEntity() {
    return Crew(
      id: this.id,
      creditId: this.creditId,
      name: this.name,
      department: this.department,
      job: this.job,
      profilePath: this.profilePath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        creditId,
        name,
        department,
        job,
        profilePath,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_create_by.dart';

class CreatedByModel extends Equatable {
  CreatedByModel({
    this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  });

  final int? id;
  final String? creditId;
  final String? name;
  final int? gender;
  final String? profilePath;

  factory CreatedByModel.fromJson(Map<String, dynamic> json) => CreatedByModel(
        id: json['id'],
        creditId: json['credit_id'],
        name: json['name'],
        gender: json['gender'],
        profilePath: json['profile_path'],
      );

  CreatedBy toEntity() => CreatedBy(
        id: this.id,
        creditId: this.creditId,
        name: this.name,
        gender: this.gender,
        profilePath: this.profilePath,
      );

  @override
  List<Object?> get props => [
        id,
        creditId,
        name,
        gender,
        profilePath,
      ];
}

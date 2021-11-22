import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_guest_stars.dart';

class GuestStarModel extends Equatable {
  GuestStarModel({
    required this.id,
    required this.name,
    required this.creditId,
    required this.character,
    required this.order,
    required this.profilePath,
  });

  final int id;
  final String name;
  final String creditId;
  final String character;
  final int order;
  final String? profilePath;

  factory GuestStarModel.fromJson(Map<String, dynamic> json) => GuestStarModel(
        id: json["id"],
        name: json["name"],
        creditId: json["credit_id"],
        character: json["character"],
        order: json["order"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "credit_id": creditId,
        "character": character,
        "order": order,
        "profile_path": profilePath,
      };

  GuestStars toEntity() {
    return GuestStars(
      id: this.id,
      name: this.name,
      creditId: this.creditId,
      character: this.character,
      order: this.order,
      profilePath: this.profilePath,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        creditId,
        character,
        order,
        profilePath,
      ];
}

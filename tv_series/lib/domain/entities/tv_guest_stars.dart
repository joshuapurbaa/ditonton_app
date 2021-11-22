import 'package:equatable/equatable.dart';

class GuestStars extends Equatable {
  GuestStars({
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

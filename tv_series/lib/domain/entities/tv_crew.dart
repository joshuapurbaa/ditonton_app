import 'package:equatable/equatable.dart';

class Crew extends Equatable {
  Crew({
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

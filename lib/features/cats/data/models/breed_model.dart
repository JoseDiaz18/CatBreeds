import 'package:equatable/equatable.dart';

import '../../domain/entities/breed.dart';

class BreedModel extends Equatable {
  final String id;
  final String name;
  final String origin;
  final String description;
  final String temperament;
  final String lifeSpan;
  final int intelligence;
  final String imageUrl;

  const BreedModel({
    required this.id,
    required this.name,
    required this.origin,
    required this.description,
    required this.temperament,
    required this.lifeSpan,
    required this.intelligence,
    required this.imageUrl,
  });

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      origin: json['origin'] ?? '',
      description: json['description'] ?? '',
      temperament: json['temperament'] ?? '',
      lifeSpan: json['life_span'] ?? '',
      intelligence: json['intelligence'] ?? 0,
      imageUrl: json['image']?['url'] ?? '',
    );
  }

  Breed toEntity() {
    return Breed(
      id: id,
      name: name,
      origin: origin,
      description: description,
      temperament: temperament,
      lifeSpan: lifeSpan,
      intelligence: intelligence,
      imageUrl: imageUrl,
    );
  }

  @override
  List<Object?> get props => [
    name,
    origin,
    description,
    temperament,
    lifeSpan,
    intelligence,
    imageUrl,
  ];
}

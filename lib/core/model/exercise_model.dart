class ExerciseModel {
  final String id;
  final String name;
  final String gifUrl;
  final List<String> targetMuscles;
  final List<String> secondaryMuscles;
  final List<String> bodyParts;
  final List<String> equipments;
  final List<String> instructions;

  const ExerciseModel({
    required this.id,
    required this.name,
    required this.gifUrl,
    required this.targetMuscles,
    required this.secondaryMuscles,
    required this.bodyParts,
    required this.equipments,
    required this.instructions,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['exerciseId'],
      name: json['name'],
      gifUrl: json['gifUrl'],
      targetMuscles: List<String>.from(json['targetMuscles'] ?? []),
      secondaryMuscles: List<String>.from(json['secondaryMuscles'] ?? []),
      bodyParts: List<String>.from(json['bodyParts'] ?? []),
      equipments: List<String>.from(json['equipments'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
    );
  }
}

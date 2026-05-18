import 'package:hive/hive.dart';

part 'meal_model.g.dart';

@HiveType(typeId: 0)
class Meal extends HiveObject {
  @HiveField(0)
  final String idMeal;

  @HiveField(1)
  final String strMeal;

  @HiveField(2)
  final String strCategory;

  @HiveField(3)
  final String strArea;

  @HiveField(4)
  final String strInstructions;

  @HiveField(5)
  final String strMealThumb;

  @HiveField(6)
  final String strSource;

  @HiveField(7)
  final String strCountry;

  Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    required this.strSource,
    required this.strCountry,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strCategory: json['strCategory'] ?? '',
      strArea: json['strArea'] ?? '',
      strInstructions: json['strInstructions'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      strSource: json['strSource'] ?? '',
      strCountry: json['strArea'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strCategory': strCategory,
      'strArea': strArea,
      'strInstructions': strInstructions,
      'strMealThumb': strMealThumb,
      'strSource': strSource,
      'strCountry': strCountry,
    };
  }
}

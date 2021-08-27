typedef Json = Map<String, dynamic>;

class Meal {
  final String idMeal;
  final String strMeal;
  final String strCategory;
  final String strArea;
  final String strMealThumb;
  final String strInstructions;

  const Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strArea,
    required this.strMealThumb,
    required this.strInstructions,
  });

  factory Meal.fromJson(Json json) {
    return Meal(
      idMeal: json['idMeal'] as String,
      strMeal: json['strMeal'] as String,
      strCategory: json['strCategory'] as String,
      strArea: json['strArea'] as String,
      strMealThumb: json['strMealThumb'] as String,
      strInstructions: json['strInstructions'] as String,
    );
  }
}

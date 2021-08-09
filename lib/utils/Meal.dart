typedef Json = Map<String, dynamic>;

class Meal {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  const Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
  });

  factory Meal.fromJson(Json json) {
    return Meal(
      idMeal: json['idMeal'] as String,
      strMeal: json['strMeal'] as String,
      strMealThumb: json['strMealThumb'] as String,
    );
  }
}

typedef Json = Map<String, dynamic>;

class DrinkDetail {
  final String idDrink;
  final String strDrink;
  final String strCategory;
  final String strInstructions;
  final String strDrinkThumb;

  const DrinkDetail({
    required this.idDrink,
    required this.strDrink,
    required this.strCategory,
    required this.strInstructions,
    required this.strDrinkThumb,
  });

  factory DrinkDetail.fromJson(Json json) {
    return DrinkDetail(
      idDrink: json['idDrink'] as String,
      strDrink: json['strDrink'] as String,
      strCategory: json['strCategory'] as String,
      strInstructions: json['strInstructions'] as String,
      strDrinkThumb: json['strDrinkThumb'] as String,
    );
  }
}

class Drink {
  final String idDrink;
  final String strDrink;
  final String strDrinkThumb;

  const Drink({
    required this.idDrink,
    required this.strDrink,
    required this.strDrinkThumb,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      idDrink: json['idDrink'] as String,
      strDrink: json['strDrink'] as String,
      strDrinkThumb: json['strDrinkThumb'] as String,
    );
  }
}

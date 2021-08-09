import 'package:recipes_app/services/api.dart';

Map<String, dynamic> mealOptions = {
  'title': 'Meals',
  'fetch': fetchMeals,
};

Map<String, dynamic> drinkOptions = {
  'title': 'Drinks',
  'fetch': fetchDrinks,
};

Map<String, dynamic> mealDetailOptions = {
  'fetch': fetchMealDetails,
};

Map<String, dynamic> drinkDetailOptions = {
  'fetch': fetchDrinkDetails,
};

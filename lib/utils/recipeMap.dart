Map<String, dynamic> createMealMap(recipe) {
  return {
    'id': recipe.idMeal,
    'thumb': recipe.strMealThumb,
    'title': recipe.strMeal,
    'category': recipe.strCategory,
    'area': recipe.strArea,
    'instructions': recipe.strInstructions,
    'route': '/meal/details',
  };
}

Map<String, dynamic> createDrinkMap(recipe) {
  return {
    'id': recipe.idDrink,
    'thumb': recipe.strDrinkThumb,
    'title': recipe.strDrink,
    'category': recipe.strCategory,
    'area': '',
    'instructions': recipe.strInstructions,
    'route': '/drink/details',
  };
}

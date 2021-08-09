import 'package:flutter/material.dart';
import 'package:recipes_app/explore.dart';
import 'package:recipes_app/home.dart';
import 'package:recipes_app/recipeDetails.dart';
import 'package:recipes_app/recipes.dart';
import 'package:recipes_app/utils/options.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes App',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(36, 153, 127, 1),
      ),
      routes: {
        '/': (context) => MyHomePage(title: 'Recipes App'),
        '/meals': (context) => RecipesPage(
              title: mealOptions['title'],
              fetch: mealOptions['fetch'],
            ),
        '/drinks': (context) => RecipesPage(
              title: drinkOptions['title'],
              fetch: drinkOptions['fetch'],
            ),
        '/explore': (context) => ExplorePage(title: 'Explore'),
        '/meal/details': (context) => RecipeDetails(
              fetch: mealDetailOptions['fetch'],
            ),
        '/drink/details': (context) => RecipeDetails(
              fetch: drinkDetailOptions['fetch'],
            ),
      },
    );
  }
}

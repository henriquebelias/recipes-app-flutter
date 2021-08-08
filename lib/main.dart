import 'package:flutter/material.dart';
import 'package:recipes_app/drinkDetails.dart';
import 'package:recipes_app/explore.dart';

import 'package:recipes_app/home.dart';
import 'package:recipes_app/mealDetails.dart';
import 'package:recipes_app/meals.dart';
import 'package:recipes_app/drinks.dart';

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
        '/meals': (context) => MealsPage(title: 'Meals'),
        '/drinks': (context) => DrinksPage(title: 'Drinks'),
        '/explore': (context) => ExplorePage(title: 'Explore'),
        '/meal/details': (context) => MealDetails(),
        '/drink/details': (context) => DrinkDetails(),
      },
    );
  }
}

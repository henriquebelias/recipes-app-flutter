import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:recipes_app/utils/Drink.dart';
import 'package:recipes_app/utils/Meal.dart';

typedef Json = Map<String, dynamic>;

// Fetch a list of meals
Future<List<Meal>> fetchMeals() async {
  final response = await http.get(
    Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s='),
  );

  return compute(parseMeals, response.body);
}

List<Meal> parseMeals(String responseBody) {
  final parsed = jsonDecode(responseBody);

  final mealsObj = parsed['meals'].cast<Json>();

  return mealsObj.map<Meal>((json) => Meal.fromJson(json)).toList();
}

// Fetch a list of drinks
Future<List<Drink>> fetchDrinks() async {
  final response = await http.get(
    Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/search.php?s='),
  );

  return compute(parseDrinks, response.body);
}

List<Drink> parseDrinks(String responseBody) {
  final parsed = jsonDecode(responseBody);

  final drinksObj = parsed['drinks'].cast<Map<String, dynamic>>();

  return drinksObj.map<Drink>((json) => Drink.fromJson(json)).toList();
}

// Fetch a meal details
Future<List<Meal>> fetchMealDetails(id) async {
  final response = await http.get(
    Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'),
  );

  return compute(parseMealDetails, response.body);
}

List<Meal> parseMealDetails(String responseBody) {
  final parsed = jsonDecode(responseBody);

  final mealDetailObj = parsed['meals'].cast<Json>();

  return mealDetailObj.map<Meal>((json) => Meal.fromJson(json)).toList();
}

// Fetch a drink details
Future<List<Drink>> fetchDrinkDetails(id) async {
  final response = await http.get(
    Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id'),
  );

  return compute(parseDrinkDetails, response.body);
}

List<Drink> parseDrinkDetails(String responseBody) {
  final parsed = jsonDecode(responseBody);

  final drinkDetailObj = parsed['drinks'].cast<Json>();

  return drinkDetailObj.map<Drink>((json) => Drink.fromJson(json)).toList();
}

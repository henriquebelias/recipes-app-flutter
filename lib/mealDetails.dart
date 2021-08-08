import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

typedef Json = Map<String, dynamic>;

class MealDetail {
  final String idMeal;
  final String strMeal;
  final String strCategory;
  final String strArea;
  final String strMealThumb;
  final String strInstructions;

  const MealDetail({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strArea,
    required this.strMealThumb,
    required this.strInstructions,
  });

  factory MealDetail.fromJson(Json json) {
    return MealDetail(
      idMeal: json['idMeal'] as String,
      strMeal: json['strMeal'] as String,
      strCategory: json['strCategory'] as String,
      strArea: json['strArea'] as String,
      strMealThumb: json['strMealThumb'] as String,
      strInstructions: json['strInstructions'] as String,
    );
  }
}

Future<List<MealDetail>> fetchMealDetails(id) async {
  final response = await http.get(
    Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'),
  );

  return compute(parseMealDetails, response.body);
}

List<MealDetail> parseMealDetails(String responseBody) {
  final parsed = jsonDecode(responseBody);

  final mealDetailObj = parsed['meals'].cast<Json>();

  return mealDetailObj
      .map<MealDetail>((json) => MealDetail.fromJson(json))
      .toList();
}

class MealDetails extends StatelessWidget {
  const MealDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: FutureBuilder<List<MealDetail>>(
        future: fetchMealDetails(id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return MealDetailList(meal: snapshot.data!);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: ElevatedButton(
        child: Text('Go Back!'),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}

class MealDetailList extends StatelessWidget {
  const MealDetailList({Key? key, required this.meal}) : super(key: key);

  final List<MealDetail> meal;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              meal[0].strMeal,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(meal[0].strCategory),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(meal[0].strArea),
          ),
        ),
        Center(
          child: Image.network(
            meal[0].strMealThumb,
            width: 350,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(meal[0].strInstructions),
          ),
        ),
      ],
    );
  }
}

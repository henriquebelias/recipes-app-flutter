import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class MealsPage extends StatelessWidget {
  MealsPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => print('Perfil'),
              icon: Icon(
                Icons.account_circle_rounded,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () => print('Search'),
              icon: Icon(
                Icons.search,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Meal>>(
        future: fetchMeals(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return MealsList(meals: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(253, 128, 97, 1),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.wine_bar),
            label: 'Drinks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining),
            label: 'Meals',
          ),
        ],
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/drinks');
          }
          if (index == 1) {
            Navigator.pushNamed(context, '/explore');
          }
          if (index == 2) {
            Navigator.pushNamed(context, '/meals');
          }
        },
      ),
    );
  }
}

class MealsList extends StatelessWidget {
  const MealsList({Key? key, required this.meals}) : super(key: key);

  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            '/meal/details',
            arguments: meals[index].idMeal,
          ),
          child: Container(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(meals[index].strMealThumb),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(meals[index].strMeal),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

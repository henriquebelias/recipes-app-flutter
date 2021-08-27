import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/utils/Meal.dart';
import 'package:recipes_app/utils/recipeMap.dart';

class RecipeDetails extends StatelessWidget {
  const RecipeDetails({required this.fetch});

  final Function fetch;

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: FutureBuilder(
        future: fetch(id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return RecipeDetailsList(recipe: snapshot.data!);
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

class RecipeDetailsList extends StatelessWidget {
  const RecipeDetailsList({Key? key, required this.recipe}) : super(key: key);

  final recipe;

  @override
  Widget build(BuildContext context) {
    final recipeMap = recipe[0] is Meal
        ? createMealMap(recipe[0])
        : createDrinkMap(recipe[0]);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              recipeMap['title'],
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(recipe[0].strCategory),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(recipeMap['area']),
          ),
        ),
        Center(
          child: Image.network(
            recipeMap['thumb'],
            width: 350,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(recipe[0].strInstructions),
          ),
        ),
      ],
    );
  }
}

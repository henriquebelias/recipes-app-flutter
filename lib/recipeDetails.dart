import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipes_app/utils/MealDetail.dart';

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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              recipe[0] is MealDetail ? recipe[0].strMeal : recipe[0].strDrink,
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
            child: Text(recipe[0] is MealDetail ? recipe[0].strArea : ''),
          ),
        ),
        Center(
          child: Image.network(
            recipe[0] is MealDetail
                ? recipe[0].strMealThumb
                : recipe[0].strDrinkThumb,
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

import 'package:flutter/material.dart';
import 'package:recipes_app/utils/Meal.dart';

class RecipesPage extends StatelessWidget {
  RecipesPage({required this.title, required this.fetch});

  final String title;
  final Function fetch;

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
      body: FutureBuilder(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return RecipesList(recipes: snapshot.data!);
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
        currentIndex: title == 'Meals' ? 2 : 0,
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

class RecipesList extends StatelessWidget {
  const RecipesList({Key? key, required this.recipes}) : super(key: key);

  final recipes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            recipes[index] is Meal ? '/meal/details' : '/drink/details',
            arguments: recipes[index] is Meal
                ? recipes[index].idMeal
                : recipes[index].idDrink,
          ),
          child: Container(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    recipes[index] is Meal
                        ? recipes[index].strMealThumb
                        : recipes[index].strDrinkThumb,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    recipes[index] is Meal
                        ? recipes[index].strMeal
                        : recipes[index].strDrink,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

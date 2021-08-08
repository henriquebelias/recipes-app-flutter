import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

typedef Json = Map<String, dynamic>;

class Drink {
  final String idDrink;
  final String strDrink;
  final String strDrinkThumb;

  const Drink({
    required this.idDrink,
    required this.strDrink,
    required this.strDrinkThumb,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      idDrink: json['idDrink'] as String,
      strDrink: json['strDrink'] as String,
      strDrinkThumb: json['strDrinkThumb'] as String,
    );
  }
}

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

class DrinksPage extends StatelessWidget {
  DrinksPage({required this.title});

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
      body: FutureBuilder<List<Drink>>(
        future: fetchDrinks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has ocurred!'),
            );
          } else if (snapshot.hasData) {
            return DrinksList(drinks: snapshot.data!);
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
        currentIndex: 0,
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

class DrinksList extends StatelessWidget {
  const DrinksList({Key? key, required this.drinks}) : super(key: key);

  final List<Drink> drinks;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: drinks.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            '/drink/details',
            arguments: drinks[index].idDrink,
          ),
          child: Container(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(drinks[index].strDrinkThumb),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(drinks[index].strDrink),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

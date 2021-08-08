import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

typedef Json = Map<String, dynamic>;

class DrinkDetail {
  final String idDrink;
  final String strDrink;
  final String strCategory;
  final String strInstructions;
  final String strDrinkThumb;

  const DrinkDetail({
    required this.idDrink,
    required this.strDrink,
    required this.strCategory,
    required this.strInstructions,
    required this.strDrinkThumb,
  });

  factory DrinkDetail.fromJson(Json json) {
    return DrinkDetail(
      idDrink: json['idDrink'] as String,
      strDrink: json['strDrink'] as String,
      strCategory: json['strCategory'] as String,
      strInstructions: json['strInstructions'] as String,
      strDrinkThumb: json['strDrinkThumb'] as String,
    );
  }
}

Future<List<DrinkDetail>> fetchDrinkDetails(id) async {
  final response = await http.get(
    Uri.parse('https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id'),
  );

  return compute(parseDrinkDetails, response.body);
}

List<DrinkDetail> parseDrinkDetails(String responseBody) {
  final parsed = jsonDecode(responseBody);

  final drinkDetailObj = parsed['drinks'].cast<Json>();

  return drinkDetailObj
      .map<DrinkDetail>((json) => DrinkDetail.fromJson(json))
      .toList();
}

class DrinkDetails extends StatelessWidget {
  const DrinkDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: FutureBuilder<List<DrinkDetail>>(
        future: fetchDrinkDetails(id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error has ocurred!'),
            );
          } else if (snapshot.hasData) {
            return DrinkDetailList(drink: snapshot.data!);
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

class DrinkDetailList extends StatelessWidget {
  const DrinkDetailList({Key? key, required this.drink}) : super(key: key);

  final List<DrinkDetail> drink;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              drink[0].strDrink,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(drink[0].strCategory),
          ),
        ),
        Center(
          child: Image.network(
            drink[0].strDrinkThumb,
            width: 350,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text(drink[0].strInstructions),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        color: Color.fromRGBO(135, 14, 70, 1),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: AssetImage('images/cooking.png'),
              ),
              Text(
                'Welcome, chef',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(150, 50),
                ),
                onPressed: () => {
                  Navigator.pushNamed(
                    context,
                    '/meals',
                  ),
                },
                child: Text('SEE THE RECIPES'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

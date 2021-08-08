import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: () => print('Perfil'),
              icon: Icon(
                Icons.account_circle_rounded,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Explorar Comidas'),
            Text('Explorar Bebidas'),
          ],
        ),
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
        currentIndex: 1,
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

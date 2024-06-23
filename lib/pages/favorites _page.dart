import 'package:flutter/material.dart';
import 'package:food_delivery/models/food_item.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<FoodItem> favoriteList =
      food.where((element) => element.isFavorit == true).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: favoriteList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(
                  favoriteList[index].id.toString()), // Unique key for each item
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                setState(() {
                  final selectedFoodItemIndex = food.indexOf(favoriteList[index]);
                  food[selectedFoodItemIndex] = favoriteList[index]
                      .copywith(!favoriteList[index].isFavorit);
                  favoriteList.removeAt(index);
                });
              },
              background: Container(
                color: const Color.fromARGB(255, 244, 117, 54),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                      favoriteList[index].imgUrl,
                      height: 100,
                      width: 70,
                      fit: BoxFit.fill,
                    ),
                    title: Text(
                      favoriteList[index].name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${favoriteList[index].category} - \$${favoriteList[index].price} ',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.favorite,
                      ),
                      color: Colors.deepOrange,
                      onPressed: () {
                        setState(() {
                          final selectedFoodItemIndex =
                              food.indexOf(favoriteList[index]);
      
                          food[selectedFoodItemIndex] = favoriteList[index]
                              .copywith(!favoriteList[index].isFavorit);
                          favoriteList.removeAt(index);
                        });
                      },
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

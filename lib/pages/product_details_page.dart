import 'package:flutter/material.dart';
import 'package:food_delivery/models/food_item.dart';

class ProductDetailsPage extends StatelessWidget {
  final FoodItem foodItem;
  const ProductDetailsPage(
      {super.key, required this.foodItem}); // constructor injection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('product details '),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.grey[100]),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Image.network(
                  foodItem.imgUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            foodItem.name,
                            style: const TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            foodItem.category,
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(24.0)),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.remove)),
                            Text('1'),
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.add))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'size',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            'Meduim',
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w800),
                          ),
                        ],
                      )
                    ],
                  ),
                  Text(
                    foodItem.price.toString(),
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

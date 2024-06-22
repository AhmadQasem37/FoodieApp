
import 'package:flutter/material.dart';
import 'package:food_delivery/models/FireStore.dart';
import 'package:food_delivery/models/food_item.dart';
import 'package:food_delivery/widgets/product_details_property.dart';

class ProductDetailsPage extends StatefulWidget {
  final FoodItem foodItem;
  const ProductDetailsPage({super.key, required this.foodItem});
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;

  void _decreaseQuantity() {
    setState(() {
      quantity--;
    });
  }

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  FireStoreSend _fireStoreSend = FireStoreSend();

  // constructor injection
  @override
  Widget build(BuildContext context) {
    double totalPrice = double.parse(widget.foodItem.price) * quantity;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('product details '),
        backgroundColor: Colors.grey[100],
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
          const SizedBox(
            width: 8.0,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey[100]),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Image.network(
                          widget.foodItem.imgUrl,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.foodItem.name,
                                    style: const TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.foodItem.category,
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24.0)),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: quantity > 1
                                            ? _decreaseQuantity
                                            : null,
                                        icon: const Icon(Icons.remove)),
                                    Text(quantity.toString()),
                                    IconButton(
                                        onPressed: _increaseQuantity,
                                        icon: const Icon(Icons.add))
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 32.0,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ProductDetailsProperty(
                                  title: 'Size', value: 'Meduim'),
                              SizedBox(height: 40.0, child: VerticalDivider()),
                              ProductDetailsProperty(
                                  title: 'Calories', value: '640 kcal'),
                              SizedBox(height: 40.0, child: VerticalDivider()),
                              ProductDetailsProperty(
                                  title: 'Cooking', value: '5-10 Mins'),
                            ],
                          ),
                          const SizedBox(
                            height: 32.0,
                          ),
                          const Text(
                            'Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom Lorem Ipsom',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black45),
                          ),
                          Text(
                            widget.foodItem.price.toString(),
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
            ),
            SizedBox(
              height: size.width > 800 ? size.height * 0.08 : size.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      '\$ ${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: size.height *0.08,
                      child: ElevatedButton(
                        onPressed: () {
                          // _fireStoreSend.addToCart(widget.foodItem.imgUr, w);
                          _fireStoreSend.addToCart(widget.foodItem.imgUrl,
                              widget.foodItem.name, quantity, totalPrice);
                          Navigator.of(context).pushReplacementNamed("Home");
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

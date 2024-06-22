import 'package:flutter/material.dart';
import 'package:food_delivery/models/category_item.dart';
import 'package:food_delivery/models/food_item.dart';
import 'package:food_delivery/pages/product_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? selectedCategoryIndex;
  late List<FoodItem> filteredFood;

  @override
  void initState() {
    super.initState();
    debugPrint('iam in the init state now!');
    filteredFood = food;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('i am in the build now!');
    final size =
        MediaQuery.of(context).size; // List<Map<String, dynamic>> products = [
    //   {
    //     'name': 'Beef Burger',
    //     'category': 'Burger',
    //     'price': '6.99',
    //     'imgUrl':
    //         'https://static.vecteezy.com/system/resources/previews/022/598/800/original/tasty-beef-burger-png.png'
    //   },
    //   {
    //     'name': 'Chicken Burger',
    //     'category': 'Burger',
    //     'price': '6.99',
    //     'imgUrl':
    //         'https://static.vecteezy.com/system/resources/previews/022/598/800/original/tasty-beef-burger-png.png'
    //   },
    //   {
    //     'name': 'Beef Burger',
    //     'category': 'Burger',
    //     'price': '6.99',
    //     'imgUrl':
    //         'https://static.vecteezy.com/system/resources/previews/022/598/800/original/tasty-beef-burger-png.png'
    //   },
    //   {
    //     'name': 'Chicken Burger',
    //     'category': 'Burger',
    //     'price': '6.99',
    //     'imgUrl':
    //         'https://static.vecteezy.com/system/resources/previews/022/598/800/original/tasty-beef-burger-png.png'
    //   },
    //   {
    //     'name': 'Beef Burger',
    //     'category': 'Burger',
    //     'price': '6.99',
    //     'imgUrl':
    //         'https://static.vecteezy.com/system/resources/previews/022/598/800/original/tasty-beef-burger-png.png'
    //   },
    //   {
    //     'name': 'Chicken Burger',
    //     'category': 'Burger',
    //     'price': '6.99',
    //     'imgUrl':
    //         'https://static.vecteezy.com/system/resources/previews/022/598/800/original/tasty-beef-burger-png.png'
    //   },
    //   {
    //     'name': 'Beef Burger',
    //     'category': 'Burger',
    //     'price': '6.99',
    //     'imgUrl':
    //         'https://static.vecteezy.com/system/resources/previews/022/598/800/original/tasty-beef-burger-png.png'
    //   },
    //   {
    //     'name': 'Chicken Burger',
    //     'category': 'Burger',
    //     'price': '6.99',
    //     'imgUrl':
    //         'https://static.vecteezy.com/system/resources/previews/022/598/800/original/tasty-beef-burger-png.png'
    //   },
    // ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {

                    },
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.menu),
                        )),
                  ),
                  const Column(
                    children: [
                      Text(
                        'current loacation ',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            'Jenin, Palestine',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Icon(Icons.notifications)),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://img.freepik.com/free-psd/delicious-burger-food-menu-facebook-cover-template_106176-756.jpg',
                  fit: BoxFit.fill,
                  height:
                      size.width > 800 ? size.height * 45 : size.height * 0.25,
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Find your food...',
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Colors.grey,
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              SizedBox(
                height: size.height * 0.15,
                child: ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsetsDirectional.only(end: 11.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (selectedCategoryIndex == null ||
                              selectedCategoryIndex != index) {
                            selectedCategoryIndex = index;
                          } else {
                            selectedCategoryIndex = null;
                            filteredFood = food;
                          }
                        });
                        if (selectedCategoryIndex != null) {
                          final selectedCategory =
                              categories[selectedCategoryIndex!];
                          filteredFood = food
                              .where((element) =>
                                  element.category == selectedCategory.name)
                              .toList();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: index == selectedCategoryIndex
                                ? const Color.fromARGB(236, 229, 72, 25)
                                : Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                categories[index].assetPath,
                                height: 50,
                                width: 50,
                                color: index == selectedCategoryIndex
                                    ? Colors.white
                                    : null,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                categories[index].name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: index == selectedCategoryIndex
                                        ? Colors.white
                                        : Colors.black54),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32.0,
              ),
              // Padding(
              //   padding: const EdgeInsetsDirectional.all(8.0),
              //   child:
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size.width > 1100
                        ? 5
                        : size.width > 800
                            ? 4
                            : 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18),
                itemCount: filteredFood.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    LayoutBuilder(builder: (context, constrains) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                              foodItem: filteredFood[index])));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Column(
                            children: [
                              Image.network(
                                filteredFood[index].imgUrl,
                                height: constrains.maxHeight * 0.45,
                                width: 100,
                              ),
                              Text(
                                filteredFood[index].name,
                                style: TextStyle(
                                    fontSize: constrains.maxHeight * 0.09,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                filteredFood[index].category,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '\$ ${filteredFood[index].price}',
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: constrains.maxHeight * 0.09,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          PositionedDirectional(
                            top: 0,
                            end: 0,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    // filteredFood[index].isFavorit =
                                    //     !filteredFood[index].isFavorit;
                                    final selectedFoodItemIndex =
                                        food.indexOf(filteredFood[index]);
                                    filteredFood[index] = filteredFood[index]
                                        .copywith(
                                            !filteredFood[index].isFavorit);
                                    food[selectedFoodItemIndex] =
                                        filteredFood[index];
                                  });
                                },
                                icon: Icon(
                                  filteredFood[index].isFavorit == false
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: Colors.deepOrange,
                                )),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
              // GridView(
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       mainAxisSpacing: 18,
              //       crossAxisSpacing: 18),
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),

              //   children: [
              //     Container(

              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(16.0)),
              //       child: Column(
              //         children: [
              //           Image.network(
              //             'https://static.vecteezy.com/system/resources/previews/022/598/800/original/tasty-beef-burger-png.png',
              //             height: 100,
              //           ),
              //           const Text(
              //             'Beef Burger',
              //             style: TextStyle(
              //                 fontSize: 18, fontWeight: FontWeight.w600),
              //           ),
              //           const Text(
              //             'Burger',
              //             style: TextStyle(
              //               color: Colors.grey,
              //             ),
              //           ),
              //           const Text(
              //             '\$6.99',
              //             style: TextStyle(
              //                 color: Colors.deepOrange,
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.w600),
              //           ),
              //         ],
              //       ),
              //     ),

              //   FlutterLogo(),FlutterLogo(size: 24,),FlutterLogo(size: 24,),FlutterLogo(size: 24,),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}

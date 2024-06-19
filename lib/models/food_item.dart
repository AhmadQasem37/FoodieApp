class FoodItem {
  final int id;
  final String category;
  final String name;
  final String imgUrl;
  final double price;
  final int sales;
  final String time;
  final bool isFavorit;
  FoodItem(
      {required this.id,
      required this.category,
      required this.name,
      required this.imgUrl,
      required this.price,
      this.sales = 0,
      this.time = '2024',
      this.isFavorit = false});
  FoodItem copywith(bool? isFavorit) {
    return FoodItem(
        id: id,
        category: category,
        name: name,
        imgUrl: imgUrl,
        price: price,
        sales: sales,
        time: time,
        isFavorit: isFavorit ?? this.isFavorit);
  }
}

List<FoodItem> food = [
  FoodItem(
      id: 1,
      category: 'Burger',
      name: 'Beef Burger',
      imgUrl:
          'https://static.vecteezy.com/system/resources/previews/022/598/800/original/tasty-beef-burger-png.png',
      price: 5.99),
  FoodItem(
      id: 2,
      category: 'Burger',
      name: 'Chicken Burger',
      imgUrl:
          'https://static.vecteezy.com/system/resources/previews/034/763/818/non_2x/ai-generated-fried-chicken-burger-free-png.png',
      price: 5.99),
  FoodItem(
      id: 3,
      category: 'Burger',
      name: 'cheese Burger',
      imgUrl:
          'https://freepngimg.com/thumb/burger/158711-cheese-burger-png-file-hd.png',
      price: 7.99),
  FoodItem(
      id: 4,
      category: 'Pizza',
      name: 'Chicken Pizza',
      imgUrl:
          'https://www.pngkey.com/png/full/70-701336_california-chicken-pizza-butter-chicken-pizza-png.png',
      price: 5.99),
  FoodItem(
      id: 5,
      category: 'Pizza',
      name: 'Margarita Pizza',
      imgUrl:
          'https://static.vecteezy.com/system/resources/previews/022/478/733/original/pizza-margherita-and-beer-ai-transparent-png.png',
      price: 5.99),
  FoodItem(
      id: 6,
      category: 'Pasta',
      name: 'Lazania',
      imgUrl:
          'https://static.vecteezy.com/system/resources/previews/033/544/620/original/lasagna-on-a-plate-isolated-on-transparent-background-ai-generated-png.png',
      price: 3.99),
  FoodItem(
      id: 7,
      category: 'Pasta',
      name: 'Kushari',
      imgUrl:
          'https://static.vecteezy.com/system/resources/previews/036/498/544/original/ai-generated-koshari-on-a-white-plate-on-transparent-background-png.png',
      price: 6.99),
  FoodItem(
      id: 8,
      category: 'Chicken',
      name: 'Fried Chicken',
      imgUrl:
          'https://static.vecteezy.com/system/resources/previews/021/952/558/original/southern-fried-chicken-fried-chicken-transparent-background-png.png',
      price: 7.99),
  FoodItem(
      id: 9,
      category: 'Chicken',
      name: 'Grilled Chicken',
      imgUrl:
          'https://static.vecteezy.com/system/resources/previews/027/141/335/original/tasty-roast-delicious-roasted-grilled-chicken-created-with-generative-ai-png.png',
      price: 9.99),
];

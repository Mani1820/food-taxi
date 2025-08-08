enum OrderStatus { pending, onTheWay, delivered }

class MyOrdersModel {
  final String image;
  final String title;
  final String price;
  final String quantity;
  final OrderStatus status;
  final String hotalName;

  MyOrdersModel({
    required this.image,
    required this.title,
    required this.price,
    required this.quantity,
    required this.status,
    required this.hotalName,
  });
}

final List<MyOrdersModel> dummyOrders = [
  MyOrdersModel(
    image: 'https://wallpapercave.com/wp/wp3724291.jpg',
    title: 'Pepperoni Pizza',
    price: '₹299',
    quantity: '1',
    status: OrderStatus.pending,
    hotalName: 'Pizza Paradise',
  ),
  MyOrdersModel(
    image: 'https://imgmedia.lbb.in/media/2019/08/5d662c8ea84656a7661be92a_1566977166741.jpg',
    title: 'Cheese Burger',
    price: '₹149',
    quantity: '2',
    status: OrderStatus.onTheWay,
    hotalName: 'Burger Haven',
  ),
  MyOrdersModel(
    image: 'https://www.zedamagazine.com/wp-content/uploads/2018/06/Indian-Food-Samosa-Dish-HD-Wallpapers.jpg',
    title: 'Sushi Platter',
    price: '₹499',
    quantity: '1',
    status: OrderStatus.delivered,
    hotalName: 'Tokyo Bites',
  ),
  MyOrdersModel(
    image: 'https://wallpapers.com/images/hd/traditional-thali-platter-indian-food-7ppdmw8bs4n1f36j.jpg',
    title: 'Chicken Fried Rice',
    price: '₹199',
    quantity: '1',
    status: OrderStatus.pending,
    hotalName: 'Rice Bowl',
  ),
  MyOrdersModel(
    image: 'https://wallpaperaccess.com/full/1739009.jpg',
    title: 'Veg Hakka Noodles',
    price: '₹129',
    quantity: '3',
    status: OrderStatus.onTheWay,
    hotalName: 'Dragon Noodles',
  ),
  MyOrdersModel(
    image: 'https://www.tastingtable.com/img/gallery/20-delicious-indian-dishes-you-have-to-try-at-least-once/intro-1645057933.jpg',
    title: 'Hyderabadi Biryani',
    price: '₹249',
    quantity: '2',
    status: OrderStatus.delivered,
    hotalName: 'Biryani House',
  ),
  MyOrdersModel(
    image: 'https://sandinmysuitcase.com/wp-content/uploads/2020/04/Popular-Indian-Cuisine.jpg',
    title: 'Grilled Sandwich',
    price: '₹99',
    quantity: '1',
    status: OrderStatus.pending,
    hotalName: 'Snack Corner',
  ),
  MyOrdersModel(
    image: 'https://sukhis.com/app/uploads/2022/04/image3-4.jpg',
    title: 'Steamed Momos',
    price: '₹89',
    quantity: '2',
    status: OrderStatus.onTheWay,
    hotalName: 'Tibet Treats',
  ),
  MyOrdersModel(
    image: 'https://wallpapercave.com/wp/wp3724333.jpg',
    title: 'White Sauce Pasta',
    price: '₹159',
    quantity: '1',
    status: OrderStatus.delivered,
    hotalName: 'Pasta Point',
  ),
  MyOrdersModel(
    image: 'https://i.pinimg.com/736x/43/67/2b/43672bc5eb853418d767736c724b67ef.jpg',
    title: 'Chocolate Ice Cream',
    price: '₹79',
    quantity: '3',
    status: OrderStatus.delivered,
    hotalName: 'Creamy Delights',
  ),
];

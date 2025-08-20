import 'dart:convert';

class FoodModel {
  final String id;
  final String name;
  final String image;
  final String price;
  final String description;

  FoodModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });
}

final List<FoodModel> dummyFoods = [
  FoodModel(
    id: 'f1',
    name: 'Margherita Pizza',
    image:
        'https://s3-media3.fl.yelpcdn.com/bphoto/asfwiDhjwd7MPu10_h87Og/1000s.jpg',
    price: '250',
    description:
        'Classic delight with 100% real mozzarella cheese and tomato base.',
  ),
  FoodModel(
    id: 'f2',
    name: 'Veg Burger',
    image:
        'https://s3-media3.fl.yelpcdn.com/bphoto/asfwiDhjwd7MPu10_h87Og/1000s.jpg',
    price: '120',
    description: 'Crispy veg patty with lettuce, onion, and special sauce.',
  ),
  FoodModel(
    id: 'f3',
    name: 'Chicken Biryani',
    image:
        'https://www.pixelstalk.net/wp-content/uploads/2016/08/Fresh-hot-delicious-food-wallpaper.jpg',
    price: '180',
    description: 'Aromatic basmati rice cooked with spicy chicken and herbs.',
  ),
  FoodModel(
    id: 'f4',
    name: 'Paneer Tikka',
    image: 'https://wallpaperaccess.com/full/767152.jpg',
    price: '150',
    description:
        'Grilled cottage cheese cubes marinated in spicy Indian masala.',
  ),
  FoodModel(
    id: 'f5',
    name: 'Chocolate Milkshake',
    image:
        'https://www.pixelstalk.net/wp-content/uploads/2016/08/Desktop-Food-HD-Wallpapers-Free-Download.jpg',
    price: '90',
    description:
        'Rich and creamy milkshake made with real chocolate and ice cream.',
  ),
  FoodModel(
    id: 'f6',
    name: 'Masala Dosa',
    image:
        'https://www.foodiesfeed.com/wp-content/uploads/2023/06/burger-with-melted-cheese.jpg',
    price: '100',
    description: 'Crispy South Indian crepe filled with spicy potato filling.',
  ),
  FoodModel(
    id: 'f7',
    name: 'Pasta Alfredo',
    image:
        'https://www.pixelstalk.net/wp-content/uploads/2016/08/Photography-Kebab-Meat-Food-Wallpaper-HD-Desktop-Computer.jpg',
    price: '220',
    description: 'Creamy Alfredo pasta with garlic, parmesan, and herbs.',
  ),
  FoodModel(
    id: 'f8',
    name: 'Samosa',
    image:
        'https://png.pngtree.com/background/20230528/original/pngtree-an-arrangement-of-various-indian-food-picture-image_2778221.jpg',
    price: '30',
    description:
        'Deep-fried pastry filled with spicy mashed potatoes and peas.',
  ),
  FoodModel(
    id: 'f9',
    name: 'Cold Coffee',
    image:
        'https://www.funfoodfrolic.com/wp-content/uploads/2020/09/Cold-Coffee-Thumbnail.jpg',
    price: '70',
    description: 'Chilled coffee drink blended with milk, sugar, and ice.',
  ),
  FoodModel(
    id: 'f10',
    name: 'Butter Chicken',
    image: 'https://wallpapercave.com/wp/wp7845825.jpg',
    price: '260',
    description:
        'Tender chicken cooked in creamy tomato gravy with butter and spices.',
  ),
];


Foodresponse foodresponseFromJson(String str) => Foodresponse.fromJson(json.decode(str));

String foodresponseToJson(Foodresponse data) => json.encode(data.toJson());

class Foodresponse {
    bool status;
    int httpCode;
    String httpMessage;
    String customMessage;
    Data data;
    int responseTime;

    Foodresponse({
        required this.status,
        required this.httpCode,
        required this.httpMessage,
        required this.customMessage,
        required this.data,
        required this.responseTime,
    });

    factory Foodresponse.fromJson(Map<String, dynamic> json) => Foodresponse(
        status: json["status"],
        httpCode: json["httpCode"],
        httpMessage: json["httpMessage"],
        customMessage: json["custom_message"],
        data: Data.fromJson(json["data"]),
        responseTime: json["responseTime"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "httpCode": httpCode,
        "httpMessage": httpMessage,
        "custom_message": customMessage,
        "data": data.toJson(),
        "responseTime": responseTime,
    };
}

class Data {
    List<Food> foods;

    Data({
        required this.foods,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
    };
}

class Food {
    int id;
    String name;
    int price;
    String foodImage;
    int restaurantId;
    String restaurantName;
    String restaurantImage;
    String restaurantAddress;

    Food({
        required this.id,
        required this.name,
        required this.price,
        required this.foodImage,
        required this.restaurantId,
        required this.restaurantName,
        required this.restaurantImage,
        required this.restaurantAddress,
    });

    factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        foodImage: json["food_image"],
        restaurantId: json["restaurant_id"],
        restaurantName: json["restaurant_name"],
        restaurantImage: json["restaurant_image"],
        restaurantAddress: json["restaurant_address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "food_image": foodImage,
        "restaurant_id": restaurantId,
        "restaurant_name": restaurantName,
        "restaurant_image": restaurantImage,
        "restaurant_address": restaurantAddress,
    };
}

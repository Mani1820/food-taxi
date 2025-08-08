class HotalsModel {
  final int uId;
  final String image;
  final String hotalName;
  final String location;
  final String description;
  final String typeOfHotal;
  final String typeOfFood;
  final double rating;

  HotalsModel({
    required this.uId,
    required this.image,
    required this.hotalName,
    required this.location,
    required this.description,
    required this.typeOfHotal,
    required this.typeOfFood,
    required this.rating,
  });
}

final List<HotalsModel> dummyHotals = [
  HotalsModel(
    uId: 1,
    image:
        'https://www.nearbby.me/wp-content/uploads/2016/12/Italian-Restaurant.jpg',
    hotalName: 'Café Aroma',
    location: 'Downtown, Mumbai',
    description: 'A cozy café offering artisan coffee and light snacks.',
    typeOfHotal: 'Cafe',
    typeOfFood: 'Italian',
    rating: 4.2,
  ),
  HotalsModel(
    uId: 2,
    image:
        'https://www.nearbby.me/wp-content/uploads/2016/12/Italian-Restaurant.jpg',
    hotalName: 'Spice Hub',
    location: 'Baner, Pune',
    description: 'Famous for its spicy North Indian dishes and thalis.',
    typeOfHotal: 'Restaurant',
    typeOfFood: 'Indian',
    rating: 4.5,
  ),
  HotalsModel(
    uId: 3,
    image:
        'https://static.designmynight.com/uploads/2019/01/Baluchi-at-The-Great-Hall-restaurant-17-optimised.jpg',
    hotalName: 'Dragon Bites',
    location: 'Banjara Hills, Hyderabad',
    description: 'Authentic Chinese cuisine with a modern twist.',
    typeOfHotal: 'Food Restaurant',
    typeOfFood: 'Chinese',
    rating: 4.0,
  ),
  HotalsModel(
    uId: 4,
    image:
        'https://i.pinimg.com/originals/90/cd/f1/90cdf141c3a04f7ab5f81df28eb549b1.jpg',
    hotalName: 'Tandoori Flames',
    location: 'Connaught Place, Delhi',
    description: 'Best known for grilled kebabs and tandoori specialties.',
    typeOfHotal: 'Restaurant',
    typeOfFood: 'Mughlai',
    rating: 4.7,
  ),
  HotalsModel(
    uId: 5,
    image:
        'https://media.cntraveler.com/photos/5db0cb62ceb13600094a42b5/master/w_4000,h_2670,c_limit/roosterandowl-washingtondc-2019-3.jpg',
    hotalName: 'Noodle Town',
    location: 'Koramangala, Bengaluru',
    description: 'Quick and delicious Asian noodles and street food.',
    typeOfHotal: 'Quick Bite',
    typeOfFood: 'Asian',
    rating: 3.9,
  ),
  HotalsModel(
    uId: 6,
    image:
        'https://mariosbigpizza.com/wp-content/uploads/2022/10/restaurant-2-scaled.jpeg',
    hotalName: 'Burger Bros',
    location: 'Andheri West, Mumbai',
    description: 'Juicy burgers and loaded fries with great combos.',
    typeOfHotal: 'Fast Food',
    typeOfFood: 'American',
    rating: 4.1,
  ),
  HotalsModel(
    uId: 7,
    image:
        'https://a.cdn-hotels.com/gdcs/production41/d17/6850f389-d305-4fd9-81d8-a8cd67aff80c.jpg',
    hotalName: 'Green Leaf',
    location: 'Sector 17, Chandigarh',
    description: 'Pure vegetarian dining with healthy vegan options.',
    typeOfHotal: 'Veg Restaurant',
    typeOfFood: 'Indian',
    rating: 4.3,
  ),
  HotalsModel(
    uId: 8,
    image:
        'https://i.pinimg.com/originals/fa/c8/d6/fac8d6880e9417c99919d64d2830f928.jpg',
    hotalName: 'Sushi Spot',
    location: 'MG Road, Bengaluru',
    description: 'Fresh sushi and Japanese delicacies.',
    typeOfHotal: 'Fine Dining',
    typeOfFood: 'Japanese',
    rating: 4.6,
  ),
  HotalsModel(
    uId: 9,
    image: 'https://i2.ypcdn.com/blob/73bd0c7e984aecc01a364212483f0c31d59d7048',
    hotalName: 'Biryani Express',
    location: 'Charminar, Hyderabad',
    description: 'Authentic Hyderabadi biryani with spicy flavors.',
    typeOfHotal: 'Takeaway',
    typeOfFood: 'Indian',
    rating: 4.4,
  ),
  HotalsModel(
    uId: 10,
    image:
        'https://yoisoweb.com/wp-content/uploads/2017/11/Beautiful-Restaurants-Near-Me-With-Private-Dining-Rooms-58-Best-for-house-design-and-ideas-with-Restaurants-Near-Me-With-Private-Dining-Rooms.jpg',
    hotalName: 'The Wok Place',
    location: 'Park Street, Kolkata',
    description: 'Pan-Asian fusion dishes made fresh in a wok.',
    typeOfHotal: 'Food Court',
    typeOfFood: 'Thai',
    rating: 3.8,
  ),
  HotalsModel(
    uId: 11,
    image:
        'https://www.osteriaromana.com/Osteria-Romana-Norwalk/images/osteria-romana-norwalk-home.jpg',
    hotalName: 'Urban Tadka',
    location: 'Powai, Mumbai',
    description: 'Rustic Punjabi dhaba vibes in an urban setting.',
    typeOfHotal: 'Restaurant',
    typeOfFood: 'Punjabi',
    rating: 4.5,
  ),
  HotalsModel(
    uId: 12,
    image:
        'https://static.giggster.com/images/location/68b37dcc-0fb6-40ae-aee0-5ae162d3670b/2ea9f3cc-b66d-4d0a-bc3a-39253d5c98cf/full_hd_retina.jpeg',
    hotalName: 'Healthy Bowl',
    location: 'Hitech City, Hyderabad',
    description: 'Balanced meals with a focus on nutrition.',
    typeOfHotal: 'Health Café',
    typeOfFood: 'Continental',
    rating: 4.0,
  ),
  HotalsModel(
    uId: 13,
    image:
        'https://static.giggster.com/images/location/68b37dcc-0fb6-40ae-aee0-5ae162d3670b/7d6e9de3-137a-44a8-9638-383775722886/full_hd_retina.jpeg',
    hotalName: 'The Chaat Corner',
    location: 'Lajpat Nagar, Delhi',
    description: 'Street-style chaats, golgappas, and more!',
    typeOfHotal: 'Street Food Stall',
    typeOfFood: 'Indian Street Food',
    rating: 4.2,
  ),
  HotalsModel(
    uId: 14,
    image:
        'https://himenus.com/wp-content/uploads/2023/04/Untitled-design-37.jpg',
    hotalName: 'Pizza Palazzo',
    location: 'Indiranagar, Bengaluru',
    description: 'Wood-fired pizzas with fresh ingredients.',
    typeOfHotal: 'Pizzeria',
    typeOfFood: 'Italian',
    rating: 4.3,
  ),
  HotalsModel(
    uId: 15,
    image: 'https://follywashout.com/images/gallery/12.jpg',
    hotalName: 'Tibet Taste',
    location: 'Majnu Ka Tila, Delhi',
    description: 'Authentic momos and Tibetan cuisine.',
    typeOfHotal: 'Café',
    typeOfFood: 'Tibetan',
    rating: 4.1,
  ),
];

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Product model
class Product {
  final String productName;
  final String ingredientsText;
  final String imageUrl;
  final String sustainabilityInfo;
  final double rating;
  final double price;
  final List<String> categories;

  Product({
    required this.productName,
    required this.ingredientsText,
    required this.imageUrl,
    required this.sustainabilityInfo,
    required this.rating,
    required this.price,
    required this.categories,
  });
}

// JSON parsing function
List<Product> parseProducts(String jsonData) {
  final Map<String, dynamic> jsonMap = json.decode(jsonData);
  final List<dynamic> jsonList = jsonMap['products'];
  return jsonList
      .map((json) => Product(
            productName: json['product_name'],
            ingredientsText: json['ingredients_text'],
            imageUrl: json['image_url'],
            sustainabilityInfo: json['sustainability_info'],
            rating: json['rating'].toDouble(),
            price: json['price'].toDouble(),
            categories: List<String>.from(json['categories']),
          ))
      .toList();
}

// EcoFriendlyProductFinderScreen
class EcoFriendlyProductFinderScreen extends StatelessWidget {
  const EcoFriendlyProductFinderScreen({super.key});

  final String jsonData = '''
{
  "name": "EcoFriendlyProducts",
  "products": [
    {
      "product_name": "Eco-Friendly Toothbrush",
      "ingredients_text": "Bamboo, BPA-free nylon bristles",
      "image_url": "assets/images/eco_toothbrush.jpg",
      "sustainability_info": "Biodegradable and sustainable.",
      "rating": 4.8,
      "price": 5.99,
      "categories": ["Personal Care", "Oral Care"]
    },
    {
      "product_name": "Organic Cotton Tote Bag",
      "ingredients_text": "100% organic cotton",
      "image_url": "assets/images/organic_cotton_tote_bag.jpg",
      "sustainability_info": "Reusable and made from organic materials.",
      "rating": 4.5,
      "price": 10.99,
      "categories": ["Clothing", "Accessories"]
    },
    {
      "product_name": "Stainless Steel Water Bottle",
      "ingredients_text": "Stainless steel, BPA-free plastic",
      "image_url": "assets/images/stainless_steel_water_bottle.jpg",
      "sustainability_info": "Reusable and reduces plastic waste.",
      "rating": 4.9,
      "price": 15.99,
      "categories": ["Personal Care", "Hydration"]
    },
    {
      "product_name": "Compostable Food Wrap",
      "ingredients_text": "Beeswax, organic cotton, jojoba oil",
      "image_url": "assets/images/compostable_food_wrap.jpg",
      "sustainability_info": "Biodegradable alternative to plastic wrap.",
      "rating": 4.7,
      "price": 12.49,
      "categories": ["Kitchen", "Food Storage"]
    },
    {
      "product_name": "Reusable Silicone Food Bags",
      "ingredients_text": "Food-grade silicone",
      "image_url": "assets/images/reusable_silicone_food_bags.jpg",
      "sustainability_info": "Reusable and freezer-safe, replaces single-use plastic bags.",
      "rating": 4.6,
      "price": 9.99,
      "categories": ["Kitchen", "Food Storage"]
    },
    {
      "product_name": "Bamboo Cutlery Set",
      "ingredients_text": "Bamboo",
      "image_url": "assets/images/bamboo_cutlery_set.jpg",
      "sustainability_info": "Reusable and eco-friendly, reduces single-use plastic.",
      "rating": 4.8,
      "price": 8.99,
      "categories": ["Dining", "Personal Care"]
    },
    {
      "product_name": "Eco-Friendly Yoga Mat",
      "ingredients_text": "Natural rubber, cotton",
      "image_url": "assets/images/eco_friendly_yoga_mat.jpg",
      "sustainability_info": "Biodegradable and made from natural materials.",
      "rating": 4.9,
      "price": 29.99,
      "categories": ["Fitness", "Personal Care"]
    },
    {
      "product_name": "Solar-Powered Phone Charger",
      "ingredients_text": "Solar panels, recycled plastic",
      "image_url": "assets/images/solar_powered_phone_charger.jpg",
      "sustainability_info": "Uses renewable energy to charge devices.",
      "rating": 4.4,
      "price": 24.99,
      "categories": ["Technology", "Energy"]
    },
    {
      "product_name": "Biodegradable Cleaning Sponges",
      "ingredients_text": "Natural cellulose, hemp fibers",
      "image_url": "assets/images/biodegradable_leaning_sponges.jpg",
      "sustainability_info": "Compostable and made from natural materials.",
      "rating": 4.7,
      "price": 6.49,
      "categories": ["Cleaning", "Household"]
    },
    {
      "product_name": "Eco-Friendly Laundry Detergent",
      "ingredients_text": "Plant-based ingredients, biodegradable formula",
      "image_url": "assets/images/eco_friendly_laundry_detergent.jpg",
      "sustainability_info": "Safe for the environment and septic systems.",
      "rating": 4.6,
      "price": 11.99,
      "categories": ["Cleaning", "Laundry"]
    },
  {
    "product_name": "Reusable Beeswax Food Wraps",
    "ingredients_text": "Beeswax, organic cotton",
    "image_url": "assets/images/reusable_beeswax_food_wraps.jpg",
    "sustainability_info": "Biodegradable alternative to plastic wraps.",
    "rating": 4.7,
    "price": 12.49,
    "categories": ["Kitchen", "Food Storage"]
  },
  {
    "product_name": "ECO Friendly Coffee Mug",
    "ingredients_text": "Ceramic, bamboo lid",
    "image_url": "assets/images/eco_friendly_coffee_mug.jpg",
    "sustainability_info": "Reusable and reduces disposable cup waste.",
    "rating": 4.8,
    "price": 15.99,
    "categories": ["Kitchen", "Dining"]
  },
  {
    "product_name": "Compostable Dog Waste Bags",
    "ingredients_text": "Plant-based materials",
    "image_url": "assets/images/compostable_dog_waste_bags.jpg",
    "sustainability_info": "Eco-friendly alternative to plastic bags.",
    "rating": 4.5,
    "price": 9.99,
    "categories": ["Pets", "Cleaning"]
  },
  {
    "product_name": "Organic Hemp Soap",
    "ingredients_text": "Organic hemp oil, essential oils",
    "image_url": "assets/images/organic_hemp_soap.jpg",
    "sustainability_info": "Natural, biodegradable soap.",
    "rating": 4.6,
    "price": 7.49,
    "categories": ["Personal Care", "Body Care"]
  },
  {
    "product_name": "Biodegradable Phone Case",
    "ingredients_text": "Plant-based materials",
    "image_url": "assets/images/biodegradable_phone_case.jpg",
    "sustainability_info": "Reduces plastic waste.",
    "rating": 4.4,
    "price": 14.99,
    "categories": ["Technology", "Accessories"]
  },
  {
    "product_name": "Natural Loofah Sponge",
    "ingredients_text": "Loofah plant",
    "image_url": "assets/images/natural_loofah_sponge.jpg",
    "sustainability_info": "Compostable and biodegradable.",
    "rating": 4.3,
    "price": 5.99,
    "categories": ["Cleaning", "Personal Care"]
  },
  {
    "product_name": "ECO Friendly Hair Brush",
    "ingredients_text": "Bamboo, natural bristles",
    "image_url": "assets/images/eco_friendly_hair_brush.jpg",
    "sustainability_info": "Reduces plastic use.",
    "rating": 4.7,
    "price": 10.99,
    "categories": ["Personal Care", "Hair Care"]
  },
  {
    "product_name": "Sustainable Yoga Block",
    "ingredients_text": "Cork, natural rubber",
    "image_url": "assets/images/sustainable_yoga_block.jpg",
    "sustainability_info": "Biodegradable and made from natural materials.",
    "rating": 4.6,
    "price": 15.99,
    "categories": ["Fitness", "Yoga"]
  },
  {
    "product_name": "Reusable Cloth Napkins",
    "ingredients_text": "100% cotton",
    "image_url": "assets/images/reusable_cloth_napkins.jpg",
    "sustainability_info": "Reduces paper waste.",
    "rating": 4.5,
    "price": 8.99,
    "categories": ["Kitchen", "Dining"]
  },
  {
    "product_name": "Eco Friendly Dish Soap",
    "ingredients_text": "Plant-based surfactants",
    "image_url": "assets/images/eco_friendly_dish_soap.jpg",
    "sustainability_info": "Biodegradable and non-toxic.",
    "rating": 4.8,
    "price": 11.49,
    "categories": ["Cleaning", "Kitchen"]
  },
  {
    "product_name": "Recycled Paper Notebooks",
    "ingredients_text": "Recycled paper",
    "image_url": "assets/images/recycled_paper_notebooks.jpg",
    "sustainability_info": "Saves trees and reduces waste.",
    "rating": 4.7,
    "price": 12.99,
    "categories": ["Stationery", "Office Supplies"]
  },
  {
    "product_name": "Solar Powered Garden Lights",
    "ingredients_text": "Solar panels, LED lights",
    "image_url": "assets/images/solar_powered_garden_lights.jpg",
    "sustainability_info": "Uses renewable energy.",
    "rating": 4.4,
    "price": 29.99,
    "categories": ["Garden", "Lighting"]
  },
  {
    "product_name": "Natural Rubber Balloons",
    "ingredients_text": "Natural latex",
    "image_url": "assets/images/natural_rubber_balloons.jpg",
    "sustainability_info": "Biodegradable and compostable.",
    "rating": 4.5,
    "price": 6.99,
    "categories": ["Party Supplies", "Events"]
  },
  {
    "product_name": "Compostable Coffee Pods",
    "ingredients_text": "Plant-based materials",
    "image_url": "assets/images/compostable_coffee_pods.jpg",
    "sustainability_info": "Reduces plastic waste.",
    "rating": 4.7,
    "price": 12.99,
    "categories": ["Kitchen", "Coffee"]
  },
 {
    "product_name": "ECO Friendly Paint",
    "ingredients_text": "Plant-based pigments",
    "image_url": "assets/images/eco_friendly_paint.jpg",
    "sustainability_info": "Non-toxic and low VOC.",
    "rating": 4.8,
    "price": 19.99,
    "categories": ["Home Improvement", "Paint"]
  },
  {
    "product_name": "Biodegradable Glitter",
    "ingredients_text": "Plant-based materials",
    "image_url": "assets/images/biodegradable_glitter.jpg",
    "sustainability_info": "Safe for the environment.",
    "rating": 4.5,
    "price": 9.99,
    "categories": ["Craft Supplies", "Decor"]
  },
  {
    "product_name": "Organic Cotton Baby Clothes",
    "ingredients_text": "100% organic cotton",
    "image_url": "assets/images/organic_cotton_baby_clothes.jpg",
    "sustainability_info": "Non-toxic and eco-friendly.",
    "rating": 4.8,
    "price": 24.99,
    "categories": ["Clothing", "Baby"]
  },
  {
    "product_name": "Natural Insect Repellent",
    "ingredients_text": "Essential oils",
    "image_url": "assets/images/natural_insect_repellent.jpg",
    "sustainability_info": "Non-toxic and biodegradable.",
    "rating": 4.4,
    "price": 10.99,
    "categories": ["Personal Care", "Outdoor"]
  },
  {
    "product_name": "Reusable Snack Bags",
    "ingredients_text": "Food-grade silicone",
    "image_url": "assets/images/reusable_snack_bags.jpg",
    "sustainability_info": "Reduces single-use plastic waste.",
    "rating": 4.6,
    "price": 9.99,
    "categories": ["Kitchen", "Food Storage"]
  },
  {
    "product_name": "ECO Friendly Cleaning Spray",
    "ingredients_text": "Vinegar, essential oils",
    "image_url": "assets/images/eco_friendly_cleaning_spray.jpg",
    "sustainability_info": "Non-toxic and biodegradable.",
    "rating": 4.5,
    "price": 8.49,
    "categories": ["Cleaning", "Household"]
  },
  {
    "product_name": "Bamboo Toilet Paper",
    "ingredients_text": "Bamboo pulp",
    "image_url": "assets/images/bamboo_toilet_paper.jpg",
    "sustainability_info": "Sustainable and biodegradable.",
    "rating": 4.6,
    "price": 15.99,
    "categories": ["Personal Care", "Bath"]
  },
{
    "product_name": "Reusable Coffee Filter",
    "ingredients_text": "Organic cotton",
    "image_url": "assets/images/reusable_coffee_filter.jpg",
    "sustainability_info": "Reduces paper waste.",
    "rating": 4.8,
    "price": 6.99,
    "categories": ["Kitchen", "Coffee"]
},
{
    "product_name": "Natural Fiber Basket",
    "ingredients_text": "Natural fibers",
    "image_url": "assets/images/natural_fiber_basket.jpg",
    "sustainability_info": "Biodegradable and eco-friendly.",
    "rating": 4.5,
    "price": 12.49,
    "categories": ["Home", "Storage"]
  }
    ]
      }
''';

  @override
  Widget build(BuildContext context) {
    final products = parseProducts(jsonData);

    return Scaffold(
      body: Stack(
        children: [
          // Background with Animation
          const AnimatedBackground(),
          // Product List
          ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  leading: Image.asset(product.imageUrl),
                  title: Text(product.productName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ingredients: ${product.ingredientsText}"),
                      Text("Sustainability: ${product.sustainabilityInfo}"),
                      Text("Rating: ${product.rating} ⭐"),
                      Text("\$${product.price.toStringAsFixed(2)}"),
                    ],
                  ),
                  // Adding Animation to the ListTile
                  onTap: () {
                    // You can navigate to a product details page here
                  },
                ).animate().fadeIn(duration: 300.ms),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Animated Background Widget
class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.greenAccent.withOpacity(0.5),
            Colors.blueAccent.withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: const FlutterLogo(size: 100)
            .animate()
            .rotate(duration: 2.seconds)
            .repeat(),
      ),
    );
  }
}

extension on Animate {
  repeat() {}
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/favorite_controller.dart';
import '../model/meal_model.dart';
import '../service/meal_service.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favCtrl = Get.find<FavoriteController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6B35),
        foregroundColor: Colors.white,
        title: const Text(
          'Makanan Favorit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (favCtrl.favorites.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border,
                    size: 72, color: Colors.grey.shade300),
                const SizedBox(height: 16),
                const Text(
                  'Belum ada makanan favorit',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tambahkan dari halaman Home',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: favCtrl.favorites.length,
          itemBuilder: (context, index) {
            final meal = favCtrl.favorites[index];
            return FavoriteCard(meal: meal, favCtrl: favCtrl);
          },
        );
      }),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  final Meal meal;
  final FavoriteController favCtrl;

  const FavoriteCard({super.key, required this.meal, required this.favCtrl});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(meal.idMeal),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 28),
      ),
      onDismissed: (_) => favCtrl.removeFromFavorite(meal),
      child: GestureDetector(
        onTap: () async {
          final fullMeal = await MealService().getMealById(meal.idMeal);
          if (fullMeal != null) {
            Get.toNamed('/detail', arguments: fullMeal);
          }
        },
        child: Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Image.network(
                  meal.strMealThumb,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.strMeal,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.category_outlined,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            meal.strCategory.isNotEmpty
                                ? meal.strCategory
                                : 'Favorit',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => favCtrl.removeFromFavorite(meal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

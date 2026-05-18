import 'package:get/get.dart';
import '../model/meal_model.dart';
import '../service/meal_service.dart';

class MealController extends GetxController {
  final MealService _service = MealService();

  var selectedCategory = 'Beef'.obs;
  var meals = <Meal>[].obs;
  var isLoading = false.obs;

  final List<String> categories = ['Beef', 'Chicken', 'Pork'];

  @override
  void onInit() {
    super.onInit();
    fetchMeals('Beef');
  }

  Future<void> fetchMeals(String category) async {
    isLoading.value = true;
    selectedCategory.value = category;
    meals.value = await _service.getMealsByCategory(category);
    isLoading.value = false;
  }
}

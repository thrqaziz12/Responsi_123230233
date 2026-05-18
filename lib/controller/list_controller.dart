import 'package:get/get.dart';
import '../model/resep_model.dart';
import '../service/api_service.dart';

class ListController extends GetxController {
  final items = <ResepModel>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;
  final errorMsg = ''.obs;

  late String type;
  int _offset = 0;
  static const _limit = 10;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, String>;
    type = args['type']!;
    fetchItems();
  }

  Future<void> fetchItems({bool refresh = false}) async {
    if (refresh) {
      items.clear();
      _offset = 0;
      hasMore.value = true;
      errorMsg.value = '';
    }
    if (!hasMore.value) return;
    items.isEmpty ? isLoading.value = true : isLoadingMore.value = true;
    try {
      final result = await ApiService.fetchList(
        type,
        limit: _limit,
        offset: _offset,
      );
      items.addAll(result);
      _offset += result.length;
      hasMore.value = result.length == _limit;
    } catch (e) {
      errorMsg.value = e.toString();
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }
}

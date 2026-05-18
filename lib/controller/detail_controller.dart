import 'package:get/get.dart';
import '../model/resep_model.dart';
import '../service/api_service.dart';

class DetailController extends GetxController {
  final item = Rxn<ResepModel>();
  final isLoading = true.obs;
  final errorMsg = ''.obs;

  late String type;
  late int id;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    type = args['type'] as String;
    id = args['id'] as int;
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    isLoading.value = true;
    errorMsg.value = '';
    try {
      item.value = await ApiService.fetchDetail(type, id);
    } catch (e) {
      errorMsg.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

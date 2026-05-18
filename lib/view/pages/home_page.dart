import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/list_controller.dart';
import '../../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ListController>();
    final args = Get.arguments as Map<String, String>;
    final title = args['title'] ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(title), leading: const BackButton()),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF4F8EF7)),
          );
        }
        if (ctrl.errorMsg.isNotEmpty && ctrl.items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                  size: 48,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Gagal memuat data',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => ctrl.fetchItems(refresh: true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F8EF7),
                  ),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }
        return RefreshIndicator(
          color: const Color(0xFF4F8EF7),
          onRefresh: () => ctrl.fetchItems(refresh: true),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: ctrl.items.length + (ctrl.hasMore.value ? 1 : 0),
            itemBuilder: (ctx, i) {
              if (i == ctrl.items.length) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => ctrl.fetchItems(),
                );
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF4F8EF7),
                    ),
                  ),
                );
              }
              final item = ctrl.items[i];
              return GestureDetector(
                onTap: () => Get.toNamed(
                  AppRoutes.detail,
                  arguments: {
                    'type': ctrl.type,
                    'id': item.id,
                    'menuTitle': title,
                  },
                ),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF141B2D),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gambar
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(14),
                        ),
                        child: item.strMealThumb.isNotEmpty
                            ? Image.network(
                                item.strMealThumb,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, stack) =>
                                    _imgPlaceholder(),
                                loadingBuilder: (ctx, child, progress) =>
                                    progress == null ? child : _imgLoading(),
                              )
                            : _imgPlaceholder(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.strMeal,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.person_outline,
                                  size: 13,
                                  color: Color(0xFF4F8EF7),
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      size: 12,
                                      color: Colors.white38,
                                    ),
                                    SizedBox(width: 4),
                                  ],
                                ),

                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF4F8EF7,
                                    ).withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 14,
                                    color: Color(0xFF4F8EF7),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _imgPlaceholder() => Container(
    height: 180,
    width: double.infinity,
    color: const Color(0xFF1C2740),
    child: const Icon(
      Icons.image_not_supported_outlined,
      color: Colors.white24,
      size: 48,
    ),
  );

  Widget _imgLoading() => Container(
    height: 180,
    width: double.infinity,
    color: const Color(0xFF1C2740),
    child: const Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Color(0xFF4F8EF7),
      ),
    ),
  );
}

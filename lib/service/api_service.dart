import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/resep_model.dart';

class ApiService {
  static const _base =
      'https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772';

  static Future<List<ResepModel>> fetchList(
    String type, {
    int limit = 10,
    int offset = 0,
  }) async {
    final res = await http.get(
      Uri.parse('$_base/$type/?limit=$limit&offset=$offset'),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return (data['results'] as List)
          .map((e) => ResepModel.fromJson(e))
          .toList();
    }
    throw Exception('Gagal memuat data (${res.statusCode})');
  }

  static Future<ResepModel> fetchDetail(String type, int id) async {
    final res = await http.get(Uri.parse('$_base/$type/$id/'));
    if (res.statusCode == 200) {
      return ResepModel.fromJson(jsonDecode(res.body));
    }
    throw Exception('Gagal memuat detail (${res.statusCode})');
  }
}

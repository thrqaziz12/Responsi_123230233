class ResepModel {
  final int id;
  final String strMeal;
  final String strInstructions;
  final String strMealThumb;
  final String strSource;
  final String strArea;
  final List<String> authors;

  ResepModel({
    required this.id,
    required this.strMeal,
    required this.strInstructions,
    required this.strMealThumb,
    required this.strSource,
    required this.strArea,
    required this.authors,
  });

  factory ResepModel.fromJson(Map<String, dynamic> json) {
    List<String> parseAuthors(dynamic raw) {
      if (raw == null) return [];
      if (raw is List) {
        return raw
            .map((e) {
              if (e is String) return e;
              if (e is Map) return (e['name'] ?? '').toString();
              return '';
            })
            .where((s) => s.isNotEmpty)
            .toList();
      }
      return [];
    }

    return ResepModel(
      id: json['id'] ?? 0,
      strMeal: json['strMeal'] ?? '',
      strInstructions: json['strInstructions'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      strSource: json['strSource'] ?? '',
      strArea: json['strArea'] ?? '',
      authors: parseAuthors(json['authors']),
    );
  }

  String get authorsDisplay =>
      authors.isNotEmpty ? authors.join(', ') : strArea;
}

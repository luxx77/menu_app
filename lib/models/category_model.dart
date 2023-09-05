class CategoryModel {
  final int id;

  final String imgUrl;
  final int? firstChildId;
  final Map<String, String> titles;
  CategoryModel({
    required this.imgUrl,
    required this.titles,
    this.firstChildId,
    required this.id,
  });
  factory CategoryModel.fromMap(Map map) {
    return CategoryModel(
      imgUrl: map['img'] ?? 'nullImage',
      titles: {
        'tm': map['name_tm'],
        'ru': map['name_ru'],
        'en': map['name_en'],
      },
      firstChildId: map['first_child_id'],
      id: map['id'],
    );
  }
  static Map toMap(CategoryModel model) {
    return {
      'id': model.id,
      'titles': model.titles,
      'imgUrl': model.imgUrl,
      'firstChildId': model.firstChildId,
    };
  }

  static List<CategoryModel> fromList(List list) {
    return List.generate(
      list.length,
      (index) => CategoryModel.fromMap(list[index]),
    );
  }
}

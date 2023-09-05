import 'dart:developer';

class ProductModel {
  final int id;
  final Map<String, String> titles;
  final Map<String, String>? descirption;
  final double price;
  final int? cookTime;
  final String imgUrl;
  List<ProductModel>? recs;
  ProductModel({
    required this.titles,
    required this.id,
    required this.imgUrl,
    required this.price,
    this.cookTime,
    this.descirption,
    this.recs,
  });

  factory ProductModel.fromMap(Map map) {
    final bool full = map['ready_time'] != null;
    return ProductModel(
      titles: {
        'tm': map['name_tm'],
        'ru': map['name_ru'],
        'en': map['name_en'],
      },
      id: map['id'],
      imgUrl: map['img'],
      price: map['price'],
      descirption: full
          ? {
              'tm': map['description_tm'],
              'ru': map['description_ru'],
              'en': map['description_en'],
            }
          : null,
      cookTime: full ? map['ready_time'] : null,
    );
  }
  static Map toMap(ProductModel model) {
    return {
      'id': model.id,
      'titles': model.titles,
      'price': model.price,
      'imgUrl': model.imgUrl,
      'desCs': model.descirption,
      'recs': model.recs,
      'cookTime': model.cookTime,
    };
  }

  static List<ProductModel> fromList(List list) {
    return List.generate(
      list.length,
      (index) => ProductModel.fromMap(list[index]),
    );
  }

  static ProductModel toHalfModel(ProductModel model) {
    return ProductModel(
      titles: model.titles,
      id: model.id,
      imgUrl: model.imgUrl,
      price: model.price,
    );
  }
}

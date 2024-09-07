class Article {
  int? id;
  String name;
  int list;
  double? price;
  String? shop;
  String? image;

  Article(this.id, this.name, this.list, this.price, this.image, this.shop);

  Article.fromMap(Map<String, dynamic> map):
      id = map["id"],
      name = map["name"],
      list = map["list"],
      price = map["price"],
      image = map["image"],
      shop = map["shop"];

   Map<String, dynamic> toMap() {
     Map<String, dynamic> map = {
       'name': name,
       'image': image,
       'price': price,
       'shop': shop,
       'list': list
     };
     if (id != null) map['id'] = id;
     return map;
   }
}
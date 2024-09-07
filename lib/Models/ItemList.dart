class ItemList {
  int id;
  String name;

  ItemList(this.id, this.name);

  ItemList.fromMap(Map<String, dynamic> map):
      id = map["id"],
      name = map["name"];
}
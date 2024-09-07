import 'package:flutter/material.dart';
import 'package:mes_envies/Models/ItemList.dart';
import 'package:mes_envies/Views/Pages/ArticleListView.dart';
import 'package:mes_envies/Views/Widgets/AddDialog.dart';
import 'package:mes_envies/Views/Widgets/CustomAppBar.dart';
import 'package:mes_envies/Views/tiles/ItemListTile.dart';
import 'package:mes_envies/services/DatabaseClient.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<ItemList> items = [];

  @override
  void initState() {
    getItemList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleString: "Ma liste de souhaits", buttonTitle: "Ajouter", callback: addItemList),
      backgroundColor: Colors.white,
      body: ListView.separated(
          itemBuilder: ((context, index) {
            final item = items[index];
            print("ID ===> ${item.id}");
            return ItemListTile(
                itemList: item,
                onPressed: onListPressed,
                onDelete: onDeleteItem
            );
          }),
          separatorBuilder: ((context, index) => const Divider()),
          itemCount: items.length
      )
    );
  }

  getItemList() async {
    final fromDb = await DatabaseClient().allItems();
    setState(() {
      items = fromDb;
    });
  }

  addItemList() async {
    await showDialog(context: context, builder: (context) {
      final controller = TextEditingController();
      return AddDialog(
          controller: controller,
          onAdded: (() {
            handleCloseDialog();
            if (controller.text.isEmpty) return;
            DatabaseClient().addItemList(controller.text).then((success) => getItemList());
          }),
          onCancel: handleCloseDialog
      );
    });
  }

  handleCloseDialog() {
    Navigator.pop(context);
    FocusScope.of(context).requestFocus(FocusNode());
  }

  onListPressed(ItemList itemList) {
    final next = ArticleListView(itemList: itemList);
    MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (context) => next);
    Navigator.of(context).push(materialPageRoute);
  }

  onDeleteItem(ItemList itemList) {
    DatabaseClient().removeItem(itemList).then((success) => getItemList());
  }
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mes_envies/Models/Article.dart';
import 'package:mes_envies/Views/Widgets/AddTextField.dart';
import 'package:mes_envies/Views/Widgets/CustomAppBar.dart';
import 'package:mes_envies/services/DatabaseClient.dart';

class AddArticleView extends StatefulWidget {
  int listId;
  AddArticleView({super.key, required this.listId});

  @override
  AddState createState() => AddState();
}

class AddState extends State<AddArticleView> {

  late TextEditingController nameController;
  late TextEditingController shopController;
  late TextEditingController priceController;
  String? imagePath;

  @override
  void initState() {
    nameController = TextEditingController();
    shopController = TextEditingController();
    priceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    shopController.dispose();
    priceController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titleString: "Ajouter un article",
          buttonTitle: "Valider",
          callback: addPressed
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Nouvel Article",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
            Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (imagePath == null)
                  ? const Icon(Icons.camera, size: 128)
                      : Image.file(File(imagePath!)),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (() => takePicture(ImageSource.camera)), icon: const Icon(Icons.camera_alt)),
                      IconButton(onPressed: (() => takePicture(ImageSource.gallery)), icon: const Icon(Icons.photo_library_outlined)),
                    ],
                  ),
                  AddTextfield(hint: "Nom", controller: nameController),
                  AddTextfield(hint: "Prix", controller: priceController, type:  TextInputType.number),
                  AddTextfield(hint: "Magasin", controller: shopController)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  addPressed() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (nameController.text.isEmpty) return;
    Map<String, dynamic> map = {'list': widget.listId};
    map["name"] = nameController.text;
    if (shopController.text.isNotEmpty) map["shop"] = shopController.text;
    double price = double.tryParse(priceController.text) ?? 0.0;
    map["price"] = price;
    if (imagePath != null) map["image"] = imagePath!;
    Article article = Article.fromMap(map);
    DatabaseClient().upsert(article).then((success) => Navigator.pop(context));
  }

  takePicture(ImageSource source) async {
    XFile? xFile = await ImagePicker().pickImage(source: source);
    if (xFile == null) return;
    setState(() {
      imagePath = xFile.path;
    });
  }
}
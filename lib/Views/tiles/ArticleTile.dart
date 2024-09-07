import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mes_envies/Models/Article.dart';

class ArticleTile extends StatelessWidget {
  Article article;
  ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      elevation: 7.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(article.name, style: const TextStyle(fontSize: 25),),
          if (article.image != null) Container(
            padding: const  EdgeInsets.all(5),
              child: Image.file(File(article.image!)),
            ),
          Text("Prix: ${article.price} €"),
          Text("Magasin: ${article.shop}")
        ],
      ),
    );
  }
}
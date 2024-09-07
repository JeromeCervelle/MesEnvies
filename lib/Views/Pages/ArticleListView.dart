import 'package:flutter/material.dart';
import 'package:mes_envies/Models/Article.dart';
import 'package:mes_envies/Models/ItemList.dart';
import 'package:mes_envies/Views/Pages/AddArticleView.dart';
import 'package:mes_envies/Views/Widgets/CustomAppBar.dart';
import 'package:mes_envies/Views/tiles/ArticleTile.dart';
import 'package:mes_envies/services/DatabaseClient.dart';

class ArticleListView extends StatefulWidget {
  ItemList itemList;
  ArticleListView({super.key, required this.itemList});

  @override
  ArticleState createState() => ArticleState();

}

class ArticleState extends State<ArticleListView> {
  List<Article> articles = [];

  @override
  void initState() {
    getArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titleString: widget.itemList.name,
          buttonTitle: "+",
          callback: addNewItem
      ),
      body: ListView.builder(
          itemBuilder: ((context, index) => ArticleTile(article: articles[index])),
          itemCount: articles.length,
      )
    );
  }

  getArticles() async {
    DatabaseClient().articlesFromId(widget.itemList.id).then((articles) {
      setState(() {
        this.articles = articles;
      });
    });
  }

  addNewItem() {
    final next = AddArticleView(listId: widget.itemList.id);
    final route = MaterialPageRoute(builder: ((context) => next));
    Navigator.of(context).push(route).then((value) => getArticles());
  }
}
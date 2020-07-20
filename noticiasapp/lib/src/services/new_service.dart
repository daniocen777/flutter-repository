import 'package:flutter/material.dart';
import 'package:noticiasapp/src/constant/url.dart';
import 'package:noticiasapp/src/models/category_model.dart';
import 'package:noticiasapp/src/models/new_models.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewService() {
    this.getTopHeadlines();
    categories.forEach((item) {
      this.categoryArticles[item.name] = new List();
    });
  }

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String value) {
    this._selectedCategory = value;
    getArticlesByCategory(value);
    notifyListeners();
  }

  getTopHeadlines() async {
    final url = '$URL_NEWS/top-headlines?country=ve&apiKey=$API_KEY';
    print('URL: $url');
    final resp = await http.get(url);
    final news = newFromJson(resp.body);
    this.headlines.addAll(news.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category].length > 0) {
      return this.categoryArticles[category];
    }
    final url =
        '$URL_NEWS/top-headlines?country=ve&apiKey=$API_KEY&category=$category';
    print('URL: $url');
    final resp = await http.get(url);
    final news = newFromJson(resp.body);
    this.categoryArticles[category].addAll(news.articles);
    notifyListeners();
  }
}

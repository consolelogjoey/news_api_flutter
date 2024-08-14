import 'package:aboutme/models/news_model.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  NewsModel? _newsModel;
  NewsModel? get getNewsModel => _newsModel;
  Future saveNewsModel(value) async {
    _newsModel = NewsModel.fromJson(await value);
    notifyListeners();
  }
}

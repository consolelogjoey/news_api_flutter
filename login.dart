// main.dart
import 'package:aboutme/providers/news_provider.dart';
import 'package:aboutme/providers/posts_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'api_service.dart';
import 'weather.dart';

class Newssrceen extends StatefulWidget {
  @override
  _NewssrceenState createState() => _NewssrceenState();
}

class _NewssrceenState extends State<Newssrceen> {
  Future fetchNews() async {
    APIService().fetchNews().then((value) {
      print("👌 : $value");

      if (value['status'] == 'ok') {
        Provider.of<NewsProvider>(context, listen: false)
            .saveNewsModel(value)
            .catchError((onError) {
          print("❌❌ : $onError");
        });
      }
    });
  }

  @override
  void initState() {
    fetchNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NewsProvider newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('News')),
      body: newsProvider.getNewsModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : newsProvider.getNewsModel!.articles!.isEmpty
              ? Center(
                  child: Text('No news articles found'),
                )
              : ListView.builder(
                  itemCount: newsProvider.getNewsModel!.articles!.length,
                  itemBuilder: (context, index) {
                    final article = newsProvider.getNewsModel!.articles![index];
                    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(article.author ?? 'no author'),
                            SizedBox(height: 8.0),
                            Text(
                              article.title ?? 'No Title',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(article.urlToImage!),
                            ),
                            SizedBox(height: 8.0),
                            Text(article.publishedAt ?? 'no date'),
                            SizedBox(height: 8.0),
                            Text(
                              article.content ?? 'no content',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              article.description ?? 'No Description',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

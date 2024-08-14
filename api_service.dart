// api_service.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class APIService {
  late Response response;
  late Dio _dio;
  String baseUrl = "https://newsapi.org";

  APIService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 5000),
    );
    _dio = Dio(options);
  }

  Future fetchNews() async {
    var uri = baseUrl +
        "/v2/everything?q=tesla&from=2024-07-13&sortBy=publishedAt&apiKey=d28101c3e39749b0a963326607ab732e";

    response = await _dio.get(
      uri,
      options: Options(
        headers: {
          "Accept": "application/json",
        },
      ),
    );
    // logger.d(response.data);
    return response.data;
  }
}
// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class APIService {
//   Future<List<dynamic>> getPosts() async {
//     final response =
//         await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load posts');
//     }
//   }
// }

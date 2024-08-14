import 'package:dio/dio.dart';

import 'test_model.dart';

class API {
  static const _url = "https://jsonplaceholder.typicode.com";
  static const _posts = "$_url/posts";
  static const _headers = {"Content-type": "application/json; charset=UTF-8"};
  static final dio = Dio();

  static Future<List<TestModel>> get listPost async {
    var response = await dio.get(_posts);
    final json = response.data;
    List<TestModel> obj = [];
    if (json != null) {
      obj = <TestModel>[];
      json.forEach((v) {
        obj.add(TestModel.fromJson(v));
      });
    }
    return obj;
  }

  static Future<TestModel> getPost(int id) async {
    var response = await dio.get("$_posts/$id");
    final json = response.data;
    final obj = TestModel.fromJson(json);
    return obj;
  }

  static Future<TestModel> postPost({required TestModel data}) async {
    var response = await dio.post(
      _posts,
      data: data.toJson(),
      options: Options(headers: _headers),
    );
    final json = response.data;
    final obj = TestModel.fromJson(json);
    return obj;
  }

  static Future<TestModel> updatePost(int id, {required TestModel data}) async {
    var response = await dio.put(
      '$_posts/$id',
      data: data.toJson(),
      options: Options(headers: _headers),
    );
    final json = response.data;
    final obj = TestModel.fromJson(json);
    return obj;
  }

  static Future<dynamic> deletePost(int id) async {
    var response = await dio.delete(
      '$_posts/$id',
      options: Options(headers: _headers),
    );
    final json = response.data;
    return json;
  }
}

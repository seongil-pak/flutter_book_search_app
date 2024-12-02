import 'dart:convert';

import 'package:flutter_book_search_app/data/model/book.dart';
import 'package:http/http.dart';

class BookRepogitory {
  Future<List<Book>> SearchBooks(String query) async {
    //
    final client = Client();
    final response = await client.get(
      Uri.parse('https://openapi.naver.com/v1/search/book.json?query=$query'),
      headers: {
        'X-Naver-Client-Id': 'GJEHxjqLwWgLWjBg977a',
        'X-Naver-Client-Secret': 'shS4oWnkBg',
      },
    );
    //Get 요청시 성공 => 200
    //응답코드가 200일때 !
    //body데이터를 jsonDecode 함수를 사용해서 map 으로 바꾼 후 List<Book>으로 반환
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      final items = List.from(map['items']);
      final iterable = items.map((e) {
        return Book.fromJson(e);
      });

      final list = iterable.toList();
      return list;
    }
    // 아닐때 빈 리스트로 반환
    return [];
  }
}

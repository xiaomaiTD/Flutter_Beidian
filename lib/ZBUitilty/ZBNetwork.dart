import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
class ZBNetwork {
  
    static Future<dynamic> sendRequestGet(url) async {

      Response response;
      response = await Dio().get(url);
      return response.data;

      // String loadRUL = url;
      // http.Response response = await http.get(loadRUL);
      // Utf8Decoder decode = Utf8Decoder();
      // var result = jsonDecode(decode.convert(response.bodyBytes));
      // return result;
    }
    
    static Future<dynamic> sendRequestPost(url) async {
      String loadRUL = url;
      http.Response response = await http.post(loadRUL);
       Utf8Decoder decode = Utf8Decoder();
      var result = jsonDecode(decode.convert(response.bodyBytes));
      return result;
    }

}
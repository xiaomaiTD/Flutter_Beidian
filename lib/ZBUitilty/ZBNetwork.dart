import 'dart:convert';
import 'package:http/http.dart' as http;
class ZBNetwork {
  
    static dynamic sendRequestGet(url,type) async {
      String loadRUL = url;
      http.Response response = await http.get(loadRUL);
      var result = json.decode(response.body);
      return result;
    }

    static dynamic sendRequestPost(url,type) async {
      String loadRUL = url;
      http.Response response = await http.post(loadRUL);
      var result = json.decode(response.body);
      return result;
    }

}
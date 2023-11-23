import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as httpclient;
import 'package:wallcono_project/api_exception.dart';

class ApiHelper {
  String base_url = "https://api.pexels.com/v1/";

  Future<dynamic> getApi(String url, {Map<String, String>? headers}) async {
    var apikey = "KbRKTV6Up44rGKLJOLjbt1pPBNYBIcWydiKt6Dym1iTRnLPZDtwLOzgg";
    var myUrl = "$base_url/curated?per_page=80";
    try {
      var res = await httpclient
          .get(Uri.parse(myUrl), headers: headers ?? {"Authorization": apikey});
      print(res.statusCode);
         return checkResponse(res);
      //exception handle karne ke liye try on socketException use karna//
    } on SocketException {
      print('Internet Error');
      throw FetchhDataException("no internet Connection");
    }
  }

  void postApi() {}

  dynamic checkResponse(httpclient.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw FetchhDataException(
            'Error occurred while Communication with Server with StatusCode :${response.statusCode}');
    }
  }
}

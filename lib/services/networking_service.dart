import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkingService {
  late Map<String, String> headers;

  NetworkingService() {
    headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };
  }

  static String get _apiUrl {
    return 'https://jsonplaceholder.typicode.com/';
  }

  Future<dynamic> get(String url) async {
    final response = await http.get(Uri.parse(_apiUrl + url), headers: headers);

    print("MAX__ response - ${response.statusCode}");

    return _response(response);
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 404:
        var responseJson = json.decode(response.body.toString());
        throw EndpointNotFoundException(responseJson.toString());
      case 422:
        var responseJson = json.decode(response.body.toString());
        throw UnprocessableEntityException(responseJson.toString());
      default:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
    }
  }
}

class AppException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class EndpointNotFoundException extends AppException {
  EndpointNotFoundException([message]) : super(message, "Not Found: ");
}

class UnprocessableEntityException extends AppException {
  UnprocessableEntityException([String? message])
      : super(message, "Unprocessable Entity: ");
}

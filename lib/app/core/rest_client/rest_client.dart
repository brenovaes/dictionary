import 'package:get/get.dart';

class RestClient extends GetConnect {
  /* final _backendBaseUrl = 'https://gateway.marvel.com/v1/public';

  RestClient() {
    httpClient.baseUrl = _backendBaseUrl;
    httpClient.defaultContentType = "application/json";
  } */
}

class RestClientException implements Exception {
  final int? code;
  final String message;

  RestClientException(
    this.message, {
    this.code,
  });

  @override
  String toString() => 'RestClientException(code: $code, message: $message)';
}

class ResponseModel {
  //bool status;
  int statusCode;
  String message;
  dynamic body;

  ResponseModel({
    //required this.status,
    required this.statusCode,
    required this.message,
    this.body,
  });

  @override
  String toString() {
    return 'ResponseModel(statusCode: $statusCode, message: $message, body: $body)';
  }
}

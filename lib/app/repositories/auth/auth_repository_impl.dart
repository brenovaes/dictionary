import 'package:dictionary/app/core/rest_client/rest_client.dart';
import 'package:dictionary/app/models/user_model.dart';
import 'package:dictionary/app/models/response_model.dart';
import 'package:dictionary/app/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RestClient _restClient;

  AuthRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<ResponseModel?> attemptSignup(User user) async {
    try {
      final result = await _restClient.put(
        'https://dictionary-coodesh.herokuapp.com/auth/signup',
        user.toJson(),
      );

      final response = ResponseModel(
        statusCode: result.statusCode!.toInt(),
        message: result.statusText.toString(),
      );
      response.body = result.body;
      return response;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<ResponseModel?> attemptSignin(User user) async {
    try {
      final result = await _restClient.post(
        'https://dictionary-coodesh.herokuapp.com/auth/signin',
        user.toJson(),
      );

      final response = ResponseModel(
        statusCode: result.statusCode!.toInt(),
        message: result.statusText.toString(),
      );
      response.body = result.body;
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

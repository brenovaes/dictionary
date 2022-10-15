import 'package:dictionary/app/models/response_model.dart';
import 'package:dictionary/app/models/user_model.dart';

abstract class AuthRepository {
  Future<ResponseModel?> attemptSignup(User user);
  Future<ResponseModel?> attemptSignin(User user);
}

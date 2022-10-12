import 'package:dictionary/app/core/rest_client/rest_client.dart';
import 'package:dictionary/app/repositories/words/words_repository.dart';

class WordsRepositoryImpl implements WordsRepository {
  final RestClient _restClient;

  WordsRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future getAllWords() async {
    final result = await _restClient.get(
      'https://raw.githubusercontent.com/meetDeveloper/freeDictionaryAPI/master/meta/wordList/english.txt',
    );
    return result.body.toString().split('\n')[200];
  }
}

import 'package:numbertrivia/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the last cached [NumberTriviaModel] which we got last time
  /// the user had proper internet connection.
  ///
  /// Throws [CacheException] if no cached data is present
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// Cache the [NumberTriviaModel]
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModel);
}
import 'package:dartz/dartz.dart';
import 'package:numbertrivia/core/error/failures.dart';

import '../entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  /// Function used to get a particular number trivia.
  /// Either is FP from dartz package, it will either give Failure or NumberTrivia
  /// as response. This will improve error handling and ensure that random errors
  /// are not thrown around.
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);

  /// Future to get a random number trivia, either returns an error or
  /// NumberTrivia
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}

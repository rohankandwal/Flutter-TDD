import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

// Usecase to get the trivia for a user-entered specific number from the server
// or show an error. This usecase will return the date by calling
// getConcreteNumberTrivia() from the NumberTriviaRepository
class GetConcreteNumberTrivia {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia({@required this.repository});

  // Function to get the success or failure response from the server
  Future<Either<Failure, NumberTrivia>> execute({@required int number}) async {
    return await repository.getConcreteNumberTrivia(number);
  }
}

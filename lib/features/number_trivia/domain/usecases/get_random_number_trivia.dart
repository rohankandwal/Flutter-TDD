import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/core/usecase/usecase.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

// Usecase to get the trivia for a random number from the server
// or show an error. This usecase will return the data by calling
// getRandomNumberTrivia() from the NumberTriviaRepository
class GetRandomTriviaRepository implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomTriviaRepository({@required this.repository});

  // Function to get the success or failure response from the server
  // call keyword makes this function to be called directly from the object of
  // this class. eg - obj(23). We can also do the same with obj.call(23)
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams param) async {
    return await repository.getRandomNumberTrivia();
  }
}

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/core/usecase/usecase.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

// Usecase to get the trivia for a user-entered specific number from the server
// or show an error. This usecase will return the date by calling
// getConcreteNumberTrivia() from the NumberTriviaRepository
class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia({@required this.repository});

  // Function to get the success or failure response from the server
  // call keyword makes this function to be called directly from the object of
  // this class. eg - obj(23). We can also do the same with obj.call(23)
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params {
  final int number;

  Params({@required this.number});
}

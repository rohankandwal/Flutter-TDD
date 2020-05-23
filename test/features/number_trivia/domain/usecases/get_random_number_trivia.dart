import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numbertrivia/core/usecase/usecase.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:numbertrivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomTriviaRepository usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomTriviaRepository(repository: mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: tNumber, text: "test");

  test(
    'should get random trivia from the repository',
        () async {
      // arrange
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((realInvocation) async => Right(tNumberTrivia));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tNumberTrivia));
      // Added to ensure that we return the same number that we passed,
      // in case someone hard coded the number, this test will fail and we
      // know that something is wrong.
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      // This verifies that nothing else happens after this test, in case
      // there is a hidden flow
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}

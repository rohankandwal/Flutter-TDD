import 'package:flutter_test/flutter_test.dart';
import 'package:numbertrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';

void main() {
  final numberTriviaModel = NumberTriviaModel(number: 1, text: 'Test text');

  test('Should be a subclass of NumberTrivia Entity', () async {
    expect(numberTriviaModel, isA<NumberTrivia>());
  });
}

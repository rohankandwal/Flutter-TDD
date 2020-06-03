part of '../bloc/number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  final List propList;

  NumberTriviaEvent(this.propList);

  @override
  // TODO: implement props
  List<Object> get props => propList;
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaForConcreteNumber(this.numberString):super([numberString]);
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {
  GetTriviaForRandomNumber() : super([]);
}

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Contains the entity from https://numbersapi.com/43?json
class NumberTrivia extends Equatable {
  final String text;
  final int number;

  NumberTrivia({@required this.text, @required this.number});

  @override
  List<Object> get props => [text, number];
}

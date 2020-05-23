import 'package:dartz/dartz.dart';
import 'package:numbertrivia/core/error/failures.dart';

// Abstract class to ensure that for each usecase, we are using the call function
// to execute. This will ensure that all the programmers are using the same
// naming for the function. call keyword means that we can call obj() instead of
// obj.call()

// Param here isn't used, but can be used for passing the parameters for some
// kind of debugging, otherwise we won't know what type of data was passed.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params param); /*{
    print(param)
}*/
}
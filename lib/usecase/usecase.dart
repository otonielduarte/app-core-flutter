import 'package:core/helpers/mapper.dart';
import 'package:core/usecase/errors/failures.dart';

abstract class Usecase<Output, Input> {
  Future<Mapper<Failure, Output>> call(Input params);
}

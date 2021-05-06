import 'package:core/helpers/mapper.dart';
import 'package:core/usecase/errors/failures.dart';
import 'package:equatable/equatable.dart';

abstract class Usecase<Output, Input> {
  Future<Mapper<Failure, Output>> call(Input params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

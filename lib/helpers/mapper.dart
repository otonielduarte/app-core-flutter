import 'package:equatable/equatable.dart';

abstract class Mapper<L, R> extends Equatable {
  @override
  List<Object?> get props => [];
}

class Left<L, R> extends Mapper<L, R> {
  final L _l;
  Left(this._l);
  L get value => _l;

  @override
  List<Object?> get props => [_l];
}

class Right<L, R> extends Mapper<L, R> {
  final R _r;
  Right(this._r);
  R get value => _r;

  @override
  List<Object?> get props => [_r];
}

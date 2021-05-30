import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String code;
  final String message;

  const Failure({
    this.code = "",
    this.message = "",
  });

  @override
  bool get stringify =>
      true; // this will printout all the different props of instances

  @override
  List<Object> get props => [code, message];
}

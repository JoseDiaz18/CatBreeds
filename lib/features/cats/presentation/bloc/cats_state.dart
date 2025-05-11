part of 'cats_bloc.dart';

abstract class CatsState extends Equatable {
  const CatsState();  

  @override
  List<Object> get props => [];
}
class CatsInitial extends CatsState {}

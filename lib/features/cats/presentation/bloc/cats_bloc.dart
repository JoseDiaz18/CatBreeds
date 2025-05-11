import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cats_event.dart';
part 'cats_state.dart';

class CatsBloc extends Bloc<CatsEvent, CatsState> {
  CatsBloc() : super(CatsInitial()) {
    on<CatsEvent>((event, emit) {});
  }
}

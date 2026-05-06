import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'scheme_event.dart';
part 'scheme_state.dart';

class SchemeBloc extends Bloc<SchemeEvent, SchemeState> {
  SchemeBloc() : super(SchemeInitial()) {
    on<SchemeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

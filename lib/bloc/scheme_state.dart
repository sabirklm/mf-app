part of 'scheme_bloc.dart';

sealed class SchemeState extends Equatable {
  const SchemeState();
  
  @override
  List<Object> get props => [];
}

final class SchemeInitial extends SchemeState {}

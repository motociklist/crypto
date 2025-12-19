part of 'about_me_bloc.dart';

abstract class AboutMeState extends Equatable {
  const AboutMeState();

  @override
  List<Object?> get props => [];
}

class AboutMeInitial extends AboutMeState {}

class AboutMeLoading extends AboutMeState {}

class AboutMeLoaded extends AboutMeState {
  final String user;

  const AboutMeLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class AboutMeError extends AboutMeState {
  final String message;

  const AboutMeError(this.message);

  @override
  List<Object?> get props => [message];
}

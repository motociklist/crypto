part of 'about_me_bloc.dart';

abstract class AboutMeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMe extends AboutMeEvent {
  LoadMe({required this.user});

  final String user;

  @override
  List<Object?> get props => [user];
}

class LoadMeEnd extends AboutMeEvent {
  LoadMeEnd();
}


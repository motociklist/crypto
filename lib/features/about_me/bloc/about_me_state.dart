part of 'about_me_bloc.dart';

abstract class AboutMeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AboutMeInitial extends AboutMeState {
  AboutMeInitial() {
    print('State: AboutMeInitial');
  }
}

class AboutMeLoading extends AboutMeState {
  AboutMeLoading() {
    print('State: AboutMeLoading');
  }
}

class AboutMeLoaded extends AboutMeState {
  final String user;

  AboutMeLoaded(this.user) {
    print('State: AboutMeLoaded2, user: $user');
  }

  @override
  List<Object?> get props => [user];
}

class AboutMeError extends AboutMeState {
  final String message;

  AboutMeError(this.message) {
    print('State: AboutMeError, message: $message');
  }

  @override
  List<Object?> get props => [message];
}

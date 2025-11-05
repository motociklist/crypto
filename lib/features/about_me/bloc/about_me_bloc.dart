import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'about_me_event.dart';
part 'about_me_state.dart';

class AboutMeBloc extends Bloc<AboutMeEvent, AboutMeState> {
  AboutMeBloc() : super(AboutMeInitial()) {
    on<LoadMe>((event, emit) {
      print('LoadMe called with user: ${event.user}');
      emit(AboutMeError('ggg'));
    });
    on<LoadMeEnd>((event, emit) {
      print('LoadMeEnd called22222222222222222222222222');
      // Здесь можно изменить состояние, если нужно
       emit(AboutMeLoading());
    });
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'about_me_event.dart';
part 'about_me_state.dart';

class AboutMeBloc extends Bloc<AboutMeEvent, AboutMeState> {
  AboutMeBloc() : super(AboutMeInitial()) {
    on<LoadMe>((event, emit) {
      emit(const AboutMeError('ggg'));
    });
    on<LoadMeEnd>((event, emit) {
      emit(AboutMeLoading());
    });
  }
}

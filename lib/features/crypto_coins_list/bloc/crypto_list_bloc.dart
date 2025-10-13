import 'package:flutter_bloc/flutter_bloc.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';



class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc() : super (CryptoListInitial()) {

    on<CryptoListEvent>((event,emit) {

    });

  }
}
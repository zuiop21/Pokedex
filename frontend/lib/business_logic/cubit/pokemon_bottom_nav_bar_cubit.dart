import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pokemon_bottom_nav_bar_state.dart';

class PokemonBottomNavBarCubit extends Cubit<PokemonBottomNavBarState> {
  PokemonBottomNavBarCubit() : super(PokemonBottomNavBarInitial());

//TODO use the already written cubit (landing_page)
  void nextPage(int page) {
    emit(PokemonBottomNavBarState(page: page));
  }
}

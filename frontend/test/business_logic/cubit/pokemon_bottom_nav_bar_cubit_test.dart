import 'package:bloc_test/bloc_test.dart';
import 'package:frontend/business_logic/cubit/pokemon_bottom_nav_bar_cubit.dart';

void main() {
  blocTest<PokemonBottomNavBarCubit, PokemonBottomNavBarState>(
    'emits [updated] when moving to next page',
    build: () => PokemonBottomNavBarCubit(),
    act: (PokemonBottomNavBarCubit cubit) => cubit.nextPage(1),
    expect: () => [
      const PokemonBottomNavBarState(page: 1),
    ],
  );
}

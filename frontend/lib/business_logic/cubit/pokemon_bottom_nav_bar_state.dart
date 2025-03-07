part of 'pokemon_bottom_nav_bar_cubit.dart';

class PokemonBottomNavBarState extends Equatable {
  final int page;

  const PokemonBottomNavBarState({required this.page});
  @override
  List<Object?> get props => [page];
}

final class PokemonBottomNavBarInitial extends PokemonBottomNavBarState {
  const PokemonBottomNavBarInitial() : super(page: 0);
}

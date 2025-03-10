import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/models/pokemon.dart';
import 'package:frontend/data/repositories/pokemon_repository.dart';
import 'package:frontend/data/models/type.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _pokemonRepository;
  PokemonBloc(this._pokemonRepository) : super(PokemonState()) {
    on<GetPokemonEvent>(_getAllPokemons);
  }

  Future<void> _getAllPokemons(
      GetPokemonEvent event, Emitter<PokemonState> emit) async {
    emit(state.copyWith(status: PokemonStatus.loading));
    try {
      final pokemons = await _pokemonRepository.getAllPokemons();
      emit(state.copyWith(status: PokemonStatus.success, pokemons: pokemons));
    } catch (e) {
      emit(state.copyWith(status: PokemonStatus.failure, error: e.toString()));
    }
  }
}

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/models/processed/evolution.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/processed/region.dart';
import 'package:frontend/data/models/processed/user.dart';
import 'package:frontend/data/repositories/admin_repository.dart';
import 'package:frontend/data/models/processed/type.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository _adminRepository;
  AdminBloc(this._adminRepository) : super(const AdminState()) {
    on<GetAllUsersEvent>(_getAllUsers);
    on<UpdateUserByIdEvent>(_updateUserById);
    on<StartUpdatingTypeEvent>(_startUpdatingType);
    on<CancelTypeEvent>(_cancelType);
    on<CreateTypeEvent>(_createType);
    on<UpdateTypeVisuallyEvent>(_updateTypeVisually);
    on<UpdateTypeByIdEvent>(_updateType);
    on<DeleteTypeByIdEvent>(_deleteType);
    on<StartCreatingTypeEvent>(_startCreatingType);
    on<StartPokemonCreationEvent>(_startPokemonCreation);
    on<EditPokemonNameEvent>(_editPokemonName);
    on<EditPokemonAbilityEvent>(_editPokemonAbility);
    on<EditPokemonCategoryEvent>(_editPokemonCategory);
    on<EditPokemonDescriptionEvent>(_editPokemonDescription);
    on<EditPokemonHeightEvent>(_editPokemonHeight);
    on<EditPokemonWeightEvent>(_editPokemonWeight);
    on<EditPokemonGenderEvent>(_editPokemonGender);
    on<StartAddingPokemonStrengthTypeEvent>(_startAddingPokemonStrengthType);
    on<AddPokemonStrengthTypeEvent>(_addPokemonStrengthType);
    on<CancelPokemonEvent>(_cancelPokemonEvent);
    on<StartAddingPokemonWeaknessTypeEvent>(_startAddingPokemonWeaknessType);
    on<AddPokemonWeaknessTypeEvent>(_addPokemonWeaknessType);
    on<CancelActionEvent>(_cancelAction);
    on<PopPokemonEvent>(_popPokemon);
    on<AddPokemonImageEvent>(_addPokemonImage);
    on<CreatePokemonEvent>(_createPokemon);
    on<DeletePokemonByIdEvent>(_deletePokemon);
    on<StartCreatingRegionEvent>(_startCreatingRegion);
    on<CancelRegionEvent>(_cancelRegion);
    on<StartUpdatingRegionEvent>(_startUpdatingRegion);
    on<AddRegionImageEvent>(_addRegionImage);
    on<CreateRegionEvent>(_createRegion);
    on<EditRegionEvent>(_editRegion);
    on<DeleteRegionByIdEvent>(_deleteRegion);
    on<UpdateRegionByIdEvent>(_updateRegion);
    on<AddTypeImageEvent>(_addTypeImage);
    on<AddTypeImageOutlineEvent>(_addTypeImageOutline);
    on<StartAddingPokemonRegionEvent>(_startAddingPokemonRegion);
    on<AddPokemonRegionEvent>(_addPokemonRegion);
  }

  void _addPokemonRegion(
      AddPokemonRegionEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> currentPokemons = List.from(state.newPokemons);

    final updatedPokemons = currentPokemons.asMap().entries.map((entry) {
      final index = entry.key;
      final pokemon = entry.value;

      if (index == state.currentIndex) {
        return pokemon.copyWith(regionId: event.region.id);
      }
      return pokemon;
    }).toList();

    emit(state.copyWith(
      status: AdminStatus.added,
      newPokemons: updatedPokemons,
    ));
  }

  void _startAddingPokemonRegion(
      StartAddingPokemonRegionEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(
      status: AdminStatus.adding,
    ));
  }

  void _addTypeImageOutline(
      AddTypeImageOutlineEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(
      status: AdminStatus.success,
      placeholderFileOutline: () => event.image,
    ));
  }

  void _addTypeImage(AddTypeImageEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(
      status: AdminStatus.success,
      placeholderFile: () => event.image,
    ));
  }

  Future<void> _updateRegion(
      UpdateRegionByIdEvent event, Emitter<AdminState> emit) async {
    emit(state.copyWith(status: AdminStatus.loading));
    try {
      final updatedRegion = await _adminRepository.updateRegionById(
          event.token, state.placeholderRegion!);
      emit(state.copyWith(
          status: AdminStatus.updated, placeholderRegion: () => updatedRegion));
    } catch (e) {
      emit(state.copyWith(
        status: AdminStatus.failure,
        error: () => e.toString(),
      ));
    }
  }

  void _deleteRegion(
      DeleteRegionByIdEvent event, Emitter<AdminState> emit) async {
    emit(state.copyWith(status: AdminStatus.loading));
    try {
      await _adminRepository.deleteRegionById(event.token, event.region.id);
      emit(state.copyWith(
          status: AdminStatus.popped, placeholderRegion: () => event.region));
    } catch (e) {
      emit(state.copyWith(
        status: AdminStatus.failure,
        error: () => e.toString(),
      ));
    }
  }

  void _editRegion(EditRegionEvent event, Emitter<AdminState> emit) {
    final Region region = state.placeholderRegion!;

    final updatedRegion = region.copyWith(
      name: event.name != null ? event.name! : region.name,
      difficulty: event.difficulty != null
          ? event.difficulty!.toInt()
          : region.difficulty,
    );

    emit(state.copyWith(placeholderRegion: () => updatedRegion));
  }

  Future<void> _createRegion(
      CreateRegionEvent event, Emitter<AdminState> emit) async {
    emit(state.copyWith(status: AdminStatus.loading));
    try {
      final newRegion = await _adminRepository.uploadRegion(
          event.token, state.placeholderFile!, state.placeholderRegion!);

      emit(state.copyWith(
          status: AdminStatus.created,
          placeholderRegion: () => newRegion,
          placeholderFile: () => null));
    } catch (e) {
      emit(state.copyWith(
        status: AdminStatus.failure,
        error: () => e.toString(),
      ));
    }
  }

  void _addRegionImage(AddRegionImageEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(
        status: AdminStatus.success, placeholderFile: () => event.image));
  }

  void _startUpdatingRegion(
      StartUpdatingRegionEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(
      status: AdminStatus.updating,
      placeholderRegion: () => event.region,
    ));
  }

  void _cancelRegion(CancelRegionEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(
        status: AdminStatus.success, placeholderFile: () => null));
  }

  void _startCreatingRegion(
      StartCreatingRegionEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(
      status: AdminStatus.creating,
      placeholderRegion: () => const Region(
        id: 0,
        name: "",
        imgUrl: "",
        difficulty: 0,
      ),
    ));
  }

  Future<void> _deletePokemon(
      DeletePokemonByIdEvent event, Emitter<AdminState> emit) async {
    emit(state.copyWith(status: AdminStatus.loading));
    try {
      await _adminRepository.deletePokemonById(event.token, event.pokemon.id);
      emit(state.copyWith(
          status: AdminStatus.deleted, deletedPokemon: () => event.pokemon));
    } catch (e) {
      emit(state.copyWith(
        status: AdminStatus.failure,
        error: () => e.toString(),
      ));
    }
  }

  int? _joinPokemonWithEvolution(Pokemon pokemon, List<Evolution> evolutions) {
    return evolutions
        .firstWhereOrNull((e) => e.pokemonId == pokemon.id)
        ?.evolvesToId;
  }

  Future<void> _createPokemon(
      CreatePokemonEvent event, Emitter<AdminState> emit) async {
    emit(state.copyWith(status: AdminStatus.loading));
    try {
      List<Pokemon> createdPokemons = [];

      //Create pokemons in database
      for (int i = 0; i < state.newPokemons.length; i++) {
        final uploaded = await _adminRepository.uploadPokemon(
          event.token,
          state.images[i],
          state.newPokemons[i],
        );
        createdPokemons.add(uploaded);
      }

      //Create evolutions in database

      List<Evolution> createdEvolutions = [];

      for (int i = 0; i < state.newEvolutions.length; i++) {
        final evolutions = state.newEvolutions;

        final updatedEvolution = evolutions[i].copyWith(
            pokemonId: createdPokemons[i].id,
            evolvesToId: () => i == state.newEvolutions.length - 1
                ? null
                : createdPokemons[i + 1].id);

        final uploaded = await _adminRepository.createEvolution(
          event.token,
          updatedEvolution,
        );

        createdEvolutions.add(uploaded);
      }

      final pokemonsWithEvo = [
        for (var pokemon in createdPokemons)
          pokemon.copyWith(
            evolvesTo: () => createdPokemons.firstWhereOrNull(
              (p) =>
                  p.id == _joinPokemonWithEvolution(pokemon, createdEvolutions),
            ),
          )
      ];

      emit(state.copyWith(
          status: AdminStatus.created,
          newPokemons: pokemonsWithEvo,
          newEvolutions: createdEvolutions,
          images: [File("")]));
    } catch (e) {
      emit(state.copyWith(
        status: AdminStatus.failure,
        error: () => e.toString(),
      ));
    }
  }

  void _addPokemonImage(AddPokemonImageEvent event, Emitter<AdminState> emit) {
    final List<File> updatedImages = List.from(state.images);
    final newPath = event.image.path;

    updatedImages[state.currentIndex] = File(newPath);

    emit(state.copyWith(status: AdminStatus.success, images: updatedImages));
  }

  void _popPokemon(PopPokemonEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(
      status: AdminStatus.popped,
      newPokemons: state.newPokemons.sublist(0, state.newPokemons.length - 1),
      newEvolutions:
          state.newEvolutions.sublist(0, state.newEvolutions.length - 1),
      images: state.images.sublist(0, state.images.length - 1),
    ));
  }

  void _cancelAction(CancelActionEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(currentIndex: 0));
  }

  void _startAddingPokemonWeaknessType(
      StartAddingPokemonWeaknessTypeEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(
      status: AdminStatus.creating,
    ));
  }

  void _addPokemonWeaknessType(
      AddPokemonWeaknessTypeEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);
    final newType = event.type.copyWith(isWeakness: WeaknessStatus.yes);

    final List<Type> updatedTypes =
        List.from(updatedPokemons[state.currentIndex].types);
    updatedTypes.add(newType);

    updatedPokemons[state.currentIndex] =
        updatedPokemons[state.currentIndex].copyWith(
      types: updatedTypes,
    );

    emit(state.copyWith(
        status: AdminStatus.updated, newPokemons: updatedPokemons));
  }

  void _cancelPokemonEvent(CancelPokemonEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(
      status: AdminStatus.success,
    ));
  }

  void _startAddingPokemonStrengthType(
      StartAddingPokemonStrengthTypeEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(
      status: AdminStatus.updating,
    ));
  }

  void _addPokemonStrengthType(
      AddPokemonStrengthTypeEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);
    final newType = event.type.copyWith(isWeakness: WeaknessStatus.no);

    final List<Type> updatedTypes =
        List.from(updatedPokemons[state.currentIndex].types);
    updatedTypes.add(newType);

    updatedPokemons[state.currentIndex] =
        updatedPokemons[state.currentIndex].copyWith(
      types: updatedTypes,
    );

    emit(state.copyWith(
        status: AdminStatus.updated, newPokemons: updatedPokemons));
  }

  void _editPokemonGender(
      EditPokemonGenderEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);

    updatedPokemons[state.currentIndex] =
        updatedPokemons[state.currentIndex].copyWith(
      gender: event.gender,
    );

    emit(state.copyWith(
        status: AdminStatus.success, newPokemons: updatedPokemons));
  }

  void _editPokemonWeight(
      EditPokemonWeightEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);

    updatedPokemons[state.currentIndex] =
        updatedPokemons[state.currentIndex].copyWith(
      weight: event.weight,
    );

    emit(state.copyWith(
        status: AdminStatus.success, newPokemons: updatedPokemons));
  }

  void _editPokemonHeight(
      EditPokemonHeightEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);

    updatedPokemons[state.currentIndex] =
        updatedPokemons[state.currentIndex].copyWith(
      height: event.height,
    );

    emit(state.copyWith(
        status: AdminStatus.success, newPokemons: updatedPokemons));
  }

  void _editPokemonDescription(
      EditPokemonDescriptionEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);

    updatedPokemons[state.currentIndex] =
        updatedPokemons[state.currentIndex].copyWith(
      description: event.description,
    );

    emit(state.copyWith(
        status: AdminStatus.success, newPokemons: updatedPokemons));
  }

  void _editPokemonCategory(
      EditPokemonCategoryEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);

    updatedPokemons[state.currentIndex] =
        updatedPokemons[state.currentIndex].copyWith(
      category: event.category,
    );

    emit(state.copyWith(
        status: AdminStatus.success, newPokemons: updatedPokemons));
  }

  void _editPokemonAbility(
      EditPokemonAbilityEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);

    updatedPokemons[state.currentIndex] =
        updatedPokemons[state.currentIndex].copyWith(
      ability: event.ability,
    );

    emit(state.copyWith(
        status: AdminStatus.success, newPokemons: updatedPokemons));
  }

  void _editPokemonName(EditPokemonNameEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);

    updatedPokemons[state.currentIndex] =
        updatedPokemons[state.currentIndex].copyWith(
      name: event.name,
    );

    emit(state.copyWith(
        status: AdminStatus.success, newPokemons: updatedPokemons));
  }

  void _startPokemonCreation(
      StartPokemonCreationEvent event, Emitter<AdminState> emit) {
    final Pokemon newPokemon = Pokemon(
        id: 0,
        level: 0,
        gender: 0,
        height: 0,
        weight: 0,
        name: "",
        ability: "",
        category: "",
        description: "",
        isBaseForm: event.index == 0 ? true : false,
        imgUrl: "",
        isFavourited: false,
        regionId: -1,
        types: const []);

    final File newFile = File("");
    final Evolution newEvolution = const Evolution(
      id: 0,
      pokemonId: 0,
      evolvesToId: null,
      condition: "DASD",
    );

    final updatedPokemons =
        event.index == 0 ? [newPokemon] : [...state.newPokemons, newPokemon];

    final updatedImages =
        event.index == 0 ? [newFile] : [...state.images, newFile];

    final updatedEvolutions = event.index == 0
        ? [newEvolution]
        : [...state.newEvolutions, newEvolution];

    emit(state.copyWith(
        status: AdminStatus.initial,
        newPokemons: updatedPokemons,
        newEvolutions: updatedEvolutions,
        images: updatedImages,
        currentIndex: event.index));
  }

  void _startCreatingType(
      StartCreatingTypeEvent event, Emitter<AdminState> emit) {
    emit(
      state.copyWith(
        status: AdminStatus.creating,
        placeholderType: () => const Type(
            id: 0,
            name: "",
            color: "0x00000000",
            isWeakness: WeaknessStatus.both,
            imgUrl: "",
            imgUrlOutline: ""),
      ),
    );
  }

  Future<void> _createType(
      CreateTypeEvent event, Emitter<AdminState> emit) async {
    emit(state.copyWith(status: AdminStatus.loading));
    try {
      final newType = await _adminRepository.createType(
          event.token,
          state.placeholderFile!,
          state.placeholderFileOutline!,
          event.name,
          state.placeholderType!.color);
      emit(state.copyWith(
          status: AdminStatus.created, placeholderType: () => newType));
    } catch (e) {
      emit(state.copyWith(
        status: AdminStatus.failure,
        error: () => e.toString(),
      ));
    }
  }

  Future<void> _deleteType(
      DeleteTypeByIdEvent event, Emitter<AdminState> emit) async {
    emit(state.copyWith(status: AdminStatus.loading));

    try {
      await _adminRepository.deleteTypeById(event.token, event.type.id);
      emit(state.copyWith(
          status: AdminStatus.popped, deletedType: () => event.type));
    } catch (e) {
      emit(state.copyWith(
        status: AdminStatus.failure,
        error: () => e.toString(),
      ));
    }
  }

  Future<void> _updateType(
      UpdateTypeByIdEvent event, Emitter<AdminState> emit) async {
    emit(state.copyWith(status: AdminStatus.loading));

    try {
      final updatedType = await _adminRepository.updateTypeById(
          event.token, state.placeholderType!.id, event.name,
          color: state.placeholderType!.color);
      emit(state.copyWith(
          status: AdminStatus.updated, placeholderType: () => updatedType));
    } catch (e) {
      emit(state.copyWith(
        status: AdminStatus.failure,
        error: () => e.toString(),
      ));
    }
  }

  void _updateTypeVisually(
      UpdateTypeVisuallyEvent event, Emitter<AdminState> emit) {
    final Type type = state.placeholderType!;

    final color = Color(int.parse(type.color)); // Convert string to Color

    final newColor = Color.fromRGBO(
      (event.newR ?? color.r) * 255 ~/ 1, // Convert 0-1 to 0-255 and ensure int
      (event.newG ?? color.g) * 255 ~/ 1,
      (event.newB ?? color.b) * 255 ~/ 1,
      1, // Full opacity
    );

    final newColorHex = newColor.value
        .toRadixString(16)
        .padLeft(8, '0')
        .toUpperCase(); // Ensure 8-character hex

    emit(state.copyWith(
      placeholderType: () => type.copyWith(
        color: "0x$newColorHex", // Store as ARGB hex string
      ),
    ));
  }

  void _cancelType(CancelTypeEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(
        status: AdminStatus.success,
        placeholderFile: () => null,
        placeholderFileOutline: () => null));
  }

  void _startUpdatingType(
      StartUpdatingTypeEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(
        status: AdminStatus.updating, placeholderType: () => event.type));
  }

  Future<void> _getAllUsers(
      GetAllUsersEvent event, Emitter<AdminState> emit) async {
    emit(state.copyWith(status: AdminStatus.loading));
    try {
      final users = await _adminRepository.getAllUsers(event.token);
      emit(state.copyWith(status: AdminStatus.success, users: users));
    } catch (e) {
      emit(state.copyWith(
          status: AdminStatus.failure, error: () => e.toString()));
    }
  }

  Future<void> _updateUserById(
      UpdateUserByIdEvent event, Emitter<AdminState> emit) async {
    emit(state.copyWith(status: AdminStatus.loading));
    try {
      final updatedUser = await _adminRepository.updateUserById(
        event.token,
        event.userId,
        role: event.role,
        isLocked: event.isLocked,
      );

      final updatedUsers = state.users.map((user) {
        return user.id == updatedUser.id ? updatedUser : user;
      }).toList();

      emit(state.copyWith(status: AdminStatus.success, users: updatedUsers));
    } catch (e) {
      emit(state.copyWith(
        status: AdminStatus.failure,
        error: () => e.toString(),
      ));
    }
  }
}

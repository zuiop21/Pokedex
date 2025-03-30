import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/models/processed/pokemon.dart';
import 'package:frontend/data/models/processed/user.dart';
import 'package:frontend/data/repositories/admin_repository.dart';
import 'package:frontend/data/models/processed/type.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository _adminRepository;
  AdminBloc(this._adminRepository) : super(AdminState()) {
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
    on<StopAddingPokemonTypeEvent>(_stopAddingPokemonType);
    on<StartAddingPokemonWeaknessTypeEvent>(_startAddingPokemonWeaknessType);
    on<AddPokemonWeaknessTypeEvent>(_addPokemonWeaknessType);
    on<CancelActionEvent>(_cancelAction);
    on<PopPokemonEvent>(_popPokemon);
  }

  void _popPokemon(PopPokemonEvent event, Emitter<AdminState> emit) {
    emit(state.copyWith(
      status: AdminStatus.deleted,
      newPokemons: state.newPokemons.sublist(0, state.newPokemons.length - 1),
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
        List.from(updatedPokemons[event.index].types);
    updatedTypes.add(newType);

    updatedPokemons[event.index] = updatedPokemons[event.index].copyWith(
      types: updatedTypes,
    );

    emit(state.copyWith(
        status: AdminStatus.created, newPokemons: updatedPokemons));
  }

  void _stopAddingPokemonType(
      StopAddingPokemonTypeEvent event, Emitter<AdminState> emit) {
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
        List.from(updatedPokemons[event.index].types);
    updatedTypes.add(newType);

    updatedPokemons[event.index] = updatedPokemons[event.index].copyWith(
      types: updatedTypes,
    );

    emit(state.copyWith(
        status: AdminStatus.updated, newPokemons: updatedPokemons));
  }

  void _editPokemonGender(
      EditPokemonGenderEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);

    updatedPokemons[event.index] = updatedPokemons[event.index].copyWith(
      gender: event.gender,
    );

    emit(state.copyWith(newPokemons: updatedPokemons));
  }

  void _editPokemonWeight(
      EditPokemonWeightEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);

    updatedPokemons[event.index] = updatedPokemons[event.index].copyWith(
      weight: event.weight,
    );

    emit(state.copyWith(newPokemons: updatedPokemons));
  }

  void _editPokemonHeight(
      EditPokemonHeightEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);

    updatedPokemons[event.index] = updatedPokemons[event.index].copyWith(
      height: event.height,
    );

    emit(state.copyWith(newPokemons: updatedPokemons));
  }

  void _editPokemonDescription(
      EditPokemonDescriptionEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);

    updatedPokemons[event.index] = updatedPokemons[event.index].copyWith(
      description: event.description,
    );

    emit(state.copyWith(newPokemons: updatedPokemons));
  }

  void _editPokemonCategory(
      EditPokemonCategoryEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);

    updatedPokemons[event.index] = updatedPokemons[event.index].copyWith(
      category: event.category,
    );

    emit(state.copyWith(newPokemons: updatedPokemons));
  }

  void _editPokemonAbility(
      EditPokemonAbilityEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);

    updatedPokemons[event.index] = updatedPokemons[event.index].copyWith(
      ability: event.ability,
    );

    emit(state.copyWith(newPokemons: updatedPokemons));
  }

  void _editPokemonName(EditPokemonNameEvent event, Emitter<AdminState> emit) {
    final List<Pokemon> updatedPokemons = List.from(state.newPokemons);

    updatedPokemons[event.index] = updatedPokemons[event.index].copyWith(
      name: event.name,
    );

    emit(state.copyWith(newPokemons: updatedPokemons));
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
        isBaseForm: true,
        imgUrl: "",
        isFavourited: false,
        regionId: 0,
        types: const []);

    final updatedPokemons =
        event.index == 0 ? [newPokemon] : [...state.newPokemons, newPokemon];

    emit(state.copyWith(
        status: AdminStatus.initial,
        newPokemons: updatedPokemons,
        currentIndex: event.index));
  }

  void _startCreatingType(
      StartCreatingTypeEvent event, Emitter<AdminState> emit) {
    emit(
      state.copyWith(
        status: AdminStatus.creating,
        placeholderType: () => Type(
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
          event.token, event.name, state.placeholderType!.color);
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
          status: AdminStatus.deleted, deletedType: () => event.type));
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
    emit(state.copyWith(status: AdminStatus.success));
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

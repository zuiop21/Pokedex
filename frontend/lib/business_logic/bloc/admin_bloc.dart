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
    on<CancelEvent>(_cancel);
    on<CreateTypeEvent>(_createType);
    on<UpdateTypeVisuallyEvent>(_updateTypeVisually);
    on<UpdateTypeByIdEvent>(_updateType);
    on<DeleteTypeByIdEvent>(_deleteType);
    on<StartCreatingTypeEvent>(_startCreatingType);
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

  void _cancel(CancelEvent event, Emitter<AdminState> emit) {
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

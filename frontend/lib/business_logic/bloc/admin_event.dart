part of 'admin_bloc.dart';

sealed class AdminEvent extends Equatable {}

final class GetAllUsersEvent extends AdminEvent {
  GetAllUsersEvent({required this.token});
  final String token;
  @override
  List<Object?> get props => [token];
}

final class UpdateUserByIdEvent extends AdminEvent {
  UpdateUserByIdEvent(
      {required this.token, required this.userId, this.isLocked, this.role});

  final String token;
  final int userId;
  final bool? isLocked;
  final String? role;

  @override
  List<Object?> get props => [token, userId, role, isLocked];
}

final class StartUpdatingTypeEvent extends AdminEvent {
  StartUpdatingTypeEvent({required this.type});
  final Type type;
  @override
  List<Object?> get props => [type];
}

final class CancelTypeEvent extends AdminEvent {
  @override
  List<Object?> get props => [];
}

final class UpdateTypeVisuallyEvent extends AdminEvent {
  UpdateTypeVisuallyEvent({this.newR, this.newG, this.newB});
  final double? newR;
  final double? newG;
  final double? newB;

  @override
  List<Object?> get props => [newR, newG, newB];
}

final class UpdateTypeByIdEvent extends AdminEvent {
  UpdateTypeByIdEvent({required this.token, required this.name});

  final String token;
  final String name;
  @override
  List<Object?> get props => [token, name];
}

final class DeleteTypeByIdEvent extends AdminEvent {
  DeleteTypeByIdEvent({required this.type, required this.token});
  final String token;
  final Type type;
  @override
  List<Object?> get props => [token, type];
}

final class CreateTypeEvent extends AdminEvent {
  CreateTypeEvent({
    required this.token,
    required this.name,
  });
  final String token;
  final String name;
  @override
  List<Object?> get props => [
        token,
        name,
      ];
}

final class StartCreatingTypeEvent extends AdminEvent {
  StartCreatingTypeEvent();
  @override
  List<Object?> get props => [];
}

final class StartPokemonCreationEvent extends AdminEvent {
  StartPokemonCreationEvent({required this.index});
  final int index;
  @override
  List<Object?> get props => [index];
}

final class EditPokemonNameEvent extends AdminEvent {
  EditPokemonNameEvent({required this.name, required this.index});

  final String name;
  final int index;
  @override
  List<Object?> get props => [name, index];
}

final class EditPokemonWeightEvent extends AdminEvent {
  EditPokemonWeightEvent({required this.weight, required this.index});

  final double weight;
  final int index;
  @override
  List<Object?> get props => [weight, index];
}

final class EditPokemonHeightEvent extends AdminEvent {
  EditPokemonHeightEvent({required this.height, required this.index});

  final double height;
  final int index;
  @override
  List<Object?> get props => [height, index];
}

final class EditPokemonAbilityEvent extends AdminEvent {
  EditPokemonAbilityEvent({required this.ability, required this.index});

  final String ability;
  final int index;
  @override
  List<Object?> get props => [ability, index];
}

final class EditPokemonCategoryEvent extends AdminEvent {
  EditPokemonCategoryEvent({required this.category, required this.index});

  final String category;
  final int index;
  @override
  List<Object?> get props => [category, index];
}

final class EditPokemonDescriptionEvent extends AdminEvent {
  EditPokemonDescriptionEvent({required this.description, required this.index});

  final String description;
  final int index;
  @override
  List<Object?> get props => [description, index];
}

final class EditPokemonGenderEvent extends AdminEvent {
  EditPokemonGenderEvent({required this.gender, required this.index});
  final double gender;
  final int index;
  @override
  List<Object?> get props => [gender, index];
}

final class StartAddingPokemonStrengthTypeEvent extends AdminEvent {
  StartAddingPokemonStrengthTypeEvent();
  @override
  List<Object?> get props => [];
}

final class StartAddingPokemonWeaknessTypeEvent extends AdminEvent {
  StartAddingPokemonWeaknessTypeEvent();
  @override
  List<Object?> get props => [];
}

final class StopAddingPokemonTypeEvent extends AdminEvent {
  StopAddingPokemonTypeEvent();
  @override
  List<Object?> get props => [];
}

final class AddPokemonStrengthTypeEvent extends AdminEvent {
  AddPokemonStrengthTypeEvent({required this.index, required this.type});

  final int index;
  final Type type;
  @override
  List<Object?> get props => [index, type];
}

final class AddPokemonWeaknessTypeEvent extends AdminEvent {
  AddPokemonWeaknessTypeEvent({required this.index, required this.type});

  final int index;
  final Type type;
  @override
  List<Object?> get props => [index, type];
}

final class CancelActionEvent extends AdminEvent {
  @override
  List<Object?> get props => [];
}

final class PopPokemonEvent extends AdminEvent {
  @override
  List<Object?> get props => [];
}

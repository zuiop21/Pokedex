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
  EditPokemonNameEvent({
    required this.name,
  });

  final String name;

  @override
  List<Object?> get props => [
        name,
      ];
}

final class EditPokemonWeightEvent extends AdminEvent {
  EditPokemonWeightEvent({required this.weight});

  final double weight;

  @override
  List<Object?> get props => [
        weight,
      ];
}

final class EditPokemonHeightEvent extends AdminEvent {
  EditPokemonHeightEvent({
    required this.height,
  });

  final double height;

  @override
  List<Object?> get props => [
        height,
      ];
}

final class EditPokemonAbilityEvent extends AdminEvent {
  EditPokemonAbilityEvent({required this.ability});

  final String ability;

  @override
  List<Object?> get props => [
        ability,
      ];
}

final class EditPokemonCategoryEvent extends AdminEvent {
  EditPokemonCategoryEvent({required this.category});

  final String category;

  @override
  List<Object?> get props => [category];
}

final class EditPokemonDescriptionEvent extends AdminEvent {
  EditPokemonDescriptionEvent({
    required this.description,
  });

  final String description;

  @override
  List<Object?> get props => [
        description,
      ];
}

final class EditPokemonGenderEvent extends AdminEvent {
  EditPokemonGenderEvent({required this.gender});
  final double gender;

  @override
  List<Object?> get props => [gender];
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

final class CancelPokemonEvent extends AdminEvent {
  CancelPokemonEvent();
  @override
  List<Object?> get props => [];
}

final class AddPokemonStrengthTypeEvent extends AdminEvent {
  AddPokemonStrengthTypeEvent({required this.type});

  final Type type;
  @override
  List<Object?> get props => [type];
}

final class AddPokemonWeaknessTypeEvent extends AdminEvent {
  AddPokemonWeaknessTypeEvent({required this.type});

  final Type type;
  @override
  List<Object?> get props => [type];
}

final class CancelActionEvent extends AdminEvent {
  @override
  List<Object?> get props => [];
}

final class PopPokemonEvent extends AdminEvent {
  @override
  List<Object?> get props => [];
}

final class AddPokemonImageEvent extends AdminEvent {
  AddPokemonImageEvent({required this.image});
  final File image;
  @override
  List<Object?> get props => [image];
}

final class CreatePokemonEvent extends AdminEvent {
  CreatePokemonEvent({required this.token});
  final String token;
  @override
  List<Object?> get props => [token];
}

final class DeletePokemonByIdEvent extends AdminEvent {
  DeletePokemonByIdEvent({required this.pokemon, required this.token});
  final Pokemon pokemon;
  final String token;
  @override
  List<Object?> get props => [pokemon, token];
}

final class StartCreatingRegionEvent extends AdminEvent {
  StartCreatingRegionEvent();
  @override
  List<Object?> get props => [];
}

final class StartUpdatingRegionEvent extends AdminEvent {
  StartUpdatingRegionEvent({required this.region});
  final Region region;
  @override
  List<Object?> get props => [region];
}

final class CancelRegionEvent extends AdminEvent {
  @override
  List<Object?> get props => [];
}

final class AddRegionImageEvent extends AdminEvent {
  AddRegionImageEvent({required this.image});
  final File image;
  @override
  List<Object?> get props => [image];
}

final class CreateRegionEvent extends AdminEvent {
  CreateRegionEvent({
    required this.token,
  });

  final String token;

  @override
  List<Object?> get props => [token];
}

final class EditRegionEvent extends AdminEvent {
  EditRegionEvent({this.name, this.difficulty});

  final String? name;
  final double? difficulty;
  @override
  List<Object?> get props => [
        name,
        difficulty,
      ];
}

final class DeleteRegionByIdEvent extends AdminEvent {
  DeleteRegionByIdEvent({required this.region, required this.token});
  final Region region;
  final String token;
  @override
  List<Object?> get props => [region, token];
}

final class UpdateRegionByIdEvent extends AdminEvent {
  UpdateRegionByIdEvent({required this.token, required this.region});
  final String token;
  final Region region;
  @override
  List<Object?> get props => [token, region];
}

final class AddTypeImageEvent extends AdminEvent {
  AddTypeImageEvent({required this.image});
  final File image;
  @override
  List<Object?> get props => [image];
}

final class AddTypeImageOutlineEvent extends AdminEvent {
  AddTypeImageOutlineEvent({required this.image});
  final File image;
  @override
  List<Object?> get props => [image];
}

final class StartAddingPokemonRegionEvent extends AdminEvent {
  StartAddingPokemonRegionEvent();
  @override
  List<Object?> get props => [];
}

final class AddPokemonRegionEvent extends AdminEvent {
  AddPokemonRegionEvent({required this.region});
  final Region region;
  @override
  List<Object?> get props => [region];
}

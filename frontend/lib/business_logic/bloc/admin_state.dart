part of 'admin_bloc.dart';

enum AdminStatus {
  initial,
  loading,
  success,
  failure,
  creating,
  created,
  adding,
  added,
  updating,
  deleted,
  updated,
  popped,
}

extension AdminStatusX on AdminStatus {
  bool get isInitial => this == AdminStatus.initial;
  bool get isLoading => this == AdminStatus.loading;
  bool get isSuccess => this == AdminStatus.success;
  bool get isFailure => this == AdminStatus.failure;
  bool get isCreating => this == AdminStatus.creating;
  bool get isCreated => this == AdminStatus.created;
  bool get isUpdating => this == AdminStatus.updating;
  bool get isUpdated => this == AdminStatus.updated;
  bool get isPopped => this == AdminStatus.popped;
  bool get isAdding => this == AdminStatus.adding;
  bool get isAdded => this == AdminStatus.added;
  bool get isDeleted => this == AdminStatus.deleted;
}

final class AdminState extends Equatable {
  const AdminState(
      {this.status = AdminStatus.initial,
      this.users = const [],
      this.placeholderType,
      this.placeholderRegion,
      this.error,
      this.placeholderFile,
      this.placeholderFileOutline,
      this.deletedType,
      this.deletedPokemon,
      this.currentIndex = 0,
      this.newPokemons = const [],
      this.newEvolutions = const [],
      this.images = const []});

  final Type? placeholderType;
  final Region? placeholderRegion;
  final File? placeholderFile;
  final File? placeholderFileOutline;
  final AdminStatus status;
  final String? error;
  final List<User> users;
  final Type? deletedType;
  final Pokemon? deletedPokemon;
  final List<Pokemon> newPokemons;
  final List<Evolution> newEvolutions;
  final int currentIndex;
  final List<File> images;

  AdminState copyWith(
      {ValueGetter<Type?>? placeholderType,
      ValueGetter<Region?>? placeholderRegion,
      ValueGetter<File?>? placeholderFile,
      ValueGetter<File?>? placeholderFileOutline,
      AdminStatus? status,
      ValueGetter<String?>? error,
      List<User>? users,
      ValueGetter<Type?>? deletedType,
      ValueGetter<Pokemon?>? deletedPokemon,
      List<Pokemon>? newPokemons,
      List<Evolution>? newEvolutions,
      int? currentIndex,
      List<File>? images}) {
    return AdminState(
        placeholderType:
            placeholderType != null ? placeholderType() : this.placeholderType,
        placeholderRegion: placeholderRegion != null
            ? placeholderRegion()
            : this.placeholderRegion,
        placeholderFile:
            placeholderFile != null ? placeholderFile() : this.placeholderFile,
        placeholderFileOutline: placeholderFileOutline != null
            ? placeholderFileOutline()
            : this.placeholderFileOutline,
        status: status ?? this.status,
        error: error != null ? error() : this.error,
        users: users ?? this.users,
        deletedType: deletedType != null ? deletedType() : this.deletedType,
        deletedPokemon:
            deletedPokemon != null ? deletedPokemon() : this.deletedPokemon,
        newPokemons: newPokemons ?? this.newPokemons,
        newEvolutions: newEvolutions ?? this.newEvolutions,
        currentIndex: currentIndex ?? this.currentIndex,
        images: images ?? this.images);
  }

  @override
  List<Object?> get props => [
        status,
        users,
        error,
        placeholderType,
        placeholderRegion,
        placeholderFile?.path ?? "",
        placeholderFileOutline?.path ?? "",
        deletedType,
        deletedPokemon,
        newEvolutions,
        newPokemons,
        currentIndex,
        images.map((file) => file.path).toList(),
      ];
}

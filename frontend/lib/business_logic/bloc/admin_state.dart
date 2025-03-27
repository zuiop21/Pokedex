part of 'admin_bloc.dart';

enum AdminStatus {
  initial,
  loading,
  success,
  failure,
  creating,
  created,
  updating,
  updated,
  deleted
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
  bool get isDeleted => this == AdminStatus.deleted;
}

final class AdminState extends Equatable {
  const AdminState(
      {this.status = AdminStatus.initial,
      this.users = const [],
      this.placeholderType,
      this.error,
      this.deletedType});

  final Type? placeholderType;
  final AdminStatus status;
  final String? error;
  final List<User> users;
  final Type? deletedType;

  AdminState copyWith(
      {ValueGetter<Type?>? placeholderType,
      AdminStatus? status,
      ValueGetter<String?>? error,
      List<User>? users,
      ValueGetter<Type?>? deletedType}) {
    return AdminState(
        placeholderType:
            placeholderType != null ? placeholderType() : this.placeholderType,
        status: status ?? this.status,
        error: error != null ? error() : this.error,
        users: users ?? this.users,
        deletedType: deletedType != null ? deletedType() : this.deletedType);
  }

  @override
  List<Object?> get props =>
      [status, users, error, placeholderType, deletedType];
}

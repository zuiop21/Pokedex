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

final class CancelEvent extends AdminEvent {
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

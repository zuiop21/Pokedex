import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'password_visibility_state.dart';

class PasswordVisibilityCubit extends Cubit<PasswordVisibilityState> {
  PasswordVisibilityCubit() : super(PasswordVisibilityInitial());

  //Method to toggle the visibility of the password textfield
  void toggleVisibility() {
    emit(PasswordVisibilityState(isVisible: !state.isVisible));
  }
}

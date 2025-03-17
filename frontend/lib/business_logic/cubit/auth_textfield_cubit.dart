import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_textfield_state.dart';

class AuthTextfieldCubit extends Cubit<AuthTextfieldState> {
  AuthTextfieldCubit() : super(AuthTextfieldInitial());

//Method to validate the form
//Optional parameter for the second textfield (if there is a second one)
  void validateForm(String textField1, [String? textField2]) {
    emit(AuthTextfieldState(
        textFieldCondition:
            textField1.isNotEmpty && (textField2?.isNotEmpty ?? true)));
  }
}

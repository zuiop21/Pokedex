import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'landing_page_state.dart';

class LandingPageCubit extends Cubit<LandingPageState> {
  LandingPageCubit() : super(LandingPageInitial());

  void nextPage(int page) {
    emit(LandingPageState(page: page));
  }
}

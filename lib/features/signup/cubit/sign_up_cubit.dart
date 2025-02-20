import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  void validateForm(String fullName, String phoneNumber, String email,
      String password, String country, String card) {
    if (fullName.isEmpty ||
        phoneNumber.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        country.isEmpty ||
        card.isEmpty) {
      emit(SignUpInvalid());
    } else {
      emit(SignUpValid());
    }
  }

  void loading() {
    emit(SignUpLoading());
    Future.delayed(const Duration(seconds: 2), () {
      emit(SignUpLoaded());
    });
  }
}

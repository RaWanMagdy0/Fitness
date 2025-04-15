import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_result.dart';
import '../../../../core/base/base_view_model.dart';
import '../../../../data/models/sign_up/request/sign_up_request_body.dart';
import '../../../../domain/use_case/auth/sign_up_use_case.dart';
part 'sign_up_state.dart';

@injectable
class SignUpCubit extends BaseViewModel<SignUpState> {
  final formKey = GlobalKey<FormState>();
  final SignupUseCase _signUpUseCase;
  SignUpCubit(this._signUpUseCase) : super(SignUpInitial());
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  void signUp(SignupRequestBody signupRequestBody) async {
    emit(SignUpLoading());
    final response = await _signUpUseCase.invoke(signupRequestBody);
    switch (response) {
      case Success<String?>():
        emit(SignUpSuccess(response.data));
      case Fail<String?>():
        emit(
          SignUpFail(getErrorMassageFromException(response.exception)),
        );
    }
  }
}

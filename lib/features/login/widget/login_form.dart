import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/form_validation.dart';
import 'package:flutter_task/core/widgets/custom_button.dart';
import 'package:flutter_task/core/widgets/custom_feild.dart';
import 'package:flutter_task/core/widgets/form_title.dart';
import 'package:flutter_task/core/widgets/loading_widget.dart';
import 'package:flutter_task/features/login/login_model_view.dart';
import 'package:flutter_task/features/login/model/token_model.dart';
import 'package:flutter_task/features/login/widget/create_account_text.dart';

// ignore: must_be_immutable
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final loginViewModel = LoginViewModel();

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final FocusNode _userNameFocus = FocusNode();

  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    passwordController.dispose();
    _userNameFocus.dispose();
    _passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FormTitle(
              title: "user_name",
            ),
            CustomField(
                filled: true,
                focusNode: _userNameFocus,
                nextFocus: _passwordFocus,
                hint: "user_name".tr(),
                controller: userNameController,
                validator: FormValidation.userNameFormValidation),
            SizedBox(
              height: AppSize.h20,
            ),
            const FormTitle(
              title: "password",
            ),
            BlocBuilder<GenericCubit<bool>, GenericCubitState<bool>>(
              bloc: loginViewModel.passwordSecureCubit,
              builder: (context, passwordState) {
                return buildPasswordTXTField(passwordState,
                    loginViewModel: loginViewModel,
                    passwordController: passwordController,
                    passwordFocusNode: _passwordFocus);
              },
            ),
            SizedBox(
              height: AppSize.h26,
            ),
            BlocBuilder<GenericCubit<TokenModel?>,
                GenericCubitState<TokenModel?>>(
              bloc: loginViewModel.loginCubit,
              builder: (context, loginState) {
                return loginState is GenericLoadingState
                    ? const Loading()
                    : CustomButton(
                        title: "sign_in",
                        onPressed: loginPressed,
                      );
              },
            ),
            SizedBox(
              height: AppSize.h26,
            ),
            const CreateAccountText()
          ],
        ));
  }

  void loginPressed() {
    if (formKey.currentState!.validate()) {
      final userName = userNameController.text.trim();
      final password = passwordController.text.trim();
      loginViewModel.login(context, userName: userName, password: password);
    }
  }
}

CustomField buildPasswordTXTField(GenericCubitState<bool> passwordState,
    {required LoginViewModel loginViewModel,
    required TextEditingController passwordController,
    required FocusNode passwordFocusNode}) {
  return CustomField(
      isPassword: passwordState.data,
      focusNode: passwordFocusNode,
      filled: true,
      hint: "password".tr(),
      controller: passwordController,
      suffix: InkWell(
        onTap: () {
          loginViewModel.passwordSecureCubit.onUpdateData(!passwordState.data);
        },
        child: Padding(
          padding: EdgeInsets.all(AppSize.w15),
          child: const Icon(Icons.visibility),
        ),
      ),
      validator: FormValidation.passwordFormValidation);
}

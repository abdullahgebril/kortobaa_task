import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/generic_cubit/generic_cubit.dart';
import 'package:flutter_task/core/utils/app_size.dart';
import 'package:flutter_task/core/utils/form_validation.dart';
import 'package:flutter_task/core/widgets/empty_space.dart';
import 'package:flutter_task/core/widgets/custom_button.dart';
import 'package:flutter_task/core/widgets/custom_feild.dart';
import 'package:flutter_task/core/widgets/form_title.dart';
import 'package:flutter_task/core/widgets/loading_widget.dart';
import 'package:flutter_task/features/registration/model/user_model.dart';
import 'package:flutter_task/features/registration/registration_view_model.dart';
import 'package:flutter_task/features/registration/widget/login_text.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  RegistrationViewModel registrationViewModel = RegistrationViewModel();
  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  final FocusNode _userNameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _confirmPassController.dispose();
    _emailController.dispose();
    _userNameFocus.dispose();
    _passwordFocus.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocusNode.dispose();
    _confirmPasswordFocus.dispose();
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
                nextFocus: _emailFocusNode,
                hint: "user_name".tr(),
                controller: _userNameController,
                validator: FormValidation.userNameFormValidation),
            EmptySpace(space: AppSize.h20),
            const FormTitle(title: "email"),
            CustomField(
                filled: true,
                inputType: TextInputType.emailAddress,
                focusNode: _emailFocusNode,
                nextFocus: _firstNameFocus,
                hint: "email".tr(),
                controller: _emailController,
                validator: FormValidation.validateFormEmail),
            EmptySpace(space: AppSize.h20),
            const FormTitle(title: "first_name"),
            CustomField(
                filled: true,
                focusNode: _firstNameFocus,
                nextFocus: _lastNameFocus,
                hint: "first_name".tr(),
                controller: _firstNameController,
                validator: FormValidation.userNameFormValidation),
            EmptySpace(space: AppSize.h20),
            const FormTitle(title: "last_name"),
            CustomField(
                filled: true,
                focusNode: _lastNameFocus,
                nextFocus: _passwordFocus,
                hint: "last_name".tr(),
                controller: _lastNameController,
                validator: FormValidation.userNameFormValidation),
            EmptySpace(space: AppSize.h20),
            const FormTitle(title: "password"),
            BlocBuilder<GenericCubit<bool>, GenericCubitState<bool>>(
              bloc: registrationViewModel.passwordSecureCubit,
              builder: (context, passwordState) {
                return CustomField(
                    isPassword: passwordState.data,
                    focusNode: _passwordFocus,
                    nextFocus: _confirmPasswordFocus,
                    filled: true,
                    hint: "password".tr(),
                    controller: _passwordController,
                    suffix: InkWell(
                      onTap: () {
                        registrationViewModel.passwordSecureCubit
                            .onUpdateData(!passwordState.data);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(AppSize.w15),
                        child: const Icon(Icons.visibility),
                      ),
                    ),
                    validator: FormValidation.passwordFormValidation);
              },
            ),
            EmptySpace(space: AppSize.h20),
            const FormTitle(title: "confirm_password"),
            BlocBuilder<GenericCubit<bool>, GenericCubitState<bool>>(
              bloc: registrationViewModel.confirmPasswordSecureCubit,
              builder: (context, passwordState) {
                return CustomField(
                    isPassword: passwordState.data,
                    focusNode: _confirmPasswordFocus,
                    filled: true,
                    hint: "confirm_password".tr(),
                    controller: _confirmPassController,
                    suffix: InkWell(
                      onTap: () {
                        registrationViewModel.confirmPasswordSecureCubit
                            .onUpdateData(!passwordState.data);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(AppSize.w15),
                        child: const Icon(Icons.visibility),
                      ),
                    ),
                    validator: (value) =>
                        FormValidation.confirmPasswordFormValidation(
                            value, _passwordController.text));
              },
            ),
            SizedBox(
              height: AppSize.h26,
            ),
            BlocBuilder<GenericCubit<UserModel?>,
                GenericCubitState<UserModel?>>(
              bloc: registrationViewModel.registerCubit,
              builder: (context, registerState) {
                return registerState is GenericLoadingState
                    ? const Loading()
                    : CustomButton(
                        title: 'register',
                        onPressed: createAcountPressed,
                      );
              },
            ),
            SizedBox(
              height: AppSize.h26,
            ),
            const LoginText()
          ],
        ));
  }

  void createAcountPressed() {
    if (formKey.currentState!.validate()) {
      final userName = _userNameController.text.trim();
      final password = _passwordController.text.trim();
      final email = _emailController.text.trim();
      final firstName = _firstNameController.text.trim();
      final lastName = _lastNameController.text.trim();

      registrationViewModel.registerAccount(context,
          username: userName,
          password: password,
          email: email,
          firstName: firstName,
          lastName: lastName);
    }
  }
}

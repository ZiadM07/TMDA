import '../../../../core/constants/exports.dart';
import '../../../../core/framework/app_validator.dart';
import '../../../shared/presentation/widgets/app_text_form_field.dart';

class LoginFormFields extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final FocusNode usernameFocusNode;
  final FocusNode passwordFocusNode;
  final bool isLoading;
  final VoidCallback onLogin;

  const LoginFormFields({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.usernameFocusNode,
    required this.passwordFocusNode,
    required this.isLoading,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          controller: usernameController,
          focusNode: usernameFocusNode,
          hintText: context.locale.enterYourUsername,
          label: context.locale.userName,
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
          validator: AppValidator.username,
          enabled: !isLoading,
          onFieldSubmitted: (_) {
            passwordFocusNode.requestFocus();
          },
        ),
        const SizedBox(height: 16),
        AppTextFormField(
          controller: passwordController,
          focusNode: passwordFocusNode,
          hintText: context.locale.enterYourPassword,
          label: context.locale.password,
          isPasswordField: true,
          textInputAction: TextInputAction.done,
          enabled: !isLoading,
          validator: (value) {
            return AppValidator.password(value, isSignup: false);
          },
          onFieldSubmitted: (_) {
            passwordFocusNode.unfocus();
            if (!isLoading) onLogin();
          },
        ),
      ],
    );
  }
}

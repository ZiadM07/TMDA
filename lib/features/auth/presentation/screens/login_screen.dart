import 'package:tmda/core/state/app_state.dart';
import '../../../../config/router/app_router.gr.dart';
import '../../../../core/constants/exports.dart';
import '../../../../core/framework/kprint.dart';
import '../../../shared/presentation/widgets/app_toast.dart';
import '../cubits/auth_cubit.dart';
import '../widgets/login_button.dart';
import '../widgets/login_footer.dart';
import '../widgets/login_form_fields.dart';
import '../widgets/login_header.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  void _login() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      AppToast.showError(
        message: 'you entered invalid username or password',
        context: context,
      );
      return;
    }
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    context.read<AuthCubit>().login(username: username, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbarSize: 0,
      showBackButton: false,
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<AuthCubit, AppState>(
        listener: (context, state) {
          if (state.status == StateStatus.success) {
            kPrint('Login successful');
            context.replaceRoute(const AuthenticatedRoutes());
          } else if (state.status == StateStatus.error) {
            kPrint('Login error: ${state.message}');
            AppToast.showError(
              message: state.message ?? context.locale.somethingWentWrong,
              context: context,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status == StateStatus.loading;

          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const LoginHeader(),
                  const SizedBox(height: 50),
                  LoginFormFields(
                    usernameController: _usernameController,
                    passwordController: _passwordController,
                    usernameFocusNode: _usernameFocusNode,
                    passwordFocusNode: _passwordFocusNode,
                    isLoading: isLoading,
                    onLogin: _login,
                  ),
                  const SizedBox(height: 48),
                  LoginButton(isLoading: isLoading, onPressed: _login),
                  const SizedBox(height: 80),
                  LoginFooter(isLoading: isLoading),
                  const SizedBox(height: 32),
                ],
              ).addPadding(horizontal: 20),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}

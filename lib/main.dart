import 'core/constants/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const TmdaApp());
}

// await getIt<AppPreferences>().clearSession();

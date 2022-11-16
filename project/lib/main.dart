import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/firebase_options.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/create_profile_screen.dart';
import 'package:project/screens/edit_project_screen.dart';
import 'package:project/screens/profile_screen.dart';
import 'package:project/screens/project_overview_screen.dart';
import 'package:project/screens/project_preview_screen.dart';
import 'package:project/data/example_data.dart';
import 'package:project/screens/project_calendar_screen.dart';
import 'package:project/screens/sign_in_screen.dart';
import 'package:project/screens/user_settings_screen.dart';
import 'package:project/services/preferences_service.dart';
import 'package:project/styles/theme.dart';
import 'package:project/screens/task_details_screen.dart';
import 'package:project/screens/task_overview_screen.dart';
import 'package:project/screens/home_screen.dart';
import './models/project.dart';

Future<void> main() async {
  await dotenv.load(fileName: "variables.env");
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the preferences service.
  PreferencesService();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static List<Project> projects = ExampleData.projects;

  /// Check if the user is logged in.
  /// They get send to the [HomeScreen] if logged in and [SignInScreen] if not.
  Widget initialScreenCheck(WidgetRef ref) {
    final userAsyncData = ref.watch(userProvider);

    return userAsyncData.when(
      data: (user) {
        String userId = user != null ? user.uid : "<unknown>";
        print("User = $userId");
        return user != null ? const HomeScreen() : SignInScreen();
      },
      error: (err, stack) => Text("Error in auth stream: $err"),
      loading: () => const CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => MaterialApp(
        title: "solveit",
        theme: Themes.themeData,
        home: initialScreenCheck(ref),
        routes: {
          SignInScreen.routeName: (context) => SignInScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          ProjectCalendarScreen.routeName: (context) =>
              const ProjectCalendarScreen(),
          TaskOverviewScreen.routeName: (context) => const TaskOverviewScreen(),
          TaskDetailsScreen.routeName: (context) => const TaskDetailsScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
          ProjectPreviewScreen.routeName: (context) =>
              const ProjectPreviewScreen(),
          ProjectOverviewScreen.routeName: (context) =>
              const ProjectOverviewScreen(),
          CreateProfileScreen.routeName: (context) =>
              const CreateProfileScreen(),
          UserSettingsScreen.routeName: (context) => const UserSettingsScreen(),
          EditProjectScreen.routeName: (context) => const EditProjectScreen(),
        },
      ),
    );
  }
}

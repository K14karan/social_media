import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/provider/add_story_provider.dart';
import 'package:social_media/provider/user_provider.dart';
import 'package:social_media/provider/user_register_provider.dart';
import 'package:social_media/resources/resources.dart';
import 'package:social_media/router/routes.dart';
import 'package:social_media/services/api_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "your-supabase-url",
    anonKey: "your-anon-key",
  );
  final supabaseClient = Supabase.instance.client;
  runApp(MyApp(supabaseClient: supabaseClient));
}

class MyApp extends StatelessWidget {
  final SupabaseClient supabaseClient;
  const MyApp({super.key, required this.supabaseClient});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => StoryProvider()),

        // Provide ApiServices with the SupabaseClient
        Provider<ApiServices>(
          create: (_) => ApiServices(supabaseClient),
        ),

        // Provide RegisterController
        ChangeNotifierProvider(
          create: (context) => RegisterController(context.read<ApiServices>()),
        ),
      ],
      child: MaterialApp.router(
        title: 'ConnectMe',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Resources.colors.themeColor),
          useMaterial3: true,
          fontFamily: 'Roboto',
        ),
        routeInformationParser: AppRoutes.router.routeInformationParser,
        routerDelegate: AppRoutes.router.routerDelegate,
        routeInformationProvider: AppRoutes.router.routeInformationProvider,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

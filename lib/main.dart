import 'package:flutter/material.dart';
import 'package:themoviedb/ui/theme/app_colors.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/main/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_detail/movie_details_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.mainDarkBlue,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: AppColors.mainDarkBlue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => AuthProvider(
              child: AuthWidget(),
              model: AuthModel(),
            ),
        '/main': (context) => const MainScreenWidget(),
        '/main/movie_detail': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is int) {
            return MovieDetailWidget(
              movieId: arguments,
            );
          }
          return MovieDetailWidget(movieId: 0);
        },
      },
      initialRoute: '/',
      onUnknownRoute: (settings) {
        return MaterialPageRoute<void>(
          builder: (context) => Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
      },
    );
  }
}

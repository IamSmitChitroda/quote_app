import 'package:quote_app/headers.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void changeScreen(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacementNamed(
          AppRoutes.homePage,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    changeScreen(context);

    return const Scaffold(
      body: Center(
        child: RefreshProgressIndicator(),
      ),
    );
  }
}

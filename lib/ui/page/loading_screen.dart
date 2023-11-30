part of './page.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(width / 4, height / 3, width / 4, height / 3),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

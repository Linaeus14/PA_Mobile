part of './page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    UserData userData = Provider.of<UserData>(context, listen: false);
    if (userData.id != null) {
      return SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SearchField(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
              child: Container(
                  width: width,
                  height: height - 218,
                  padding: const EdgeInsets.all(8.0),
                  child: const Placeholder()),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
          body: SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "Sign In to Use This Feature!",
                style: Theme.of(context).textTheme.headlineSmall,
              )),
            ),
            SignButton(
              signInButton: true,
              onPressed: () => Navigator.pushNamed(context, 'authIn'),
              hideBottom: true,
            ),
          ],
        ),
      ));
    }
  }
}

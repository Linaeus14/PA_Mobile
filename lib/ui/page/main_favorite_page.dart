part of './page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchField(
                controller: _searchController,
                onSubmitted: (value) {},
              ),
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
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const SignIn()))),
              hideBottom: true,
            ),
          ],
        ),
      ));
    }
  }
}

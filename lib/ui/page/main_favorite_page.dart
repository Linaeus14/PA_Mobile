part of './page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<PlantClass> allPlants = [];
  List<PlantClass> searchedPlants = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;
    UserData userData = Provider.of<UserData>(context, listen: false);
    if (userData.id != null) {
      return SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Plants",
                style: textTheme.titleMedium,
              ),
            ),
            SizedBox(
              width: width,
              height: height / 1.2,
              child: RefreshIndicator(
                onRefresh: _refreshData,
                child: FutureBuilder<List<PlantClass>>(
                  future: Api.favoritesData(userData.data!.favorite),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              width / 2 - 40, 8, width / 2 - 40, 8),
                          child: const CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      debugPrint(snapshot.error.toString());
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.error.toString(),
                            style: textTheme.bodySmall,
                          ),
                        ),
                      );
                    } else {
                      allPlants = snapshot.data!;
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: allPlants.length,
                        itemBuilder: (BuildContext context, int index) {
                          PlantClass plant = allPlants[index];
                          bool isFavorite = false;
                          if (userData.id != null) {
                            isFavorite = userData.data!.favorite
                                .contains(plant.id.toString());
                          }
                          return isFavorite
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      16.0, 2.0, 16.0, 4.0),
                                  child: PlantTile(
                                    plant: plant,
                                    isOn: isFavorite,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailPage(plant: plant)));
                                    },
                                    onFavPressed: () async {
                                      if (userData.id != null) {
                                        setState(() {
                                          userData.data!.favorite
                                              .remove(plant.id.toString());
                                        });
                                        showToast(
                                            '${plant.nama!} removed from favorites');
                                        await userData.updateField('favorite',
                                            userData.data!.favorite);
                                      }
                                    },
                                  ),
                                )
                              : const Center();
                        },
                      );
                    }
                  },
                ),
              ),
            ),
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
                  ),
                ),
              ),
              SignButton(
                signInButton: true,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => const SignIn()))),
                hideBottom: true,
              ),
            ],
          ),
        ),
      );
    }
  }

  Future<void> _refreshData() async {
    Shared cache = Shared();
    await cache.file.remove("favorites");
    setState(() {
      allPlants.clear();
    });
    await _loadData();
  }

  Future<void> _loadData() async {
    try {
      List<PlantClass> plants = await Api.favoritesData(
          Provider.of<UserData>(context, listen: false).data!.favorite);
      setState(() {
        allPlants.addAll(plants);
      });
    } catch (e) {
      debugPrint('Error loading data: $e');
      // Handle error loading data
    }
  }

  void showToast(String text) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG, // Change to LONG for a longer duration
      gravity: ToastGravity.CENTER, // Change to CENTER for center positioning
      timeInSecForIosWeb: 2, // Adjust the duration accordingly
      backgroundColor: scheme.primary,
      textColor: scheme.onPrimary,
      fontSize: 14.0,
    );
  }
}

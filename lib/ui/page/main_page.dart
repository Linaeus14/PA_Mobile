part of './page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static final List<String> navName = ["Favorite", "Home", "Profile"];
  int navIndex = 1;

  @override
  Widget build(BuildContext context) {
    final List<Widget> navBody = [
      const FavoritePage(),
      const HomePage(),
      const ProfilePage()
    ];
    ColorScheme scheme = Theme.of(context).colorScheme;
    DarkMode darkmode = Provider.of<DarkMode>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scheme.background,
        surfaceTintColor: scheme.background,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            navName[navIndex],
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
                darkmode.isDark
                    ? darkmode.changeMode(0)
                    : darkmode.changeMode(1);
              },
              icon: darkmode.isDark
                  ? const Icon(CupertinoIcons.moon_stars)
                  : const Icon(CupertinoIcons.sun_dust),
            ),
          ),
        ],
      ),
      body: navBody[navIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: scheme.surfaceVariant,
        unselectedItemColor: scheme.onSurfaceVariant,
        selectedItemColor: scheme.primary,
        selectedIconTheme: const IconThemeData(size: 25),
        unselectedIconTheme: const IconThemeData(size: 20),
        currentIndex: navIndex,
        onTap: onItemTap,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.heart_fill),
            label: navName[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_filled),
            label: navName[1],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_2_rounded),
            label: navName[2],
          )
        ],
      ),
    );
  }

  void onItemTap(int index) => setState(() => navIndex = index);
}

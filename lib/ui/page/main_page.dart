part of './page.dart';

class MainPage extends StatefulWidget {
  final double _width;
  final double _height;
  const MainPage(
      {super.key,
      required double mediaQueryWidth,
      required double mediaQueryHeight})
      : _width = mediaQueryWidth,
        _height = mediaQueryHeight;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static final List<String> navName = ["Favorite", "Home", "Profile"];
  double get _width => widget._width;
  double get _height => widget._height;
  int navIndex = 1;

  @override
  Widget build(BuildContext context) {
    final List<Widget> navBody = [
      HomePage(mediaQueryWidth: _width, mediaQueryHeight: _height),
      HomePage(mediaQueryWidth: _width, mediaQueryHeight: _height),
      HomePage(mediaQueryWidth: _width, mediaQueryHeight: _height)
    ];
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: Text(navName[navIndex]),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.sunrise))
        ],
      ),
      body: navBody[navIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: scheme.surfaceVariant,
        unselectedItemColor: scheme.onSurfaceVariant,
        selectedItemColor: scheme.primary,
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

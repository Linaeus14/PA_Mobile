part of './page.dart';

// ignore: must_be_immutable
class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> teamData = [
      {
        'name': 'Reihan Al Sya\'Ban',
        'nim': '2109106051',
        'imagePath': 'assets/saban.png',
      },
      {
        'name': 'Tito Darmawan',
        'nim': '2109106042',
        'imagePath': 'assets/tito.png',
      },
      {
        'name': 'Muhammad Firdaus',
        'nim': '2109106052',
        'imagePath': 'assets/daus.png',
      },
    ];
    ColorScheme scheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    DarkMode darkmode = Provider.of<DarkMode>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: scheme.background,
          surfaceTintColor: scheme.background,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'About Us',
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: width,
                  height: height / 4,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/logo.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Selamat datang di PlantDex",
                        textAlign: TextAlign.center,
                        style: textTheme.titleLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Sebuah perjalanan tanaman yang tak terlupakan! Kami di PlantDex percaya bahwa kecantikan tumbuhan dan kebahagiaan berasal dari koneksi yang mendalam dengan alam.",
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Our Teams",
                        style: textTheme.titleMedium,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: width,
                      height: height / 4,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return TeamCard(
                            name: teamData[index]['name']!,
                            nim: teamData[index]['nim']!,
                            imagePath: teamData[index]['imagePath']!,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Our App", style: textTheme.titleMedium),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "PlantDex adalah aplikasi revolusioner yang memadukan kecintaan pada tanaman dengan teknologi canggih, membawa keindahan alam tepat ke ujung jari Anda. Dengan PlantDex, kami membuka pintu menuju eksplorasi tanaman yang penuh keajaiban, membantu Anda merawat setiap tanaman dengan percaya diri, dan memberikan inspirasi untuk menciptakan taman yang benar-benar unik.",
                          textAlign: TextAlign.justify,
                          style: textTheme.bodyMedium),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class TeamCard extends StatelessWidget {
  const TeamCard(
      {super.key,
      required this.name,
      required this.nim,
      required this.imagePath});

  final String name;
  final String nim;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width / 4,
      height: height / 5,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: scheme.background,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: scheme.primary)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: width / 6,
            height: height / 12,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                color: scheme.surfaceVariant,
                borderRadius: BorderRadius.circular(30)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  name,
                  style: textTheme.titleSmall,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                Text(
                  nim,
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

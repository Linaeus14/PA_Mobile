part of './page.dart';

// ignore: must_be_immutable
class AboutUs extends StatelessWidget {
  AboutUs({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withOpacity(0.8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: const Text(
                      "About Us",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16),
                  child: const Icon(Icons.wb_sunny),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Selamat datang di PlantDex",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Sebuah perjalanan tanaman yang tak terlupakan!\nKami di PlantDex percaya bahwa kecantikan tumbuhan dan kebahagiaan berasal dari koneksi yang mendalam dengan alam.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Our Teams",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildTeamCard(
                    teamData[index]['name']!,
                    teamData[index]['nim']!,
                    teamData[index]['imagePath']!,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Our App",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "PlantDex adalah aplikasi revolusioner yang memadukan kecintaan pada tanaman dengan teknologi canggih, membawa keindahan alam tepat ke ujung jari Anda. Dengan PlantDex, kami membuka pintu menuju eksplorasi tanaman yang penuh keajaiban, membantu Anda merawat setiap tanaman dengan percaya diri, dan memberikan inspirasi untuk menciptakan taman yang benar-benar unik.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildTeamCard(String name, String nim, String imagePath) {
    return Container(
      width: 150,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                width: 80,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  nim,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

part of './page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: scheme.surfaceVariant,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: scheme.onBackground,
                  ),
                ),
                const Text('Saban',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
                const Text('saban@gmail.com',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          Container(
              constraints: BoxConstraints(minHeight: height / 1.8),
              width: width,
              padding: const EdgeInsets.all(20.0),
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: scheme.surfaceVariant,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info,
                      color: scheme.onBackground,
                      size: 36,
                    ),
                    title: const Text("About Us", style: TextStyle()),
                    subtitle: const Text("This is Us :)", style: TextStyle()),
                    trailing: Icon(
                      Icons.navigate_next,
                      color: scheme.onBackground,
                      size: 28,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.red[400],
                      size: 36,
                    ),
                    title: const Text("Delete Account", style: TextStyle()),
                    subtitle:
                        const Text("Dont Leave Us :(", style: TextStyle()),
                    trailing: Icon(
                      Icons.navigate_next,
                      color: Colors.red[400],
                      size: 28,
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

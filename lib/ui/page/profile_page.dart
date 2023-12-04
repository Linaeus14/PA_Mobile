part of './page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      controller: _scrollController,
      reverse: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: scheme.surfaceVariant,
            child: const Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Saban',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
          const Text('saban@gmail.com,',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 40),
          Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 347),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: scheme.onPrimary,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.info,
                      color: Colors.white,
                      size: 36,
                    ),
                    title: const Text("About Us", style: TextStyle()),
                    subtitle: const Text("This is Us :)", style: TextStyle()),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.white,
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
                    subtitle: const Text("Dont Leave Us :(", style: TextStyle()),
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

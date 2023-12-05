part of './page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    UserData userData = Provider.of<UserData>(context, listen: false);

    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: scheme.surfaceVariant,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: scheme.onBackground,
                    ),
                  ),
                ),
                Text(userData.data?.nama ?? "Guest",
                    style: const TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
                Text(userData.data?.email ?? "-",
                    style: const TextStyle(
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
                  OptionTile(
                    icon: Icons.info,
                    title: "About Us",
                    subtitle: "This is Us :)",
                    onTap: () {},
                  ),
                  userData.id != null
                      ? OptionTile(
                          icon: Icons.delete_forever,
                          title: "Delete Account",
                          subtitle: "Dont Leave Us :(",
                          onTap: () {},
                        )
                      : const Center(),
                  userData.id != null
                      ? OptionTile(
                          icon: Icons.logout,
                          title: "sign Out",
                          subtitle: "Rest for now",
                          onTap: () async {
                            await Auth().signOut();
                            userData.disposeVar();
                            if (context.mounted) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const MainPage()));
                            }
                          })
                      : const Center()
                ],
              )),
        ],
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  const OptionTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        onTap();
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(30.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            leading: Icon(
              icon,
              color: scheme.primary,
              size: 36,
            ),
            title: Text(title, style: const TextStyle()),
            subtitle: Text(subtitle, style: const TextStyle()),
            trailing: Icon(
              Icons.navigate_next,
              color: scheme.onBackground,
              size: 28,
            ),
            onTap: () {
              onTap();
            },
          ),
        ),
      ),
    );
  }
}

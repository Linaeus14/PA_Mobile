part of './page.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: Image.asset(
                            'sign_up.png',
                            fit: BoxFit.contain,
                            width: width / 2,
                            height: height / 4,
                          ),
                        ),
                        Center(
                          child: Text('Get on Board!',
                              style: textTheme.headlineSmall),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'Create a new account to access all our features',
                                style: textTheme.titleSmall),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Full Name',
                                hintStyle: textTheme.bodyLarge,
                                prefixIcon: const Icon(Icons.person),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Email Address',
                                hintStyle: textTheme.bodyLarge,
                                prefixIcon: const Icon(Icons.email),
                                border: const OutlineInputBorder(),
                              ),
                              obscureText: true,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: textTheme.bodyLarge,
                                prefixIcon: const Icon(Icons.fingerprint),
                                border: const OutlineInputBorder(),
                              ),
                              obscureText: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SignButton(
              signInButton: false,
              onPressed: () {},
            ),
          ],
        ));
  }
}

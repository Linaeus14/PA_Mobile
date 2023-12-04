part of './page.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                      child: Image.asset(
                    'sign_in.png',
                    fit: BoxFit.contain,
                    width: width / 2,
                    height: height / 4,
                  )),
                  Center(
                    child:
                        Text('Welcome Back', style: textTheme.headlineSmall),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                          'Access Plantdex features with your login',
                          style: textTheme.titleSmall),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                          hintStyle: textTheme.bodyLarge,
                          prefixIcon: const Icon(Icons.email),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
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
            SignButton(onPressed: () {})
          ],
        ));
  }
}

part of './page.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  List<bool> validator = [false, false, false];
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _ctrlEmail.dispose();
    _ctrlPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: ListView(
          children: [
            Column(
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
                        child: Text('Welcome Back',
                            style: textTheme.headlineSmall),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: _ctrlEmail,
                                validator: (value) {
                                  _validate(value, 0);
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Email Address',
                                  hintStyle: textTheme.bodyLarge,
                                  prefixIcon: const Icon(Icons.email),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: _ctrlPassword,
                                obscureText: _isPasswordHidden,
                                validator: (value) {
                                  _validate(value, 1);
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: textTheme.bodyLarge,
                                    prefixIcon: const Icon(Icons.fingerprint),
                                    border: const OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      icon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          _isPasswordHidden
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordHidden =
                                              !_isPasswordHidden;
                                        });
                                      },
                                    )),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                height: height / 10,
                                child: Visibility(
                                    visible: validator.contains(true),
                                    child: Text(
                                      validator[0]
                                          ? "Email can't be empty!"
                                          : validator[1]
                                              ? "Password can't be empty!"
                                              : "Incorrect authentication data!",
                                      style: textTheme.bodyLarge,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SignButton(onPressed: () async {
                  _handleSignIn();
                })
              ],
            ),
          ],
        ));
  }

  void _validate(String? value, int index) {
    setState(() {
      if (value!.isEmpty) {
        validator[index] = true;
      } else {
        validator[index] = false;
      }
    });
  }

  Future<void> _handleSignIn() async {
    setState(() {
      validator[2] = false;
    });

    _formKey.currentState!.validate();
    if (_ctrlEmail.text.isEmpty || _ctrlPassword.text.isEmpty) return;
    UserData userData = Provider.of<UserData>(context, listen: false);
    final email = _ctrlEmail.value.text;
    final password = _ctrlPassword.value.text;

    try {
      Map<String, dynamic>? loginSucces = await Auth().login(email, password);

      if (loginSucces["success"]) {
        userData.userId = loginSucces['userId'];
        await userData.getData();
        if (!context.mounted) return;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => const MainPage())));
      } else {
        setState(() {
          validator[2] = true;
        });
        return;
      }
    } on Exception catch (e) {
      debugPrint("Login failed: $e");
      return;
    }
  }
}

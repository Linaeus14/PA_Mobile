part of './page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlName = TextEditingController();
  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  List<bool> validator = [false, false, false, false];
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _ctrlName.dispose();
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
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      validator: (value) {
                                        _validate(value, 0);
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Full Name',
                                        hintStyle: textTheme.bodyLarge,
                                        prefixIcon: const Icon(Icons.person),
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      validator: (value) {
                                        _validate(value, 1);
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Email Address',
                                        hintStyle: textTheme.bodyLarge,
                                        prefixIcon: const Icon(Icons.email),
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      obscureText: _isPasswordHidden,
                                      validator: (value) {
                                        _validate(value, 2);
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Password',
                                          hintStyle: textTheme.bodyLarge,
                                          prefixIcon:
                                              const Icon(Icons.fingerprint),
                                          border: const OutlineInputBorder(),
                                          suffixIcon: IconButton(
                                            icon: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    height: height / 20,
                                    child: Visibility(
                                        visible: validator.contains(true),
                                        child: Text(
                                          validator[0]
                                              ? "Name can't be empty!"
                                              : validator[1]
                                                  ? "Email can't be empty!"
                                                  : validator[2]
                                                      ? "Password can't be empty!"
                                                      : "Please try again later",
                                          style: textTheme.bodyLarge,
                                        )),
                                  )
                                ],
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
                  onPressed: () {
                    _handleSubmit();
                  },
                ),
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

  void _handleSubmit() async {
    setState(() {
      validator[3] = false;
    });

    _formKey.currentState!.validate();
    if (_ctrlEmail.text.isEmpty ||
        _ctrlPassword.text.isEmpty ||
        _ctrlName.text.isEmpty) return;

    final String name = _ctrlName.value.text;
    final String email = _ctrlEmail.value.text;
    final String password = _ctrlPassword.value.text;
    final UserData userData = Provider.of<UserData>(context, listen: false);

    Map<String, dynamic> registerRequest = await Auth().regis(email, password);

    try {
      if (registerRequest['success'] != null) {
        String uid = registerRequest['userId'];
        userData.userId = uid;
        await userData.addUserToFirestore(uid, email, name);
        await userData.getData();
        dialog(text: "Registrasi Berhasil");
        if (!context.mounted) return;
        Navigator.of(context).pop();
      }
      setState(() {
        validator[3] = true;
      });
      dialog(text: "Registrasi Gagal");
    } on Exception catch (e) {
      dialog(text: "Registrasi Gagal : $e");
    }
  }

  void dialog({required String text, Icon? icon}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        ColorScheme scheme = Theme.of(context).colorScheme;
        return AlertDialog(
          title: Text(text),
          backgroundColor: scheme.background,
          shadowColor: scheme.onBackground,
          icon: icon,
          iconColor: scheme.primary,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup AlertDialog
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}

part of './widget.dart';

class SignButton extends StatelessWidget {
  const SignButton(
      {super.key,
      required this.signInButton,
      required this.onPressed,
      this.hideBottom = false});
  final bool signInButton;
  final bool hideBottom;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: width,
              height: height / 20,
              child: ElevatedButton(
                onPressed: () => onPressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.primary,
                  foregroundColor: scheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  signInButton ? 'Sign In' : 'Sign Up',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          hideBottom
              ? const Padding(padding: EdgeInsets.all(8.0))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: signInButton
                                ? "Don't have an account? "
                                : 'Have an Account? '),
                        TextSpan(
                          text: signInButton ? 'Sign Up' : 'Sign In',
                          style: TextStyle(
                            color: scheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                  context, signInButton ? 'authUp' : 'authIn');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

part of './widget.dart';

class SignButton extends StatelessWidget {
  const SignButton(
      {super.key,
      this.signInButton = true,
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
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(24.0),
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
                  textStyle: textTheme.bodyLarge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  signInButton ? 'Sign In' : 'Sign Up',
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
                      children: [
                        TextSpan(
                            text: signInButton
                                ? "Don't have an account? "
                                : 'Have an Account? ',
                            style: textTheme.bodySmall),
                        TextSpan(
                          text: signInButton ? 'Sign Up' : 'Sign In',
                          style: TextStyle(
                            color: scheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.popAndPushNamed(
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

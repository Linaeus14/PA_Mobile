part of './page.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 180,
                height: 175,
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset('assets/sign_up.png', fit: BoxFit.cover),
              ),
              
              Container(
                margin: EdgeInsets.only(top: 26),
                child: Text(
                  'Get on Board!',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              Container(
                margin: EdgeInsets.only(top: 12),
                child: Text(
                  'Create a new account to access all our features',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 14,
                  ),
                ),
              ),
              
              Container(
                margin: EdgeInsets.only(top: 25),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                    prefixIcon: Icon(Icons.person),  
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              
              Container(
                margin: EdgeInsets.only(top: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,  
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                    prefixIcon: Icon(Icons.fingerprint),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,  
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 130),
                width: 350,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                   
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF338249),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 15, left: 90),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 14,
                      color: Colors.black,  
                    ),
                    children: [
                      TextSpan(text: 'Have an Account? '),
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          color: Colors.green,  
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
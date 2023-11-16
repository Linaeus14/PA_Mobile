part of './page.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

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
                child: Image.asset('assets/sign_in.png', fit: BoxFit.cover),
              ),
              
              Container(
                margin: EdgeInsets.only(top: 26),
                child: Text(
                  'Welcome Back,',
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
                  'Access Plant Identifier features with your login',
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
                    hintText: 'Email Address',
                    hintStyle: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w400,
                              ),
                    prefixIcon: Icon(Icons.email),  
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              
              Container(
                margin: EdgeInsets.only(top: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w400,
                              ),
                    prefixIcon: Icon(Icons.fingerprint),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,  
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 200),
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
                    'Sign In',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Raleway',
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
                      TextSpan(text: 'New to Plantdex? '),
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Colors.green,  
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
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
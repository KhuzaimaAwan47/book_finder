import 'package:book_finder/auth/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/userModel.dart';
import '../pages/home_page.dart';
import '../theme/theme_manager.dart';
import 'database_helper.dart';


//Login page
class Login extends StatefulWidget{
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();

}

class _LoginState extends State <Login> {
  bool isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoginTrue = false;
  final db = DatabaseHelper();

  //login function
 login() async{
   var response = await db
       .login(Users(email: _emailController.text, password: _passwordController.text));
   if (response == true) {

     if (!mounted) return;
     Navigator.pushReplacement(
         context, MaterialPageRoute(builder: (context) => const HomePage()));
   } else {

     setState(() {
       isLoginTrue = true;
     });
   }
 }

 @override
  Widget build(BuildContext context) {
    Provider.of<ThemeManager>(context);
    final currentTheme = Theme.of(context);
    return Scaffold(
      appBar: null,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome Back!',style: currentTheme.textTheme.displayLarge),
                const SizedBox(height: 30,),
                TextFormField(
                  controller: _emailController,
                  validator: Validators.validateEmail,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )
                  ),
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: _passwordController,
                  validator: Validators.validatePassword,
                  obscureText: !isPasswordVisible,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.password,),
                      suffixIcon: IconButton(
                        icon: Icon(isPasswordVisible ? Icons.visibility:Icons.visibility_off,),
                        onPressed: ()
                        {
                          setState((){
                            isPasswordVisible  =  !isPasswordVisible;
                          });

                        },),
                      labelText: 'Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )
                  ),
                ),
                const SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: () async {
                   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()),);
                    if (_formKey.currentState!.validate()) {
                      //Login method will be here
                      login();

                      //Now we have a response from our sqlite method
                      //We are going to create a user
                    }
                  },
                  child: Text('Login',
                    style: TextStyle(
                        color: currentTheme.brightness == Brightness.dark ?Colors.white :Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: Text("Don't have an account? Sign Up",
                    style: currentTheme.textTheme.bodyMedium?.
                    copyWith(
                      color: currentTheme.primaryColor,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


// SignUp page
class SignUp extends StatefulWidget{
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();

}

class _SignUpState extends State <SignUp> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final currentTheme = Theme.of(context);
    return Scaffold(
      appBar: null,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sign Up',style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 30,),

                  TextFormField(
                    controller: _nameController,
                    validator: Validators.validateName,
                    decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: _emailController,
                    validator: Validators.validateEmail,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: _passwordController,
                    validator: Validators.validatePassword,
                    obscureText: !isPasswordVisible,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password,),
                        suffixIcon: IconButton(
                          icon: Icon(isPasswordVisible ? Icons.visibility:Icons.visibility_off),
                          onPressed: ()
                          {
                            setState((){
                              isPasswordVisible  =  !isPasswordVisible;
                            });

                          },),
                        labelText: 'Password',
                        //prefixIcon: Icon(Icons.remove_red_eye_sharp),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: _confirmPasswordController,
                    validator: (value) => Validators.validateConfirmPassword(value, _passwordController.text),
                    obscureText: !isConfirmPasswordVisible,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.password,),
                        suffixIcon: IconButton(
                          icon: Icon(isConfirmPasswordVisible ? Icons.visibility:Icons.visibility_off),
                          onPressed: ()
                          {
                            setState((){
                              isConfirmPasswordVisible  =  !isConfirmPasswordVisible;
                            });

                          },),
                        labelText: 'Confirm Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    ),
                  ),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: ()  {
                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Login()));
                      if (_formKey.currentState!.validate()) {
                        //Login method will be here

                        final db = DatabaseHelper();
                        db
                            .signUp(Users(
                            email: _emailController.text,
                            password: _passwordController.text))
                            .whenComplete(() {
                          //After success user creation go to login screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const Login()));
                        });
                      }
                    },
                    child: Text('Sign Up',
                      style: TextStyle(
                          color: currentTheme.brightness == Brightness.dark ?Colors.white :Colors.white),
                    ),

                  ),
                  TextButton(
                      onPressed: () async {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()),);
                      },
                      child: Text("Already have an Account? Login",
                        style: currentTheme.textTheme.bodyMedium?.
                        copyWith(
                          color: currentTheme.primaryColor,
                        ),
                      ))
                ]
            ),
          ),
        ),
      ),
    );
  }
}
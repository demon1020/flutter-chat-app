import 'package:chat_app/feature/login/repository/auth_service.dart';
import 'package:chat_app/feature/home/screen/main_page.dart';
import 'package:flutter/material.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = true;
  var _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width / 0.5,
                child: IconButton(
                    icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Container(
                width: size.width / 1.1,
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: size.width / 1.1,
                child: Text(
                  "Create Account to Continue!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _name,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return 'Please Enter The name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15.0,
                    ),
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _email,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return 'Please Enter The  email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15.0,
                    ),
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _phone,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return 'Please Enter The phone';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15.0,
                    ),
                    prefixIcon: Icon(Icons.lock_outline),
                    hintText: 'Phone',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _password,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return 'Please Enter The password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15.0,
                    ),
                    prefixIcon: Icon(Icons.lock_outline),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              Visibility(
                visible: isLoading,
                child: Container(
                  height: size.height / 14,
                  width: size.width / 1.2,
                  child: ElevatedButton(
                    style:  ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),
                    ),
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        if (_name.text.isNotEmpty &&
                            _email.text.isNotEmpty &&
                            _phone.text.isNotEmpty &&
                            _password.text.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });

                          authService.signUp(_name.text, _email.text,_phone.text, _password.text).then((user) {
                            if (user != null) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (_) => MainPage()));
                              print("Account Created Successfully");
                            } else {
                              print("Login Failed! Please Check Your Credentials");
                              setState(() {
                                isLoading = false;
                              });
                            }
                          });
                        }
                      }
                    },
                    child: Text('Create Account'),
                  ),
                ),
                replacement: CircularProgressIndicator(),
              ),
              SizedBox(
                height: size.height / 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
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

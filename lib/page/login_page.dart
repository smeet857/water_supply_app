import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_supply_app/repo/login_repo.dart';
import 'package:water_supply_app/util/functions.dart';
import 'package:water_supply_app/util/my_colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField("Mobile No", _phoneController),
              SizedBox(
                height: 20,
              ),
              _buildTextField("Password", _passwordController),
              SizedBox(
                height: 50,
              ),
              FlatButton(
                minWidth: double.infinity,
                height: 50,
                color: Mycolor.accent,
                onPressed: _onLoginTap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String title, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Mycolor.accent, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          validator: (value) {
            switch (title) {
              case "Mobile No":
                if (value.isEmpty) {
                  return "Cannot be empty";
                } else if (value.length < 10) {
                  return "Mobile number is not valid";
                }
                return null;
              case "Password":
                if (value.isEmpty) {
                  return "Cannot be empty";
                }
                return null;
              default:
                return null;
            }
          },
          controller: controller,
          cursorColor: Mycolor.accent,
          keyboardType:
              title == "Mobile No" ? TextInputType.number : TextInputType.text,
          maxLength: title == "Mobile No" ? 10 : null,
          minLines: 1,
          maxLines: 1,
          decoration: InputDecoration(
            counterText: "",
            isDense: true,
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mycolor.accent)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mycolor.accent)),
            focusedErrorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mycolor.accent, width: 2)),
          ),
        )
      ],
    );
  }

  void _onLoginTap() {
    if (formKey.currentState.validate()) {
      _apiLogin();
    }
  }

  void _apiLogin() {
    showProgress(context);
    LoginRepo.fetchData(
        phone: _phoneController.text,
        password: _passwordController.text,
        onSuccess: (responce) async {
          Navigator.pop(context);
          if (responce.flag == 1) {
            await saveUser(responce.data);
            toast(responce.message);
            Navigator.pop(context, true);
          }else{
            errorToast(responce.message);
          }
        },
        onError: (error) {
          Navigator.pop(context);
          errorToast("Error on login");
          print("Error on login ===> $error");
        });
  }
}

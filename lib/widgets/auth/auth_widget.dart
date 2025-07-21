import 'package:flutter/material.dart';
import 'package:themoviedb/theme/button_style.dart';
import 'package:themoviedb/widgets/main/main_screen_widget.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login to yout account',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          HeaderWidget(),
        ],
      ),
    );
  }
}

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(fontSize: 16, color: Colors.black);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25),
          _FormWidget(),
          SizedBox(height: 25),
          Text(
            'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple.',
            style: textStyle,
          ),
          SizedBox(height: 5),
          TextButton(
              onPressed: () {},
              style: AppButtonStyle.linkButton,
              child: Text('Register')),
          SizedBox(height: 25),
          Text(
            'If you signed up but didn\'t get your verification email.',
            style: textStyle,
          ),
          SizedBox(height: 5),
          TextButton(
              onPressed: () {},
              style: AppButtonStyle.linkButton,
              child: Text('Verify Email')),
        ],
      ),
    );
  }
}

class _FormWidget extends StatefulWidget {
  const _FormWidget({super.key});

  @override
  State<_FormWidget> createState() => __FormWidgetState();
}

class __FormWidgetState extends State<_FormWidget> {
  final _loginTextController = TextEditingController(text: 'admin');
  final _passwordTextController = TextEditingController(text: 'admin');
  String? errorText = null;

  void _auth() {
    final login = _loginTextController.text;
    final password = _passwordTextController.text;
    if (login == 'admin' && password == 'admin') {
      errorText = null;

      Navigator.of(context).pushReplacementNamed('/main');
    } else {
      errorText = 'Invalid login or password';
      debugPrint(errorText);
    }
    setState(() {});
  }

  void _resetPassword() {
    debugPrint('reset password');
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(fontSize: 16, color: Color(0xFF212529));
    final textFieldDecoration = const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        isCollapsed: true);
    final colorButton = const Color(0xFF01B4E4);
    final errorText = this.errorText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorText != null) ...[
          Text(
            errorText,
            style: TextStyle(color: Colors.red, fontSize: 17),
          ),
          SizedBox(
            height: 10,
          ),
        ],
        Text(
          'Username',
          style: textStyle,
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: _loginTextController,
          decoration: textFieldDecoration,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Password',
          style: textStyle,
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: _passwordTextController,
          decoration: textFieldDecoration,
          obscureText: true,
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          children: [
            ElevatedButton(
                onPressed: _auth,
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(colorButton),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    textStyle: WidgetStatePropertyAll(
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 15, vertical: 8))),
                child: Text('Login')),
            SizedBox(width: 25),
            TextButton(
                onPressed: _resetPassword,
                style: AppButtonStyle.linkButton,
                child: Text('Reset password'))
          ],
        ),
      ],
    );
  }
}

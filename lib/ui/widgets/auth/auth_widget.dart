import 'package:flutter/material.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/theme/button_style.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';

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
        title: const Text(
          'Login to yout account',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const HeaderWidget(),
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
    const textStyle = TextStyle(fontSize: 16, color: Colors.black);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          const _FormWidget(),
          const SizedBox(height: 25),
          const Text(
            'In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple.',
            style: textStyle,
          ),
          const SizedBox(height: 5),
          TextButton(
              onPressed: () {},
              style: AppButtonStyle.linkButton,
              child: const Text('Register')),
          const SizedBox(height: 25),
          const Text(
            'If you signed up but didn\'t get your verification email.',
            style: textStyle,
          ),
          const SizedBox(height: 5),
          TextButton(
              onPressed: () {},
              style: AppButtonStyle.linkButton,
              child: const Text('Verify Email')),
        ],
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthModel>(context);

    const textStyle = TextStyle(fontSize: 16, color: Color(0xFF212529));
    const textFieldDecoration = InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        isCollapsed: true);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ErrorMessageWidget(),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Username',
          style: textStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: model?.loginTextController,
          decoration: textFieldDecoration,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Password',
          style: textStyle,
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: model?.passwordTextController,
          decoration: textFieldDecoration,
          obscureText: true,
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            const _AuthButtonWidget(),
            const SizedBox(width: 25),
            TextButton(
                onPressed: () {},
                style: AppButtonStyle.linkButton,
                child: const Text('Reset password'))
          ],
        ),
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget();

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AuthModel>(context);
    const colorButton = Color(0xFF01B4E4);
    final onPressed =
        model?.canStartAuth == true ? () => model?.auth(context) : null;

    final child = model?.isAuthProgress == true
        ? const SizedBox(
            width: 15,
            height: 15,
            child:
                CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          )
        : const Text('Login');

    return ElevatedButton(
        onPressed: onPressed,
        style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(colorButton),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            textStyle: WidgetStatePropertyAll(
                TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ))),
        child: child);
  }
}

class _ErrorMessageWidget extends StatefulWidget {
  const _ErrorMessageWidget();

  @override
  State<_ErrorMessageWidget> createState() => _ErrorMessageWidgetState();
}

class _ErrorMessageWidgetState extends State<_ErrorMessageWidget> {
  AuthModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newModel = NotifierProvider.read<AuthModel>(context);
    if (_model != newModel) {
      _model?.removeListener(_onModelChanged);
      _model = newModel;
      _model?.addListener(_onModelChanged);
    }
  }

  @override
  void dispose() {
    _model?.removeListener(_onModelChanged);
    super.dispose();
  }

  void _onModelChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final errorMessage = _model?.errorMessage;

    if (errorMessage == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red, fontSize: 17),
      ),
    );
  }
}

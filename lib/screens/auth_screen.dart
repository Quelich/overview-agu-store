import 'package:agu_store_flutter/providers/email_signin_provider.dart';
import 'package:agu_store_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { signup, login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Center(
            child: Card(
              shadowColor: kMainTheme,
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        buildEmailField(),
                        if (!provider.isLogin) buildUsernameField(),
                        buildPasswordField(),
                        const SizedBox(height: 12),
                        buildButton(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUsernameField() {
    final provider = Provider.of<EmailSignInProvider>(context);

    return TextFormField(
      key: const ValueKey('username'),
      autocorrect: true,
      textCapitalization: TextCapitalization.words,
      enableSuggestions: false,
      validator: (value) {
        if (value != null && value.isEmpty ||
            value != null && value.length < 4 ||
            value != null && value.contains(' ')) {
          return 'Please enter at least 4 characters without space';
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(labelText: 'Username'),
      onSaved: (username) => provider.userName = username!,
    );
  }

  Widget buildButton(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);

    if (provider.isLoading) {
      return const CircularProgressIndicator();
    } else {
      return Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: kMainTheme,
              fixedSize: const Size(120, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: kFontFamily2,
              ),
            ),
            child: Text(provider.isLogin ? 'Login' : 'Signup'),
            onPressed: () => submit(),
          ),
          TextButton(
            child: Text(
              provider.isLogin
                  ? 'Create new account'
                  : 'I already have an account',
              style: const TextStyle(
                color: kMainTheme,
                fontSize: 16,
              ),
            ),
            onPressed: () => provider.isLogin = !provider.isLogin,
          ),
        ],
      );
    }
  }

  Widget buildEmailField() {
    final provider = Provider.of<EmailSignInProvider>(context);

    return TextFormField(
      key: const ValueKey('email'),
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      enableSuggestions: false,
      validator: (value) {
        const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
        final regExp = RegExp(pattern);

        if (!regExp.hasMatch(value!)) {
          return 'Enter a valid mail';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(labelText: 'Email address'),
      onSaved: (email) => provider.userEmail = email!,
    );
  }

  Widget buildPasswordField() {
    final provider = Provider.of<EmailSignInProvider>(context);

    return TextFormField(
      key: const ValueKey('password'),
      validator: (value) {
        if (value != null && value.isEmpty ||
            value != null && value.length < 7) {
          return 'Password must be at least 7 characters long.';
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true,
      onSaved: (password) => provider.userPassword = password!,
    );
  }

  Future submit() async {
    final provider = Provider.of<EmailSignInProvider>(context, listen: false);

    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid!) {
      _formKey.currentState?.save();

      final isSuccess = await provider.login();

      if (isSuccess) {
        //attach orders to user
      }
    }
  }
}

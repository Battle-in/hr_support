import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:hr_support/redux/app_state.dart';
import 'package:hr_support/redux/actions.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Center(
        child: Container(
      height: screen.height >= 450 ? 450 : screen.height,
      width: screen.width >= 400 ? 400 : screen.width,
      decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                offset: const Offset(5, 5))
          ]),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Авторизация',
              style: Theme.of(context).textTheme.headline3,
            ),
            TextField(
              onSubmitted: (val) => passwordFocus.requestFocus(),
              controller: _loginController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'login'),
            ),
            TextField(
              focusNode: passwordFocus,
              onSubmitted: (val) => _login(context),
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'password'),
            ),
            TextButton(onPressed: () => _login(context),
                child: const Text('Войти'))
          ],
        ),
      ),
    ));
  }

  void _login(BuildContext context){
    store.dispatch(
        LoginAction(
            login: _loginController.text,
            password: _passwordController.text,
            context: context,
            store: store
        ));
  }
}

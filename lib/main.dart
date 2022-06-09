import 'package:flutter/material.dart';
import 'package:hr_support/screens/home.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:hr_support/redux/app_state.dart';
import 'package:hr_support/redux/reducer.dart';
import 'package:hr_support/redux/middleware.dart';

import 'package:hr_support/screens/login.dart';
import 'package:hr_support/redux/actions.dart';

main() => runApp(MyApp(store: makeStore(),));

Store<AppState> makeStore(){
  Store<AppState> store = Store<AppState>(reducer,
      initialState: AppState(
        mainScreen: Container(),
        staff: [],
        medExams: [],
        briefings: [],
        complaints: [],
      ),
      middleware: [loaderMiddleware]
  );
  store.dispatch(
      SetMainScreenAction(newMainScreen: HomeScreen(store: store,)));
  //on release change LoginScreen(store: store,)
  return store;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: StoreConnector<AppState, Widget>(
            builder: (context, value){
              return value;
            },
            converter: (store) => store.state.mainScreen,
          ),
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knesset_app/app_bar.dart';
import 'package:knesset_app/models/app_state.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:knesset_app/reducers/members_reducer.dart';
import 'package:knesset_app/viewModels/main_view_model.dart';
import 'package:knesset_app/views/mk_list_widget.dart';
import 'package:knesset_app/views/vote_totals_widget.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  runApp(StoreProvider<AppState>(
      store: Store<AppState>(
        appStateReducer,
        initialState: AppState([], Vote({})),
        middleware: [thunkMiddleware],
      ),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(
        converter: (store) => () => store.dispatch(loadAction),
        onInitialBuild: (callback) => callback(),
        builder: (context, callback) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(),
          );
        });
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MainViewModel>(
      converter: (store) => MainViewModel(store.state.members),
      builder: (context, viewModel) {
        return Scaffold(
            appBar: MyAppBar(),
            body: viewModel.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      VoteTotalsWidget(),
                      Expanded(
                        child: MkListWidget(),
                      ),
                    ],
                  ));
      },
    );
  }
}

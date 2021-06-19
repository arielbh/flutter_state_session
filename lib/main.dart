import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knesset_app/app_bar.dart';
import 'package:knesset_app/providers/providers.dart';
import 'package:knesset_app/views/mk_list_widget.dart';
import 'package:knesset_app/views/vote_totals_widget.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(appBar: MyAppBar(), body: MyHomePage()),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context, ScopedReader watch) {
    final members = watch(membersProvider);
    return members.when(
      data: (data) => Column(
        children: [
          VoteTotalsWidget(),
          Expanded(
            child: MkListWidget(
              members: data.toList(),
            ),
          ),
        ],
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Text("Try again later."),
    );
  }
}

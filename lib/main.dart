import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:knesset_app/app_bar.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:knesset_app/services/mk_data_service.dart';
import 'package:knesset_app/views/mk_list_widget.dart';
import 'package:knesset_app/views/vote_totals_widget.dart';

final locator = GetIt.instance;

void main() {
  locator.registerLazySingleton<MkDataService>(() => MkDataService());
  locator.registerLazySingleton<Vote>(() => Vote({}));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget with GetItMixin {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final members =
        watchFuture<MkDataService, Iterable<KnessetMember>>((MkDataService service) => service.getMembers(), []).data;

    return Scaffold(
        appBar: MyAppBar(),
        body: members?.isEmpty ?? true
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  VoteTotalsWidget(),
                  Expanded(
                    child: MkListWidget(members: members?.toList() ?? []),
                  ),
                ],
              ));
  }
}

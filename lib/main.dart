import 'package:flutter/material.dart';
import 'package:knesset_app/app_bar.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:knesset_app/services/mk_data_service.dart';
import 'package:knesset_app/views/mk_list_widget.dart';
import 'package:knesset_app/views/vote_totals_widget.dart';
import 'package:provider/provider.dart';

//TODO: Empasize the root provider and Vote is now notifier
void main() {
  runApp(MultiProvider(
    providers: [
      Provider<MkDataService>(create: (_) => MkDataService()),
      ChangeNotifierProvider(create: (_) => Vote({})),
    ],
    child: MyApp(),
  ));
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
//TODO: Empasize how most widgets (except vote, tell them why) are now stateless
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: FutureBuilder<Iterable<KnessetMember>>(
            future: context.watch<MkDataService>().getMembers(),
            initialData: [],
            builder: (context, result) {
              final members = result.data?.toList() ?? [];
              return members.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : Column(children: [
                      VoteTotalsWidget(),
                      Expanded(
                        child: MkListWidget(members: members),
                      ),
                    ]);
            }));
  }
}

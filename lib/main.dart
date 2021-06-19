import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knesset_app/app_bar.dart';
import 'package:knesset_app/blocs/members_bloc.dart';
import 'package:knesset_app/blocs/vote_bloc.dart';
import 'package:knesset_app/services/mk_data_service.dart';
import 'package:knesset_app/views/mk_list_widget.dart';
import 'package:knesset_app/views/vote_totals_widget.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<MembersBloc>(
      create: (context) => MembersBloc(dataService: MkDataService()),
    ),
    BlocProvider<VoteBloc>(
      create: (context) => VoteBloc(),
    ),
  ], child: MyApp()));
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
        body: BlocBuilder<MembersBloc, MembersState>(
          builder: (context, membersState) {
            return BlocBuilder<VoteBloc, VoteState>(builder: (context, votingState) {
              if (membersState is MembersInitial) {
                return CircularProgressIndicator();
              }
              if (membersState is MembersLoadedState) {
                return Column(
                  children: [
                    VoteTotalsWidget(),
                    Expanded(
                      child: MkListWidget(members: membersState.members.toList()),
                    ),
                  ],
                );
              }
              return Center(child: Text("Something went wrong"));
            });
          },
        ));
  }
}

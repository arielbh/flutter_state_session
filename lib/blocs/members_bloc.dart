import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/services/mk_data_service.dart';
import 'package:meta/meta.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  final MkDataService dataService;
  MembersBloc({required this.dataService}) : super(MembersInitial()) {
    dataService.getMembers().then((members) => add(OnMembersLoadedEvent(members)));
  }

  @override
  Stream<MembersState> mapEventToState(MembersEvent event) async* {
    if (event is OnMembersLoadedEvent) {
      yield MembersLoadedState(event.members);
    }
  }
}

@immutable
abstract class MembersEvent {}

class OnMembersLoadedEvent extends MembersEvent {
  final Iterable<KnessetMember> members;
  OnMembersLoadedEvent(this.members);
}

@immutable
abstract class MembersState {}

class MembersInitial extends MembersState {}

class MembersLoadedState extends MembersState {
  final Iterable<KnessetMember> members;
  MembersLoadedState(this.members);
}

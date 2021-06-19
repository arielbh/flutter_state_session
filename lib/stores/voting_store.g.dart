// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voting_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VotingStore on _VotingStore, Store {
  final _$secondsToVoteAtom = Atom(name: '_VotingStore.secondsToVote');

  @override
  int get secondsToVote {
    _$secondsToVoteAtom.reportRead();
    return super.secondsToVote;
  }

  @override
  set secondsToVote(int value) {
    _$secondsToVoteAtom.reportWrite(value, super.secondsToVote, () {
      super.secondsToVote = value;
    });
  }

  final _$_VotingStoreActionController = ActionController(name: '_VotingStore');

  @override
  void startTimer() {
    final _$actionInfo = _$_VotingStoreActionController.startAction(
        name: '_VotingStore.startTimer');
    try {
      return super.startTimer();
    } finally {
      _$_VotingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
secondsToVote: ${secondsToVote}
    ''';
  }
}

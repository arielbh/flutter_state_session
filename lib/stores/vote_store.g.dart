// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VoteStore on _VoteStore, Store {
  final _$voteAtom = Atom(name: '_VoteStore.vote');

  @override
  Vote get vote {
    _$voteAtom.reportRead();
    return super.vote;
  }

  @override
  set vote(Vote value) {
    _$voteAtom.reportWrite(value, super.vote, () {
      super.vote = value;
    });
  }

  final _$_VoteStoreActionController = ActionController(name: '_VoteStore');

  @override
  void addVote(KnessetMember member, VoteOptions voteOption) {
    final _$actionInfo =
        _$_VoteStoreActionController.startAction(name: '_VoteStore.addVote');
    try {
      return super.addVote(member, voteOption);
    } finally {
      _$_VoteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
vote: ${vote}
    ''';
  }
}

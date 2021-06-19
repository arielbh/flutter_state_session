// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Vote on VoteBase, Store {
  final _$votesAtom = Atom(name: 'VoteBase.votes');

  @override
  ObservableMap<KnessetMember, VoteOptions> get votes {
    _$votesAtom.reportRead();
    return super.votes;
  }

  @override
  set votes(ObservableMap<KnessetMember, VoteOptions> value) {
    _$votesAtom.reportWrite(value, super.votes, () {
      super.votes = value;
    });
  }

  @override
  String toString() {
    return '''
votes: ${votes}
    ''';
  }
}

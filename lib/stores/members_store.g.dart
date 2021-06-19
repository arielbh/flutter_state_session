// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MembersStore on _MembersStore, Store {
  final _$membersAtom = Atom(name: '_MembersStore.members');

  @override
  List<KnessetMember> get members {
    _$membersAtom.reportRead();
    return super.members;
  }

  @override
  set members(List<KnessetMember> value) {
    _$membersAtom.reportWrite(value, super.members, () {
      super.members = value;
    });
  }

  final _$loadAsyncAction = AsyncAction('_MembersStore.load');

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  @override
  String toString() {
    return '''
members: ${members}
    ''';
  }
}

import 'package:knesset_app/models/mk.dart';

class MainViewModel {
  final List<KnessetMember> _members;
  bool get isEmpty => _members.isEmpty;
  MainViewModel(this._members);
}

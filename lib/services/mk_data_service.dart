import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:knesset_app/models/mk.dart';

class MkDataService {
  Future<Iterable<KnessetMember>> getMembers() async {
    var jsonText = await rootBundle.loadString('assets/mks.json');
    final List<dynamic> decoded = json.decode(jsonText);
    return decoded.map((e) => KnessetMember(e["name"]));
  }
}

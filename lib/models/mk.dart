class KnessetMember {
  final String name;

  KnessetMember(this.name);

  @override
  bool operator ==(other) {
    return (other is KnessetMember) && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

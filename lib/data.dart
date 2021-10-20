class Kid {
  final String name;
  final DateTime birth;

  Kid(this.name, this.birth);
}

final List<Kid> kids = [
  Kid('Kid 1', DateTime(2021, 08, 30)),
  Kid('Kid 2', DateTime(2021, 07, 29)),
];

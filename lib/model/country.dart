class Country {
  Country({
    required this.fullName,
    required this.shortNames,
  }) : shortName = shortNames.length == 1 ? shortNames[0] : null;
  final String fullName;
  final List<String> shortNames;
  final String? shortName;
}

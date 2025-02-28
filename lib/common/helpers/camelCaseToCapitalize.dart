class camelCaseToCapitalize {
  String process(String inp) {
    return inp
        .replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (Match match) {
          return '${match.group(1)} ${match.group(2)}';
        })
        .toLowerCase()
        .split(' ')
        .map((word) {
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }
}

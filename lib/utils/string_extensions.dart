extension StringExtensions on String {
  String toPrice() {
    final regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return replaceAllMapped(regExp, (Match match) => '${match[1]},');
  }
}

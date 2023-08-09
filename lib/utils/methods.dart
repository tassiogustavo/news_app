class Methods {
  static String convertDateHour(String dateToParse) {
    DateTime date = DateTime.parse(dateToParse);

    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} "
        "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}";
  }

  static String convertDate(String dateToParse) {
    DateTime date = DateTime.parse(dateToParse);

    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ";
  }
}

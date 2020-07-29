class Extras {
  static String monthToText(int month) {
    final List months = [
      'ENE',
      'FEB',
      'MAR',
      'ABR',
      'MAY',
      'JUN',
      'JUL',
      'AGO',
      'SEP',
      'OCT',
      'NOV',
      'DIC'
    ];
    return months[month - 1];
  }

  static String fromNow(DateTime dateTime) {
    final DateTime currentDateTime = DateTime.now();
    final int minutes = currentDateTime.difference(dateTime).inMinutes;
    if (minutes < 60) {
      return 'Hace $minutes minutos';
    } else if (minutes >= 60 && minutes <= 60 * 23) {
      return 'Hace ${(minutes / 60).ceil()} horas';
    } else if (minutes > 60 * 23 && minutes < 60 * 24 * 4) {
      return 'Hace ${(minutes / (60 * 24)).ceil()} días';
    } else {
      return '${dateTime.day < 10 ? "0" : ""}${dateTime.day} / ${monthToText(dateTime.month)} / ${dateTime.year}';
    }
  }
}

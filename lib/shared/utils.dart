import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

extension StringExt on String {
  String get currencyFormatRp => NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp. ',
        decimalDigits: 0,
      ).format(int.parse(this));
}

String formatCurrency(String value) {
  if (int.parse(value) >= 1000000000) {
    double result = int.parse(value) / 1000000000.0;
    return ('Rp ${result.toStringAsFixed(2)} Miliar').replaceAll('.', ',');
  } else if (int.parse(value) >= 1000000) {
    double result = int.parse(value) / 1000000.0;
    return ('Rp ${result.toStringAsFixed(2)} Juta').replaceAll('.', ',');
  } else {
    return '${value.currencyFormatRp}';
  }
}

String calculateTimeDifference(String apiTimeString) {
  // Konversi string waktu dari API menjadi objek DateTime
  DateTime apiTime = DateTime.parse(apiTimeString);

  // Waktu saat ini
  DateTime currentTime = DateTime.now();

  // Hitung selisih waktu
  Duration difference = currentTime.difference(apiTime);

  if (difference.inMinutes < 1) {
    return 'Baru saja';
  } else if (difference.inHours < 1) {
    int minutes = difference.inMinutes;
    return '$minutes menit yang lalu';
  } else if (difference.inDays < 1) {
    int hours = difference.inHours;
    return '$hours jam yang lalu';
  } else if (difference.inDays < 30) {
    int days = difference.inDays;
    return '$days hari yang lalu';
  } else if (difference.inDays < 365) {
    int months = (difference.inDays / 30).floor();
    return '$months bulan yang lalu';
  } else {
    int years = (difference.inDays / 365).floor();
    return '$years tahun yang lalu';
  }
}

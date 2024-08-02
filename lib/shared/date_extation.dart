// 2020-11-05T17:32:26.066
// to
// 2020/11/05 13:52
String getFormattedDate(DateTime? date) {
  if (date == null) {
    return '';
  }
  final sDate = date.toIso8601String();
  final t = sDate.split('T');
  var temp = t.first.split('-');
  final finalDate = '${temp[1]}/${temp[2]}';
  temp = t[1].split(':');
  final finalTime = '${temp[0]}:${temp[1]}';
  return '$finalDate $finalTime';
}

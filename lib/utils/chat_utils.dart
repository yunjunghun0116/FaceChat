bool showDate(String? lastDate, String newDate) {
  if (lastDate == null) return true;
  DateTime lastDateTime = DateTime.parse(lastDate);
  DateTime newDateTime = DateTime.parse(newDate);
  return (lastDateTime.year != newDateTime.year ||
      lastDateTime.month != newDateTime.month ||
      lastDateTime.day != newDateTime.day);
}

bool showImage(String? lastSenderId, String senderId) {
  if (lastSenderId == null) return true;
  return lastSenderId != senderId;
}

import '../core.dart';

textInter(String title, Color color, FontWeight fw, double fs) {
  return Text(title,
      style: GoogleFonts.inter(color: color, fontWeight: fw, fontSize: fs));
}

Future selectDate(BuildContext context) async {
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime(2026),
    firstDate: DateTime(1900),
    lastDate: DateTime(2026),
  );

  if (pickedDate != null) {
    return pickedDate;
  }
  return;
}

bool isOverdue(DateTime? deadline) {
  if (deadline == null) return false;
  return DateTime.now().isAfter(deadline);
}

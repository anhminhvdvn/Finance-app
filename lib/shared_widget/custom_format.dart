import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberInputFormatter extends TextInputFormatter {
  final NumberFormat numberFormat =
      NumberFormat('#,###'); // Định dạng số với dấu phẩy

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Loại bỏ dấu phẩy để giữ giá trị thực
    String cleanedText = newValue.text.replaceAll(',', '');

    // Kiểm tra nếu không phải số thì giữ giá trị cũ
    if (int.tryParse(cleanedText) == null) {
      return oldValue;
    }

    // Thêm dấu phẩy vào
    String formattedText = numberFormat.format(int.parse(cleanedText));
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

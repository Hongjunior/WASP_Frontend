import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends StatelessWidget {
  final DateTime selectedDate;
  final void Function(String event) onEventAdded;

  const AddEventScreen({
    required this.selectedDate,
    required this.onEventAdded,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return AlertDialog(
      title: const Text('일정 추가'),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              DateFormat.yMMMd().format(selectedDate),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: '일정 입력',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              onEventAdded(controller.text);
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFCC16), // 버튼 배경색
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text('일정 추가'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
      ],
    );
  }
}

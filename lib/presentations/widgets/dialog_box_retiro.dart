import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BoxDialogRetiro extends StatelessWidget {
  VoidCallback onCancel;

  BoxDialogRetiro({
    super.key,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[200],
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Su va a liberar el puesto P1',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            MaterialButton(onPressed: onCancel, child: const Text('ok')),
            MaterialButton(onPressed: onCancel, child: const Text('cancelar')),
          ],
        ),
      ),
    );
  }
}

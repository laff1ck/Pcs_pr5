import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: const Center(
        child: Text(
          'Хмырин Алексей Андреевич ЭФБО-02-22',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

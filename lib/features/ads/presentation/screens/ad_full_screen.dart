import 'package:flutter/material.dart';

class AdFullScreen extends StatelessWidget {
  const AdFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ad Full Screen')),
      body: Center(child: const Text('Ya puedes regresar o vre esta pantalla')),
    );
  }
}

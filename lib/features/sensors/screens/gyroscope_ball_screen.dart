import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reforzamiento/features/sensors/sensors.dart';

class GyroscopeBallScreen extends StatefulWidget {
  const GyroscopeBallScreen({super.key});

  @override
  State<GyroscopeBallScreen> createState() => _GyroscopeBallScreenState();
}

class _GyroscopeBallScreenState extends State<GyroscopeBallScreen> {
  late final SensorsBloc sensorsBloc;

  @override
  void initState() {
    super.initState();
    sensorsBloc = context.read<SensorsBloc>();
    sensorsBloc.gyroscopeStart();
  }

  @override
  void dispose() {
    sensorsBloc.sensorsStop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GyroscopeBallScreen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
      ),
      body: BlocBuilder<SensorsBloc, SensorsState>(
        builder: (context, state) {
          if (state is SensorsGyroscope) {
            return SizedBox.expand(
              child: MovingBall(x: state.x, y: state.y),
            );
          }
          return Center(
            child: const CircularProgressIndicator(),
          ); // Mientras arranca el sensor
        },
      ),
    );
  }
}

class MovingBall extends StatelessWidget {
  final double x;
  final double y;
  const MovingBall({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double screenWidth = size.width;
    double screenHeight = size.height;
    double currentYPos = (y * 150);
    double currentXPos = (x * 200);

    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        AnimatedPositioned(
          left: (currentYPos - 25) + (screenWidth / 2),
          top: (currentXPos - 25) + (screenHeight / 2),
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 1000),
          child: Ball(),
        ),

        Text('''
      X:${x.toStringAsFixed(2)},
      Y:${y.toStringAsFixed(2)},
      ''', style: const TextStyle(fontSize: 30)),
      ],
    );
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}

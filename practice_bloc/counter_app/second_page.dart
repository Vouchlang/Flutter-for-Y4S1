import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/counter_bloc.dart';
import 'bloc/counter_state.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Page")),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Text(
              "Count is: ${state.count}",
              style: TextStyle(fontSize: 30),
            );
          },
        ),
      ),
    );
  }
}
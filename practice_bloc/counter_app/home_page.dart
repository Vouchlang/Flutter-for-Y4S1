import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/counter_bloc.dart';
import 'bloc/counter_event.dart';
import 'bloc/counter_state.dart';
import 'second_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter App with BLoC")),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SecondPage()),
                );
              },
              child: Text('Count: ${state.count}'),
            );})
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "increment_fab",
            onPressed: () => context.read<CounterBloc>().add(Increment()),
            child: Icon(Icons.add),
          ),
                    FloatingActionButton(
            heroTag: "decrement_fab",
            onPressed: () => context.read<CounterBloc>().add(Decrement()),
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
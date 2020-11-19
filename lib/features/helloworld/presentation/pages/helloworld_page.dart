import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/helloworld/presentation/bloc/helloworld_bloc.dart';
import 'package:myapp/injection_container.dart';

class HelloWorldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello World'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<HelloworldBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HelloworldBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
              BlocBuilder<HelloworldBloc, HelloworldState>(
                builder: (context, state) {
                  if (state is HelloworldInitial) {
                    return Container(color: Colors.red);
                  } else {
                    return Container(color: Colors.green);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

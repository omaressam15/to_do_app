import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/CubetForDatabase/AppCubet.dart';
import 'package:to_do_app/CubetForDatabase/AppState.dart';
import 'package:to_do_app/components.dart';

class DoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var tasks = AppCubit.get(context).doneTasks;

        return conditionalItem(tasks: tasks);
      },
    );
  }
}

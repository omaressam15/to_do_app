
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Cube/cubit.dart';
import 'package:to_do_app/Cube/stats.dart';

class Counter extends StatelessWidget {

  int counter = 1;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
        listener: (context,state){

          if(state is CounterPlusState){

            print(state.counter);

          }

        },
        builder: (context,stat){
          return  Scaffold(
            body: Center(
              child: Row(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  TextButton(onPressed: (){

                    CounterCubit.get(context).minus();


                  }, child: Text(
                    'mines',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

                  ),),

                  Text('${CounterCubit.get(context).counter}',style: TextStyle(fontSize: 40),),

                  TextButton(onPressed: (){

                    CounterCubit.get(context).plus();

                  }, child: Text(
                    'plus',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

                  ),),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

}




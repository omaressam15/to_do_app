
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Cube/stats.dart';

class CounterCubit extends Cubit<CounterStates>{

  CounterCubit() : super(CounterInitialState());

  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 1 ;

  void plus(){

    counter ++;
    emit(CounterPlusState(counter));

  }
 void minus(){

    counter --;
    emit(CounterMinesState(counter));

  }


}
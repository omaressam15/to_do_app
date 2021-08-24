abstract class CounterStates {}

class CounterInitialState extends CounterStates {}

class CounterPlusState extends CounterStates{

  final int counter;

  CounterPlusState(this.counter);

}

class CounterMinesState extends CounterStates{

  final int counter;

  CounterMinesState(this.counter);



}
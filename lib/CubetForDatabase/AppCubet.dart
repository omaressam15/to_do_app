import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/CubetForDatabase/AppState.dart';
import 'package:to_do_app/atchved_screen/atchved_screen.dart';
import 'package:to_do_app/done_screen/done_screen.dart';
import 'package:to_do_app/task_screens/task_screen.dart';

class AppCubit extends Cubit <AppState>{

  AppCubit() : super(InitialState());


  static AppCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  Database database;

  bool isButtonSheet = false;

  IconData icons = Icons.edit;

  List <Map> newTasks = [];
  List <Map> doneTasks = [];
  List <Map> achievedTasks = [];

  List <Widget> widgetList = [

    TaskScreen(),

    DoneScreen(),

    AchievedScreen(),

  ];

  List <String> text = [

    'Task', 'Done', 'achieved',

  ];


  void changeButtonNavigationBar(int index) {

     selectedIndex = index;

     emit(ChangeButtonNavigationBarState());

  }

  updateDatabase({@required states,@required id}) {
    return database.rawUpdate(
        'UPDATE task SET status = ?  WHERE id = ?',

        ['$states', id]).then((value) {

          getFromDatabase(database);
          emit(UpdateDataBaseState());

    });

  }

  void createDatabase() {

     openDatabase('todo.db',

        version: 1,

        onCreate: (database, version) {
          print('database created');

          database.execute(
              'CREATE TABLE task (id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT )')
              .then((value) {

            print('table created');
          }).catchError((onError) {
            print('Error when created table ${onError.toString()}');
          });
        },

        onOpen: (database) {
          getFromDatabase(database);
          print('database open');
        }
    ).then((value) {
      database = value;
      emit(CreateDataBaseState());
     });

  }

  void deleteDatabase ({@required int id})async{

    database.rawDelete('DELETE FROM task WHERE id = ?', [id]).then((value) {
      getFromDatabase(database);
      emit(DeleteDataBaseState());
    });

  }

  void getFromDatabase (database) {

    newTasks = [];
    doneTasks= [];
    achievedTasks = [];

    emit(LoadingScreenState());

     database.rawQuery('SELECT * FROM task').then((value) {


      value.forEach((element) {

        if(element['status'] =='new')
          newTasks.add(element);

          else if(element['status'] == 'done')
          doneTasks.add(element);

          else
            achievedTasks.add(element);

        print(element['status']);

        emit(GetDataBaseState());



      });



    });

  }

  Future insertToDatabase({@required title, @required date, @required time}) {

    return database.transaction((txn) {

      txn.rawInsert('INSERT INTO task (title, date, time, status) VALUES ("$title" , "$date" , "$time" , "new")')
          .then((value) {
            emit(InsertDataBaseState());
        print('$value inserted successfully');

            getFromDatabase(database);

      }).catchError((error){

        print('Error When Inserting New Record ${error.toString ()}');

      });

      return null;

    });

  }

  void changeButtonSheets ({@required  IconData iconData ,@required bool isShow}){
    
    isButtonSheet = isShow;
    
    icons = iconData;
    
    emit(ChangeSheetState());


  }

}


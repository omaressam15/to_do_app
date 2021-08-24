import 'package:conditional_builder/conditional_builder.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/CubetForDatabase/AppCubet.dart';
import 'package:to_do_app/CubetForDatabase/AppState.dart';
import '../components.dart';



class HomeScreen extends StatelessWidget{

  var titleText =  TextEditingController();

  var setTime =  TextEditingController();
  
  var setDate = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(

      create: (BuildContext context)=>AppCubit()..createDatabase(),

      child: BlocConsumer<AppCubit,AppState>(
        listener: (BuildContext context, state) {

          if(state is InsertDataBaseState){

            Navigator.pop(context);

          }

        },
        builder: (BuildContext context, state) {

          AppCubit appCubit = BlocProvider.of(context);

          return  Scaffold(

            key: scaffoldKey,

            floatingActionButton: FloatingActionButton(

              child: Icon(appCubit.icons, size: 25,),

              onPressed: () {

                //law be true hymle validate we law mash be true hyft7 al buttonSheet BAS kada

                if(appCubit.isButtonSheet){

                  print("${appCubit.isButtonSheet}");

                  if(formKey.currentState.validate()){

                    appCubit.insertToDatabase(title: titleText.text, date:setDate.text , time: setTime.text);
                  }
                }else{

                  appCubit.changeButtonSheets(iconData: Icons.add, isShow: true);

                  scaffoldKey.currentState.showBottomSheet((context) => Container(

                    padding: EdgeInsets.all(20),

                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [

                          defaultFormField(

                              controller:titleText,

                              iconData: Icons.text_fields,

                              label: 'Task',

                              textInputType: TextInputType.name,

                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Task can\'t be empty ';
                                } else {
                                  return null;
                                }
                              }
                          ),


                          SizedBox(
                            height: 20,
                          ),

                          defaultFormField(

                              controller:setTime,

                              iconData: Icons.watch_later_outlined,

                              label: 'Time',

                              onTap:(){

                                showTimePicker(context: context,

                                  initialTime: TimeOfDay.now(),

                                ).then((value) {
                                  setTime.text = value.format(context).toString();
                                });
                              },
                              textInputType: TextInputType.datetime,

                              validator: (String value){

                                if (value.isEmpty) {
                                  return 'Time can\'t be empty ';
                                } else {
                                  return null;
                                }

                              }
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          defaultFormField(

                              controller:setDate,

                              iconData: Icons.calendar_today_outlined,

                              label: 'Date',

                              onTap:(){

                                showDatePicker(context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2021-09-11'),

                                ).then((value) {
                                  setDate.text = DateFormat.yMMMd().format(value);
                                  print(DateFormat.yMMMd().format(value));

                                });
                              },

                              textInputType: TextInputType.datetime,

                              validator: (String value){

                                if (value.isEmpty) {
                                  return 'Date can\'t be empty ';
                                } else {
                                  return null;
                                }

                              }

                          ),
                        ],

                      ),
                    ),

                    width: double.infinity ,

                    color: Colors.white70,
                  ),

                    elevation: 20,

                  ).closed.then((value) {

                   appCubit.changeButtonSheets(iconData: Icons.edit, isShow: false);


                  });

                }
              },

            ),

            appBar: AppBar(
              title: Text(
                appCubit.text[appCubit.selectedIndex],

              ),
            ),

            bottomNavigationBar: CurvedNavigationBar(

              backgroundColor: Colors.black,

              height: 75,
              items: [

                Icon(Icons.menu, size: 35),

                Icon(Icons.check_circle_outline, size: 35),

                Icon(Icons.archive_outlined, size: 35),


              ],

              onTap: (int index) {

               appCubit.changeButtonNavigationBar(index);


              },

            ),


            body:ConditionalBuilder(
              builder:(context)=> appCubit.widgetList[appCubit.selectedIndex],
              condition: state is! LoadingScreenState,
              fallback: (context)=> Center(child: CircularProgressIndicator()) ,
            ),

          );
        },


      ),
    );
  }


}

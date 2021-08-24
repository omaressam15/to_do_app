import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/CubetForDatabase/AppCubet.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType textInputType,
  @required Function validator,
  @required String label,
  @required IconData iconData,
  bool isPassword = false,
  Function onTap,
  IconData suffix,
  Function isPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: isPassword,
      onTap: onTap,
      onFieldSubmitted: (String value) {
        print(value);
      },
      onChanged: (String value) {
        print(value);
      },
      validator: validator,
      decoration: InputDecoration(
        labelText: label,

        prefixIcon: Icon(iconData),

        suffixIcon: suffix != null
            ? InkWell(onTap: isPressed, child: Icon(suffix)) : null,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );

 Widget buildTaskItem(Map model,context)=> Dismissible(
   
   key: Key(model['id'].toString()),

   onDismissed: (direction){

     AppCubit.get(context).deleteDatabase(id: model['id'],);

   },

   child: Padding(
      padding: EdgeInsets.all(15),
      child: Row(

        children: [

          CircleAvatar(
            radius: 35,
            child: Text(model['time']),

          ),

          SizedBox(
            width: 15,
          ),

          Expanded(
            child: Column(

              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text('${model['title']}',style: TextStyle(fontSize: 20,color: Colors.black,
                    fontWeight: FontWeight.bold),),
                Text('${model['date']}',style: TextStyle(color: Colors.grey),),

              ],

            ),
          ),

          IconButton(onPressed: (){

            AppCubit.get(context).updateDatabase(states:'done', id: model['id']);

          },

              icon: Icon(Icons.check_box_rounded),
            color: Colors.green,

          ),
          SizedBox(
            width: 20,
          ),
          IconButton(onPressed: (){

            AppCubit.get(context).updateDatabase(states:'achieved', id: model['id']);

          },

              icon: Icon(Icons.archive),

            color: Colors.grey,

          ),

        ],

      ),
    ),
 );

 Widget conditionalItem({@required List<Map>tasks})=> ConditionalBuilder(
   builder:(context)=> ListView.separated(
       itemBuilder: (context, index) =>
           buildTaskItem(tasks[index], context),
       separatorBuilder: (context, index) => Container(
         width: double.infinity,
         color: Colors.grey,
         height: 0.5,
       ),
       itemCount: tasks.length),
   condition:tasks.length >0 ,
   fallback:(context)=>Center(
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Icon(Icons.event_note_outlined,color: Colors.grey,size: 90,),
         SizedBox(
           height: 15,
         ),
         Text('Task is Empty!',style: TextStyle(color: Colors.grey,fontSize: 23,fontWeight: FontWeight.bold),)
       ],
     ),
   ),


 );


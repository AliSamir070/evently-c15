import 'package:evently_c15/core/remote/network/FirestoreManager.dart';
import 'package:evently_c15/core/resources/ColorManager.dart';
import 'package:evently_c15/ui/home/tabs/home_tab/widgets/EventItem.dart';
import 'package:flutter/material.dart';

import '../../../../../model/Event.dart';

class AllTabView extends StatefulWidget {
  const AllTabView({super.key});

  @override
  State<AllTabView> createState() => _AllTabViewState();
}

class _AllTabViewState extends State<AllTabView> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirestoreManager.getAllEventsRealTime(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            // loading
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            // error handling
            return Column(children: [
              Text(snapshot.error.toString(),style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: ColorManager.blackColor
              )),
              ElevatedButton(onPressed: (){
                setState(() {

                });
              }, child: Text("Refresh"))
            ],);
          }
          // handle success
          List<Event> events = snapshot.data??[];
          if(events.isEmpty){
            return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("No Events Found",style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: ColorManager.blackColor
              ),),
              ElevatedButton(onPressed: (){
                setState(() {

                });
              }, child: Text("Refresh"))
            ],);
          }
          return ListView.separated(
              itemBuilder: (context, index) => EventItem(events[index]),
              separatorBuilder: (context, index) => SizedBox(height: 16,),
              itemCount: events.length);
        },
    );
  }
}

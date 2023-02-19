import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resultproject/provider/cse_result_provider.dart';
import 'package:resultproject/screens/result/result_view_screen.dart';
import 'package:resultproject/services/toast_service.dart';
class ViewAllSem extends ConsumerStatefulWidget {
  var rollno;
  String branch;
   ViewAllSem({Key? key,required this.rollno,required this.branch}) : super(key: key);

  @override
  ConsumerState<ViewAllSem> createState() => _ViewAllSemState();
}

class _ViewAllSemState extends ConsumerState<ViewAllSem> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.watch(resultProvider).getSemData(widget.rollno,widget.branch);
    });


    super.initState();
  }
@override
  Widget build(BuildContext context) {
    final cseprovider=ref.watch(resultProvider);

    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Choose Semester",
        )),
        body:
            cseprovider.semloading ? const Center(child: CircularProgressIndicator()):
                cseprovider.semester.isEmpty ?const Center( child: Text("No Result found",style: TextStyle(color: Colors.black)),) :
        ListView.builder(
          itemCount: cseprovider.semester.length,
          itemBuilder: (context, index) {
            return Semester(index: index);
          },
        ));
  }
}

class Semester extends ConsumerWidget {
  int index;

  Semester({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final cseprovider=ref.watch(resultProvider);
    final wsize = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
           Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) =>
                     ResultViewScreen(index:  index),
               ));

        },
        child: Container(
            height: 50.0,
            width: 200.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 5.0, // soften the shadow
                  spreadRadius: -1.0, //extend the shadow
                  offset: Offset(
                    -2.0, // Move to right 10  horizontally
                    2.0, // Move to bottom 5 Vertically
                  ),
                )
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: wsize * 0.04),
                  child: Text(cseprovider.semester[index].title),
                ),
                Padding(
                  padding: EdgeInsets.only(right:wsize * 0.04),
                  child: const Icon(Icons.remove_red_eye_outlined),
                )
              ],
            )),
      ),
    );
  }
}

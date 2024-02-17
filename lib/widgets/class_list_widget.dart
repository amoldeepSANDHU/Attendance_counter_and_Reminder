import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'each_class_widget.dart';
import '../utilities/Class_data.dart';

class ClassesList extends StatefulWidget {
  const ClassesList({super.key});

  @override
  State<ClassesList> createState() => _ClassesListState();
}

class _ClassesListState extends State<ClassesList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AllClassesData>(
      builder: (context, allClassesData, child) {
        return ListView.builder(
            itemCount: allClassesData.classesCount(),
            itemBuilder: (BuildContext context, int index) {
              final thisVeryClass = allClassesData.classes[index];

              return EachClassWidget(
                // deleteCallback: () {
                //   allClassesData.deleteClass(thisVeryClass);
                // },
                key: UniqueKey(),
                objectForThisClass: thisVeryClass,
              );
            });
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app1/businessLogic/bloc/notes_bloc.dart';
import 'package:notes_app1/screens/add_notes_screen.dart';
import 'package:notes_app1/screens/detail_notes_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.isDelete}) : super(key: key);
  final bool isDelete;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

bool isHomeScreen = true;

class _HomeScreenState extends State<HomeScreen> {
  FocusNode first = new FocusNode();
  FocusNode second = new FocusNode();
  bool isFirstRun = true;
  @override
  void initState() {
    isHomeScreen = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (isFirstRun) {
      FocusScope.of(context).requestFocus(first);
      isFirstRun = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: widget.isDelete
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notes App",
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    onPressed: () {
                      context
                          .read<NotesBloc>()
                          .add(DeleteNotes(idListNotesToBeDeleted));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Note Deleted")));
                    },
                    icon: Icon(
                      Icons.delete,
                    ),
                    alignment: Alignment.centerRight,
                  )
                ],
              )
            : Text(
                "Notes App",
                textAlign: TextAlign.center,
              ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      bottomSheet: Container(
        width: size.width,
        height: 70,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(size.width, 70),
              painter: MyCustomPainter(),
            ),
            Center(
              heightFactor: 0.8,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EnterNotesScreen(
                            isUpdate: false,
                          )));
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.amber,
              ),
            ),
            Container(
              width: size.width,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: first.hasFocus || isFirstRun
                          ? Colors.purple
                          : Colors.amber,
                    ),
                    onPressed: () {
                      setState(() {
                        isHomeScreen = true;
                        FocusScope.of(context).requestFocus(first);
                      });
                    },
                    focusNode: first,
                  ),
                  Container(
                    width: size.width * 0.20,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: second.hasFocus ? Colors.purple : Colors.amber,
                    ),
                    onPressed: () {
                      setState(() {
                        isHomeScreen = false;
                        FocusScope.of(context).requestFocus(second);
                      });
                    },
                    focusNode: first,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: GridViewBuilder(
        isDelete: widget.isDelete,
      ),
    );
  }
}

List<bool> checkBoxVals = [];
List<String?> idListNotesToBeDeleted = [];

class GridViewBuilder extends StatefulWidget {
  final bool isDelete;
  const GridViewBuilder({
    Key? key,
    this.isDelete = false,
  }) : super(key: key);

  @override
  _GridViewBuilderState createState() => _GridViewBuilderState();
}

class _GridViewBuilderState extends State<GridViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(builder: (context, state) {
      if (isHomeScreen) {
        context.read<NotesBloc>().add(FetchAllNotes());
      } else {
        context.read<NotesBloc>().add(FetchDeletedNotes());
      }
      if (state is NotesLoadSuccess) {
        int listCount = int.parse(state.notes!.length.toString());
        for (var i = 0; i < listCount; i++) {
          checkBoxVals.add(false);
        }
        return GridView.builder(
          shrinkWrap: true,
          itemCount: state.notes?.length,
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              crossAxisCount: 2,
              crossAxisSpacing: 7,
              mainAxisSpacing: 15),
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {
                if (state.notes![index]!.isVideoAdded == false)
                  checkBoxVals.insert(index, true);
                idListNotesToBeDeleted.add(state.notes![index]!.id);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => HomeScreen(
                              isDelete: true,
                            )));
              },
              onTap: () {
                if (widget.isDelete) {
                  setState(
                    () {
                      checkBoxVals[index] = !checkBoxVals[index];
                      idListNotesToBeDeleted.add(state.notes![index]!.id);
                    },
                  );
                } else {
                  if (state.notes![index]!.isVideoAdded!) {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => DetailNotesScreen(
                          
                          note: state.notes![index],
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => EnterNotesScreen(
                          isUpdate: true,
                          note: state.notes?[index],
                        ),
                      ),
                    );
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.transparent,
                ),
                height: 40,
                child: Column(
                  children: [
                    widget.isDelete
                        ? Checkbox(
                            value: checkBoxVals[index],
                            onChanged: (value) {
                              setState(() {
                                checkBoxVals[index] = value!;
                                if (value)
                                  idListNotesToBeDeleted
                                      .add(state.notes![index]!.id);
                                else {
                                  idListNotesToBeDeleted
                                      .remove(state.notes![index]!.id);
                                }
                              });
                            })
                        : Container(
                            height: 0,
                            width: 0,
                          ),
                    state.notes![index]!.isVideoAdded == false
                        ? Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${state.notes?[index]?.title}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${state.notes?[index]?.content}",
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Icon(
                            Icons.play_circle_outline,
                            size: 110,
                            color: Colors.grey,
                          ),
                  ],
                ),
              ),
            );
          },
        );
      } else if (state is NotesInitial) {
        return Center(child: CircularProgressIndicator());
      } else {
        return Text(
          "No Items Present",
          style: TextStyle(fontSize: 100),
        );
      }
    });
  }
}
/*   */

/* Widget bottomNavigationBar(BuildContext context, Size size) {
  return ;
}
 */
class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..strokeJoin = StrokeJoin.round;

    Path path = Path();
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

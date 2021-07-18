
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app1/businessLogic/cubit/bloc/notes_bloc.dart';
import 'package:notes_app1/screens/enter_notes_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

  
      return Scaffold(
        appBar: AppBar(
          title: Text("Notes App"),
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
        Builder(
          builder: (context) {
            return Center(
              heightFactor: 0.8,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EnterNotesScreen()));
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.amber,
              ),
            );
          }
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
                  color: Colors.amber,
                ),
                onPressed: () {},
              ),
              Container(
                width: size.width * 0.20,
              ),
              IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.amber,
                  ),
                  onPressed: () {}),
            ],
          ),
        )
      ],
    ),
  ),
                backgroundColor: Colors.white,
                body: Column(mainAxisSize: MainAxisSize.min, children: [
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      padding: EdgeInsets.all(10),
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.8,
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.transparent,
                          ),
                          height: 40,
                          child: Text(
                            "Hellocc",
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  )
                ]),
              );
            
          }
        
          


  /* import 'package:flutter/material.dart';
      
      
      
      
      class HomeScreen extends StatefulWidget {
        @override
        _BottomNavBarV2State createState() => _BottomNavBarV2State();
      }
      
      class _BottomNavBarV2State extends State<HomeScreen> {
        int currentIndex = 0;
      
        setBottomBarIndex(index) {
          setState(() {
            currentIndex = index;
          });
        }
      
        @override
        Widget build(BuildContext context) {
          final Size size = MediaQuery.of(context).size;
          return Scaffold(
        
            body: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: size.width,
                    height: 80,
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: Size(size.width, 80),
                          painter: BNBCustomPainter(),
                        ),
                        Center(
                          heightFactor: 0.6,
                          child: FloatingActionButton(backgroundColor: Colors.orange, child: Icon(Icons.shopping_basket), elevation: 0.1, onPressed: () {}),
                        ),
                        Container(
                          width: size.width,
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.home,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  
                                },
                               
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.restaurant_menu,
                                   color: Colors.red,
                                  ),
                                  onPressed: () {
                                    
                                  }),
                              Container(
                                width: size.width * 0.20,
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.bookmark,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    
                                  }),
                              IconButton(
                                  icon: Icon(
                                    Icons.notifications,
                                   color: Colors.red,
                                  ),
                                  onPressed: () {
                                   
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
      }
      
      class BNBCustomPainter extends CustomPainter {
        @override
         void paint(Canvas canvas, Size size) {
          Paint paint = new Paint()
            ..color = Colors.white
            ..style = PaintingStyle.fill;
      
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
        bool shouldRepaint(CustomPainter oldDelegate) {
          return false;
        }
      } */

}

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


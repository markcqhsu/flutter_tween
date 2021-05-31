import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  int _counter = 0;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,

    )..repeat();
    // _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // child: ScaleTransition(
        //   //用動畫控制器來驅動Tween, 因為Tween雖然是Double, 但並不是AnimationDouble
        //   scale: _controller.drive(Tween(begin: 0.0, end: 1.0)),
        child: SlideTransition(
          // position: _controller.drive(Tween(begin: Offset(0,0), end: Offset(0.1,0))),
          position: Tween(begin: Offset(0,-0.5), end: Offset(0,0.8))
              // .chain(CurveTween(curve: Curves.elasticInOut))
              .chain(CurveTween(curve: Interval(0.8, 1.0)))//前面80%的時間什麼都不做, 最後20%的時間把動畫都做完
              .animate(_controller),//這個寫法的好處是可以透過chain疊加不同的Tween()

          child: Center(
            child: Container(
              width: 300,
              height: 300,
              color: Colors.blue,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _controller.stop();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}



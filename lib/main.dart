import 'package:flutter/material.dart';
import 'package:linear_progress_indicator/uploaded.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFC41A3B),
        primaryColorLight: Color(0xFFFBE0E6),
        accentColor: Color(0xFF1B1F32),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  String title = 'LinearProgressIndicator';

  double _progressValue = 0.0;

  bool _isUploaded = false;
  bool _inProgress = false;

  AnimationController _progressAnimationController;
  Animation<double> _progressAnimation;

  void _btnPressed() {
    setState(() {
      if (_isUploaded) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Uploaded(),
          ),
        );
      } else {
        _progressAnimationController.forward();
        _inProgress = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _progressAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        curve: Curves.easeIn,
        parent: _progressAnimationController,
      ),
    )..addListener(() {
        _progressValue = _progressAnimation.value;
        if (_progressAnimation.isCompleted) {
          _inProgress = false;
          _isUploaded = true;
        }
        setState(() {});
      });
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 175.0,
          width: 325.0,
          decoration: BoxDecoration(
            color: Color(0xFFFBE0E6),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF1B1F32).withOpacity(0.16),
                offset: Offset(0.0, 3.0),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              LinearProgressIndicator(
                value: _progressValue,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.lerp(
                      Color(0xFF1B1F32), Color(0xFFC41A3B), _progressValue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  (_progressValue * 100).toStringAsFixed(0) + '%',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 48.0,
                width: 100.0,
                child: MaterialButton(
                  onPressed: _inProgress ? null : _btnPressed,
                  color: Color(0xFFC41A3B),
                  disabledColor: Colors.grey,
                  child: Text(
                    _isUploaded ? 'Done'.toUpperCase() : 'Upload'.toUpperCase(),
                    style: TextStyle(
                      color: Color(0xFFFBE0E6),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

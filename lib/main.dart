import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute:"/",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes:{
        "/":(context)=> MyHomePage(title: 'Flutter Demo Home Page'),
        "new_route":(context)=>NewRoute(),
        "tip_route":(context)=>TipRoute(text: ModalRoute.of(context).settings.arguments),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FlatButton(
              child: Text("open new route"),
              textColor: Colors.blue,
              onPressed: () {
                //导航到新路由   
                Navigator.pushNamed(context, "new_route");
              },
            ),
            RaisedButton(
              onPressed: () async {
                // 打开tip_route，传递参数并等待返回结果
                var result = await Navigator.of(context).pushNamed("tip_route", arguments: "553");
                // 输出tip_route路由返回结果
                print("路由返回值: $result");
              },
              child: Text("打开提示页"),
            ),
            RandomWordsWidget(),
            Image.asset("assets/logo.png"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

// 随机字符串
class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // 生成随机字符串
    final wordPair = new WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text("随机字符：" + wordPair.toString()),
    );
  }
}

// 路由跳转测试页
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}

// 路由传参测试页
class TipRoute extends StatelessWidget {
  // 接收一个text参数
  TipRoute({
    Key key,
    @required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text("接收参数：" + text),
              RaisedButton(
                // 返回并传递一个参数
                onPressed: () => Navigator.pop(context, "233"),
                child: Text("返回"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
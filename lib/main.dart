import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() {
  Supabase.initialize(
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndicXB3YnJ6bXVrYWR2cWl1bnJpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk0MTA5OTMsImV4cCI6MjA1NDk4Njk5M30.Jvm32OQkKVVM73KSdEvfAkExD_f6y5KQOjyWxLEPEX4',
    url: 'https://wbqpwbrzmukadvqiunri.supabase.co'
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UKK_25',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 63, 155, 230)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Login'),
    );
  }
}


class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  
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

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      
        title: Text(widget.title),
      ),
      body: Center(
    
        child: Column(
         
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              Align(
                alignment: AlignmentDirectional(-0.06, 0.38),
                child: FFButtonWidget( 
                  onPressed: () {
                    print('BUtton pressed ...');

                  },
                  text: 'Login',
                  options: FFButtonoptions( 
                    height: 40,
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    iconpadding: EdgeInsets.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).primaryBackground
                  )
                ),
              )
              'kamu dapat menambahkan tombol disini:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}


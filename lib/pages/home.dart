import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data =  {};

  @override
  Widget build(BuildContext context) {

    try {
      data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    }
    catch(e){
      data = data;
    }
    print(data);

    //set background

   final String? bgImage = (data['isDaytime'] ?? false) ? 'day.png' : 'night.png';
    final Color? bgColor = (data['isDaytime'] ?? false) ? Colors.blue : Colors.indigo.shade700;



    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,120,0,0),
              child: Column(
                children: <Widget>[
                  TextButton.icon(
                      onPressed: () async{
                      dynamic result = await Navigator.pushNamed(context,'/location');
                      setState(() {
                        data = {
                          'time' : result['time'],
                          'location': result['location'],
                          'isDayTime' : result['isDaytime'] ?? false,
                          'flag' : result['flag']
                        };
                      });
                      },
                      icon: Icon(
                          Icons.edit_location,
                          color: Colors.grey[300],
                      ),
                      label: Text(
                          'Edit Location',
                          style: TextStyle(
                            color: Colors.white
                          ),
                      )
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66,
                      color: Colors.white
                    ),
                  )
                ],
              ),
            ),
          )
      )
    );
  }
}

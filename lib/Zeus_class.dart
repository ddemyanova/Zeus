import 'package:flutter/material.dart';
import 'utils.dart' as util;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
class Zeus extends StatefulWidget{
  @override
  _ZeusState createState() => new _ZeusState();
}

class _ZeusState extends State<Zeus>{
  
  void showWeather() async {
    Map data = await getWeather(util.appID, util.defaultCity);
    print(data.toString());
  }
  
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Zeus'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: showWeather
          )
        ],
      ) ,
      body: new Stack(
        children: <Widget>[
         Container(
           foregroundDecoration: const BoxDecoration(
             image: DecorationImage(
               image: AssetImage('assets/images/GG.jpg'),//Не, ну сюда бог дизайна должна найс бэкграунд подобрать
               fit: BoxFit.cover,
               alignment: Alignment.center,
             )
             )
           ),
          new Container(
            alignment: Alignment.topRight,
             margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
             child: new Text('Zaporizhia',
             style: cityStyle(),),
          ),


          new Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 100),
            alignment: Alignment.center,
            child: new Image.asset('assets/images/Drizzle.png',
            width: 150.0,
            height: 150.0),
          ),
          //Здесь будет потом enum или что-то вроде этого с изображениями в зависимости от погоды, пока прикрепил тестовую картинку просто


          new Container(
            margin: const EdgeInsets.fromLTRB(30, 250, 0, 0),
            alignment: Alignment.center,
            child: updateTempWidget("Zaporizhia"),
          )
        ]
      ),
    );
  }
  Future<Map> getWeather(String appId, String city) async {
    String apiUrl = 'http://api.openweathermap.org/data/2.5/weather?q=$city&'
    'appid=${util.appID}&units=metric';
    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);

  }

  Widget updateTempWidget(String city) {
    return new FutureBuilder(
        future: getWeather(util.appID, city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
          //тут будем инфу с джейсона брать пажилого, виджеты делать н1 и т.д
          if(snapshot.hasData){
            Map content = snapshot.data;
              return new Container(
                margin: const EdgeInsets.fromLTRB(105, 70, 0, 0),
                alignment: Alignment.center,
                child: new Column(
                  children: <Widget>[
                    new ListTile(
                      title: new Text(content['main']['temp'].toString(),
                      style: new TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 50,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),),
                    )
                  ],
                ),
              );
          }
          else{
            return new Container();
          }
        });
  }
}



TextStyle cityStyle(){
  return new TextStyle(
    color: Colors.black,
    fontSize: 30.0,
    fontStyle: FontStyle.italic
  );
}
TextStyle temperatureStyle(){
  return new TextStyle(
    color: Colors.black,
    fontSize: 49.8,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );
}
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Map',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }

}

class HomePage extends StatefulWidget {
  @override

  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  MapType type;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.835047, 90.416545),
    zoom: 14.4746,
  );
  Set<Marker> markers;
  List<Marker> allMarkers=[];

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    allMarkers.add(Marker(markerId: MarkerId('my marker'),
      draggable: false,
      onTap: (){
        print('Marker Tapped');
      },
      position: LatLng(23.835047, 90.416545)
    ));
    type = MapType.normal;
    markers = Set.from(allMarkers);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: markers,
            mapType: type,
            onTap: (position){
              Marker mk1 = Marker(
                markerId: MarkerId('1'),
                position: position,
              );
              setState(() {
                markers.add(mk1);
              });
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(23.835047, 90.416545),
              zoom: 12.0
            ),

          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      type = type == MapType.normal ? MapType.hybrid : MapType.normal;
                    });
                  },
                  child: Icon(Icons.map),
                ),
                FloatingActionButton(
                  child: Icon(Icons.zoom_in),
                  onPressed: () async{
                    (await _controller.future).animateCamera(CameraUpdate.zoomIn());
                  },
                ),
                FloatingActionButton(
                  child: Icon(Icons.zoom_out),
                  onPressed: () async {
                    (await _controller.future).animateCamera(CameraUpdate.zoomOut());
                  },
                ),
                FloatingActionButton.extended(
                  icon: Icon(Icons.add_box),
                  label: Text("LatLng"),
                  onPressed: (){
                    if(markers.length > 1)
                      print(markers.first.position);
                      print("Abdullah Al-Sakin");
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

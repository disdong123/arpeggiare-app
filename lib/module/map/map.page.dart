import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PositionPermissionPage extends StatefulWidget {
  const PositionPermissionPage({super.key});

  @override
  State<PositionPermissionPage> createState() => _PositionPermissionPageState();
}

class _PositionPermissionPageState extends State<PositionPermissionPage> {
  @override
  initState() {
    super.initState();
    checkPermission(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  Future<void> checkPermission(context) async {
    final statuses = await [
      Permission.location,
      Permission.locationAlways,
      Permission.locationWhenInUse
    ].request();

    bool permitted = false;
    statuses.forEach((key, value) {
      if (value == PermissionStatus.granted) {
        permitted = true;
      }
    });

    if (permitted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("위치정보 허용이 완료되었습니다."),
          action: SnackBarAction(
            label: "확인",
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MapPage()));
            },
          )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("위치정보 허용이 필요합니다."),
          action: SnackBarAction(
            label: "설정",
            onPressed: () {
              AppSettings.openAppSettings(type: AppSettingsType.bluetooth);
              Geolocator.openLocationSettings();
            },
          )));
    }
  }
}

class MapPage extends StatelessWidget {
  MapPage({super.key});

  final Future<Position> _position = Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 30,
          foregroundColor: Colors.green,
          backgroundColor: Colors.white,
          title: Text(
            'ARPEGGIARE',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        body: FutureBuilder<Position>(
          future: _position,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return NaverMap(
                options: NaverMapViewOptions(
                    initialCameraPosition: NCameraPosition(
                      target: NLatLng(
                          snapshot.data!.latitude, snapshot.data!.longitude),
                      zoom: 7,
                      bearing: 0,
                      tilt: 0,
                    ),
                    mapType: NMapType.basic,
                    activeLayerGroups: [
                      NLayerGroup.building,
                      NLayerGroup.transit
                    ],
                    zoomGesturesEnable: true),
                onMapReady: (myMapController) {
                  debugPrint("네이버 맵 로딩됨!");
                },
                onMapTapped: (point, latLng) {
                  debugPrint("${latLng.latitude}、${latLng.longitude}");
                },
              );
            } else {
              print(snapshot.data);
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

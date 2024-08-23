import 'dart:async';
import 'dart:math';

import 'package:beacon_scanner/beacon_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beacon_ex/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<MonitoringResult>? _streamMonitoring;
  StreamSubscription<RangingResult>? _streamRanging;
  final _regions = <Region>[];

  @override
  void initState() {
    super.initState();
    //_regions.add(Region(identifier: 'com.beacon'));
    _regions.add(const Region(
      identifier: 'com.beacon',
      // beaconId: IBeaconId(proximityUUID: '26a8a572-a4a7-41b5-98b0-a6ebcdbda897'),
      // beaconId: IBeaconId(proximityUUID: 'E2C56DB5-DFFB-48D2-B060-D0F5A71096E0'),
      beaconId: IBeaconId(proximityUUID: 'D546DF97-4757-47EF-BE09-3E2DCBDD0C78'),
    ));
  }

  Future<void> _monitorBeacons() async {
    _streamMonitoring = beaconScanner.monitoring(_regions).listen((MonitoringResult result) {
      print("monitoring:");
      print(result.toString());
      print(result.region.beaconId.toString());
    });
  }

  Future<void> _monitorBeaconsEnd() async {
    _streamMonitoring?.cancel();
  }

  Future<void> _rangeBeaconsEnd() async {
    _streamRanging?.cancel();
  }

  Future<void> _rangeBeacons() async {
    print("is ranging started? it should have");
    _streamRanging = beaconScanner.ranging(_regions).listen((RangingResult result) {
      print("ranging:");
      result.beacons.forEach((beacon) {
        print('uuid ${beacon.id.proximityUUID}');
      });
    });
  }

  double _calculateAccuracy(int txPower, double rssi) {
    if (rssi == 0) {
      return -1.0;
    }

    double ratio = rssi * 1.0 / txPower;
    if (ratio < 1.0) {
      return pow(ratio, 10).toDouble();
    } else {
      double accuracy = (0.89976) * pow(ratio, 7.7095) + 0.111;
      return accuracy;
    }
  }

  double _calculateDistance(int rssi, int measuredPower, double n) {
    if (rssi >= 0) {
      return -1.0;
    }

    double ratio = (measuredPower - rssi) / (10.0 * n);
    double distance = pow(10, ratio).toDouble();

    return distance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Monitor"),
                IconButton(
                  onPressed: _monitorBeacons,
                  icon: const Icon(Icons.start),
                ),
                IconButton(
                  onPressed: _monitorBeaconsEnd,
                  icon: const Icon(Icons.coronavirus_sharp),
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Range"),
                IconButton(
                  onPressed: _rangeBeacons,
                  icon: const Icon(Icons.start),
                ),
                IconButton(
                  onPressed: _rangeBeaconsEnd,
                  icon: const Icon(Icons.coronavirus_sharp),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

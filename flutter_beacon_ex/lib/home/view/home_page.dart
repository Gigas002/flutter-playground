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
  StreamSubscription<ScanResult>? _streamRanging;
  final _regions = <Region>[];

   @override
  void initState() {
    super.initState();
    _regions.add(Region(identifier: 'com.beacon'));
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
    _streamRanging = beaconScanner.ranging(_regions).listen((ScanResult result) {
      print("ranging:");
      result.beacons.forEach((beacon) {
        var distance = _calculateDistance(beacon.rssi, beacon.txPower!, 4.0); // 2.0);
        var accuracy = _calculateAccuracy(beacon.txPower!, beacon.rssi.toDouble());
        print('rssi: ${beacon.rssi} \n power: ${beacon.txPower!} \n uuid: ${beacon.id.proximityUUID} \n mac: ${beacon.macAddress} \n calculated distance: ${distance} \n accuracy: ${accuracy}');
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
    }
    else {
      double accuracy =  (0.89976) * pow(ratio, 7.7095) + 0.111;    
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

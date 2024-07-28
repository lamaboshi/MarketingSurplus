import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const _maxCirclesCount = 3;

/// On this page, [_maxCirclesCount] circles are randomly generated
/// across europe, and then you can limit them with a slider
///
/// This way, you can test how map performs under a lot of circles
class ManyCirclesPage extends StatefulWidget {
  static const String route = '/many_circles';

  const ManyCirclesPage({super.key});

  @override
  ManyCirclesPageState createState() => ManyCirclesPageState();
}

class ManyCirclesPageState extends State<ManyCirclesPage> {
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
  var lan = [37.1480208549394, 37.11866676729782, 37.082789542918434];
  var lat = [36.20899767506333, 36.21453779893293, 36.203180123442586];
  List<CircleMarker> allCircles = [];
  var colorsWay = [
    Colors.purple.shade200.withOpacity(0.6),
    Colors.orange.withOpacity(0.6),
    Colors.blue.withOpacity(0.6)
  ];
  int numOfCircles = _maxCirclesCount;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      for (var x = 0; x < _maxCirclesCount; x++) {
        allCircles.add(
          CircleMarker(
            point: LatLng(lat[x], lan[x]),
            color: colorsWay[x],
            radius: 70,
          ),
        );
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCameraFit: CameraFit.bounds(
                minZoom: 12,
                bounds: LatLngBounds(
                  const LatLng(36.21135227579543, 37.13669121016784),
                  const LatLng(36.174685352748064, 37.096492612163786),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 88,
                  bottom: 192,
                ),
              ),
            ),
            children: [
              openStreetMapTileLayer,
              CircleLayer(circles: allCircles.take(numOfCircles).toList()),
            ],
          ),
        ],
      ),
    );
  }

  TileLayer get openStreetMapTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        // Use the recommended flutter_map_cancellable_tile_provider package to
        // support the cancellation of loading tiles.
      );
}

class NumberOfItemsSlider extends StatelessWidget {
  const NumberOfItemsSlider({
    super.key,
    required this.number,
    required this.onChanged,
    required this.maxNumber,
    this.itemDescription = 'Item',
    int itemsPerDivision = 1000,
  })  : assert(
          (maxNumber / itemsPerDivision) % 1 == 0,
          '`maxNumber` / `itemsPerDivision` must yield integer',
        ),
        divisions = maxNumber ~/ itemsPerDivision;

  final int number;
  final void Function(int) onChanged;
  final String itemDescription;
  final int maxNumber;
  final int divisions;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 8, top: 4, bottom: 4),
        child: Row(
          children: [
            Tooltip(
              message: 'Adjust Number of ${itemDescription}s',
              child: const Icon(Icons.numbers),
            ),
            Expanded(
              child: Slider.adaptive(
                value: number.toDouble(),
                onChanged: (v) => onChanged(v.toInt()),
                min: 0,
                max: maxNumber.toDouble(),
                divisions: divisions,
                label: number.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:test_technique/utils/constants.dart';
import 'package:geolocator/geolocator.dart';

import '../../model/Actualite.dart';

class ActualiteListItem extends StatefulWidget {
  final Actualite actualite;
  const ActualiteListItem({super.key, required this.actualite});

  @override
  State<ActualiteListItem> createState() => _ActualiteListItemState();
}

class _ActualiteListItemState extends State<ActualiteListItem> {
  double _distanceInKm = 0;

  @override
  void initState() {
    super.initState();
    _calculateDistance();
  }

  @override
  Widget build(BuildContext context) {
    double clickedImageSize = MediaQuery.of(context).size.width * 0.5;
    return GestureDetector(
      onTap: () {
        if (widget.actualite.pictureUrl.isNotEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: SizedBox(
                  height: clickedImageSize,
                  width: clickedImageSize,
                  child: Image.network(widget.actualite.pictureUrl,
                      fit: BoxFit.cover),
                ),
              );
            },
          );
        }
      },
      child: Container(
        margin: marginContainer,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: colorAccentuation,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: colorAccentuation.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.actualite.pictureUrl.isEmpty
                ? const SizedBox(
              width: 50,
              height: 50,
              child: Icon(Icons.image),
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                widget.actualite.pictureUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.actualite.title,
                    style: const TextStyle(
                      color: colorText,
                      fontSize: lg20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.actualite.description.length > 50
                        ? '${widget.actualite.description.substring(0, 50)}...'
                        : widget.actualite.description,
                    style: const TextStyle(
                      fontSize: md16,
                      color: colorText,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDate(widget.actualite.publishedAt),
                        style: const TextStyle(
                          fontSize: sm14,
                          color: colorTextAccentuation,
                        ),
                      ),
                      Text(
                        _distanceInKm == 0
                            ? "0 km d'ici"
                            : "${_distanceInKm.toStringAsFixed(0)} km d'ici",
                        style: const TextStyle(
                          fontSize: sm14,
                          color: colorTextAccentuation,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    return difference == 0
        ? 'Aujourd\'hui'
        : difference == 1
        ? 'Hier'
        : 'Il y a $difference jour(s)';
  }

  Future<void> _calculateDistance() async {
    LocationPermission status = await Geolocator.checkPermission();
    if (status == LocationPermission.denied) {
      status = await Geolocator.requestPermission();
    }

    if (status == LocationPermission.whileInUse ||
        status == LocationPermission.always) {
      final Position position = await Geolocator.getCurrentPosition();
      final double distanceInMeters = await Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        widget.actualite.latitude,
        widget.actualite.longitude,
      );
      setState(() {
        _distanceInKm = distanceInMeters / 1000;
      });
    }
  }
}
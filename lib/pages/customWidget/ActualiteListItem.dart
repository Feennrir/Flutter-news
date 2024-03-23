import 'package:flutter/material.dart';
import 'package:test_technique/utils/constants.dart';

import '../../model/Actualite.dart';

class ActualiteListItem extends StatelessWidget {
  final Actualite actualite;

  const ActualiteListItem({
    super.key,
    required this.actualite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          actualite.pictureUrl.isEmpty
              ?  const SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.image),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    actualite.pictureUrl,
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
                  actualite.title,
                  style: const TextStyle(
                    color: colorText,
                    fontSize: lg20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  actualite.description.length > 50
                      ? '${actualite.description.substring(0, 50)}...'
                      : actualite.description,
                  style: const TextStyle(
                    fontSize: md16,
                    color: colorText,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  _formatDate(actualite.publishedAt),
                  style: const TextStyle(
                    fontSize: sm14,
                    color: colorTextAccentuation,
                  ),
                ),
              ],
            ),
          ),
        ],
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
}

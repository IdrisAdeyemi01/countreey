import 'package:cached_network_image/cached_network_image.dart';
import 'package:countreey/src/core/router/routes.dart';
import 'package:countreey/src/core/utilities/utility.dart';
import 'package:flutter/material.dart';

class CountryTile extends StatelessWidget {
  const CountryTile({
    super.key,
    required this.countryCapital,
    required this.countryName,
    required this.flagUrl,
  });
  final String countryName;
  final String countryCapital;
  final String flagUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      onTap: () {
        Utility.navigate(
          context: context,
          route: Routes.countryDetailView,
          arguments: countryName,
        );
      },
      leading: SizedBox(
        height: 40,
        width: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: flagUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
      title: Text(
        countryName,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        countryCapital,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}

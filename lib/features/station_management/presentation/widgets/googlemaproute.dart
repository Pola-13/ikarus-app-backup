import 'package:url_launcher/url_launcher.dart';

/// Opens Google Maps with driving directions to the given coordinates.
Future<void> openGoogleMapsRoute(double lat, double lng) async {
  final Uri uri = Uri.parse(
    "https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving",
  );

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception("Could not launch Google Maps");
  }
}

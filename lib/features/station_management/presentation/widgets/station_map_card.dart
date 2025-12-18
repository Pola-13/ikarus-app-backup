import 'package:flutter/material.dart';

class StationMapCard extends StatelessWidget {
  final Map<String, dynamic> station;

  const StationMapCard({
    super.key,
    required this.station,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.04),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                station["name"],
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(station["address"]),
          SizedBox(height: 12),
          Row(
            children: [
              Text("1.4 Km"),
              SizedBox(width: 10),
              Icon(Icons.circle, color: Colors.green, size: 12),
              SizedBox(width: 6),
              Icon(Icons.circle, color: Colors.orange, size: 12),
            ],
          ),
        ],
      ),
    );
  }
}

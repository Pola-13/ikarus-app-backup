
import 'package:ikarusapp/features/station_management/presentation/screens/nasr_city.dart/nasrcity.dart';
import 'package:ikarusapp/features/station_management/presentation/screens/zahraaAlmaadai/zahraa_almaadai.dart';

final List<Map<String, dynamic>> stationData = [
  {
    'id': 'st1',
    'name': 'Zahraa Al Maadi Station',
    'address': '55 Zahraa Al Maadi, Cairo 78239',
    'lat': 29.96779,
    'lng': 31.29480,
    'image': "assets/icons/charger.png",
    'power': 60,
    'connectors': 3,
    'page': ZahraaAlmaadai(), 
    'favorite': false,

  },

  {
    'id': 'st2',
    'name': 'Nasr City Station',
    'address': 'Nasr City, Cairo 11865',
    'lat': 29.96499,
    'lng': 31.29973,
    'image': "assets/icons/charger.png",
    'power': 50,
    'connectors': 2,
    'page': NaserCity(),
    'favorite': false,
  },
  
];

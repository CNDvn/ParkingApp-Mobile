class DataPoint {
  final String name;
  final double latitude, longitude;

  const DataPoint({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

List<DataPoint> dataPoint = [
  const DataPoint(
      name: 'Ho Chi Minh', latitude: 10.794606, longitude: 106.721677),
  const DataPoint(name: 'Ha Noi', latitude: 21.0031177, longitude: 105.8201408),
  const DataPoint(name: 'Quan 9', latitude: 10.8428791, longitude: 106.8297824),
  const DataPoint(name: 'Quan 1', latitude: 10.7756587, longitude: 106.7004238)
];

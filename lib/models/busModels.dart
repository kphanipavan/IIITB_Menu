class Location {
  final String fullName;
  final String shortName;
  const Location(this.fullName, this.shortName);
}

class BusRoute {
  final Location from;
  final Location to;
  const BusRoute(this.from, this.to);
}

import 'package:zena_foru/data/data.dart';
import 'package:zena_foru/model/country.dart' as country;
import 'package:zena_foru/utils/enums.dart';

class Continent {
  final String name;
  final KContinent kContinent;
  final List<country.Country> countries;
  Continent.usa()
      : name = "USA",
        kContinent = KContinent.usa,
        countries = usas;
  Continent.africa()
      : name = "Africa",
        kContinent = KContinent.africa,
        countries = africas;
  Continent.asia()
      : name = "Asia",
        kContinent = KContinent.asia,
        countries = asias;
  Continent.australia()
      : name = "Australia",
        kContinent = KContinent.australia,
        countries = australias;
  Continent.europe()
      : name = "Europe",
        kContinent = KContinent.europe,
        countries = europes;
  Continent.northAmerica()
      : name = "North America",
        kContinent = KContinent.northAmerica,
        countries = northAmericas;
  Continent.southAmerica()
      : name = "South America",
        kContinent = KContinent.southAmerica,
        countries = southAmericas;
}

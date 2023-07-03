import 'package:zena_foru/model/category.dart';
import 'package:zena_foru/model/continent.dart';
import 'package:zena_foru/model/country.dart' as country;
import 'package:zena_foru/utils/enums.dart';

final categories = [
  Category(
    category: KCategory.general,
    categoryName: 'Home',
    keyWords: '',
  ),
  Category(
    category: KCategory.business,
    categoryName: 'Business',
    keyWords:
        'business AND (forex OR imf OR finance OR debt OR shopify OR dropshipping OR macro OR economics OR corporation OR market)',
  ),
  Category(
    category: KCategory.entertainment,
    categoryName: 'Entertainment',
    keyWords:
        'entertainment AND (movie OR music OR "box office" OR billboard OR song OR artist)',
  ),
  Category(
    category: KCategory.health,
    categoryName: 'Health',
    keyWords:
        'health AND (food OR drought OR covid OR cancer OR vitamin OR mineral OR water OR clinic OR hospital OR meditation)',
  ),
  Category(
    category: KCategory.science,
    categoryName: 'Science',
    keyWords: 'science',
  ),
  Category(
    category: KCategory.sports,
    categoryName: 'Sports',
    keyWords:
        'sport AND (soccer OR football OR tennis OR "car race" OR athletic)',
  ),
  Category(
    category: KCategory.technology,
    categoryName: 'Technology',
    keyWords:
        'technology AND (smartphone OR apple OR tesla OR microsoft OR "electric car" OR samsung OR xiaomi OR gpt OR ai OR programming OR "machine learning")',
  ),
];

final Map<KContinent, Continent> continents = {
  KContinent.usa: Continent.usa(),
  KContinent.africa: Continent.africa(),
  KContinent.asia: Continent.asia(),
  KContinent.australia: Continent.australia(),
  KContinent.europe: Continent.europe(),
  KContinent.northAmerica: Continent.northAmerica(),
  KContinent.southAmerica: Continent.southAmerica(),
};

final List<country.Country> usas = [
  country.Country(
    fullName: 'USA',
    shortName: 'us',
  )
];
final List<country.Country> africas = [
  country.Country(
    fullName: 'Egypt',
    shortName: 'eg',
  ),
  country.Country(
    fullName: 'Ethiopia',
    shortName: 'et',
  ),
  country.Country(
    fullName: 'Morocco',
    shortName: 'ma',
  ),
  country.Country(
    fullName: 'Nigeria',
    shortName: 'ng',
  ),
  country.Country(
    fullName: 'South Africa',
    shortName: 'sa',
  ),
  country.Country(
    fullName: 'Zambia',
    shortName: 'za',
  ),
];
final List<country.Country> asias = [
  country.Country(
    fullName: 'UAE',
    shortName: 'ae',
  ),
  country.Country(
    fullName: 'Hong Kong',
    shortName: 'hk',
  ),
  country.Country(
    fullName: 'Indonesia',
    shortName: 'id',
  ),
  country.Country(
    fullName: 'India',
    shortName: 'in',
  ),
  country.Country(
    fullName: 'Japan',
    shortName: 'jp',
  ),
  country.Country(
    fullName: 'South Korea',
    shortName: 'kr',
  ),
  country.Country(
    fullName: 'Thailand',
    shortName: 'th',
  ),
  country.Country(
    fullName: 'Taiwan',
    shortName: 'tw',
  ),
  country.Country(
    fullName: 'China',
    shortName: 'cn',
  ),
];
final List<country.Country> australias = [
  country.Country(
    fullName: 'Australia',
    shortName: 'au',
  )
];
final List<country.Country> europes = [
  country.Country(
    fullName: 'England',
    shortName: 'gb',
  ),
  country.Country(
    fullName: 'France',
    shortName: 'fr',
  ),
  country.Country(
    fullName: 'Germany',
    shortName: 'de',
  ),
  country.Country(
    fullName: 'Italy',
    shortName: 'it',
  ),
  country.Country(
    fullName: 'Netherlands',
    shortName: 'nl',
  ),
  country.Country(
    fullName: 'Portugal',
    shortName: 'pt',
  ),
  country.Country(
    fullName: 'Russia',
    shortName: 'ru',
  ),
  country.Country(
    fullName: 'Ukrain',
    shortName: 'ua',
  ),
];
final List<country.Country> northAmericas = [
  country.Country(
    fullName: 'Canada',
    shortName: 'ca',
  ),
  country.Country(
    fullName: 'Cuba',
    shortName: 'cu',
  ),
  country.Country(
    fullName: 'Mexico',
    shortName: 'mx',
  ),
];
final List<country.Country> southAmericas = [
  country.Country(
    fullName: 'Argentina',
    shortName: 'ar',
  ),
  country.Country(
    fullName: 'Brazil',
    shortName: 'br',
  ),
  country.Country(
    fullName: 'Columbia',
    shortName: 'co',
  ),
  country.Country(
    fullName: 'Venezuela',
    shortName: 've',
  ),
];

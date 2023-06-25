import 'package:zena_foru/model/category.dart';
import 'package:zena_foru/model/country.dart' as country;
import 'package:zena_foru/utils/enums.dart';

final categories = [
  Category(
    category: KCategory.general,
    categoryName: 'General',
  ),
  Category(
    category: KCategory.business,
    categoryName: 'Business',
  ),
  Category(
    category: KCategory.entertainment,
    categoryName: 'Entertainment',
  ),
  Category(
    category: KCategory.health,
    categoryName: 'Health',
  ),
  Category(
    category: KCategory.science,
    categoryName: 'Science',
  ),
  Category(
    category: KCategory.sports,
    categoryName: 'Sports',
  ),
  Category(
    category: KCategory.technology,
    categoryName: 'Technology',
  ),
];

final countries = [
  country.Country(
    fullName: 'USA',
    shortNames: ['us'],
  ),
  country.Country(
    fullName: 'Britain',
    shortNames: ['gb'],
  ),
  country.Country(
    fullName: 'Russia',
    shortNames: ['ru'],
  ),
  country.Country(
    fullName: 'Ukrain',
    shortNames: ['ua'],
  ),
  country.Country(
    fullName: 'China',
    shortNames: ['cn'],
  ),
  country.Country(
    fullName: 'Africa',
    shortNames: [
      'ng',
      'eg',
      'ma',
      'za',
      'sa',
    ],
  ),
  country.Country(
    fullName: 'Asia',
    shortNames: [
      'ae',
      'hk',
      'id',
      'in',
      'jp',
      'kr',
      'my',
      'ph',
      'sg',
      'th',
      'tw',
      'cn',
    ],
  ),
  country.Country(
    fullName: 'Europe',
    shortNames: [
      'at',
      'be',
      'bg',
      'ch',
      'cz',
      'de',
      'fr',
      'gr',
      'hu',
      'ie',
      'il',
      'it',
      'lt',
      'lv',
      'nl',
      'no',
      'nz',
      'pl',
      'pt',
      'ro',
      'rs',
      'ru',
      'se',
      'si',
      'sk',
      'tr',
      'ua',
      'gb',
    ],
  ),
  country.Country(
    fullName: 'South America',
    shortNames: [
      'ar',
      'br',
      'co',
      've',
    ],
  ),
  country.Country(
    fullName: 'Australia',
    shortNames: ['au'],
  ),
  country.Country(
    fullName: 'North America',
    shortNames: [
      'au',
      'ca',
      'cu',
      'mx',
      'us',
    ],
  ),
];

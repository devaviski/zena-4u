import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zena_foru/data/data.dart';
import 'package:zena_foru/model/category.dart';

class ActiveCategoryNotifier extends StateNotifier<Category> {
  ActiveCategoryNotifier() : super(categories[0]);

  void setCategory(Category category) {
    state = category;
  }
}

final activeCategoryProvider =
    StateNotifierProvider<ActiveCategoryNotifier, Category>(
        (ref) => ActiveCategoryNotifier());

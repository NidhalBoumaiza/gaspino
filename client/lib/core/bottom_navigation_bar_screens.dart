import 'package:client/features/products/presentation%20layer/pages/bottom%20navigation%20bar%20screens/others_screen.dart';

import '../features/products/presentation layer/pages/bottom navigation bar screens/home_screen.dart';
import '../features/products/presentation layer/pages/bottom navigation bar screens/my_products_screen.dart';
import '../features/products/presentation layer/pages/bottom navigation bar screens/my_shpping_card_screen.dart';

const bottomNavigationBarScreens = [
  HomeScreen(),
  MyProductsScreen(),
  MyShoppingCardScreen(),
  OthersScreen(),
];

const PagesNames = [
  'Accueil',
  'Mes produits',
  'Panier',
  'Paramètres',
];

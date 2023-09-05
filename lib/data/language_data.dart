import 'package:flutter/material.dart';
import 'package:menu_app/main.dart';

class LanguageData {
  final language = ValueNotifier<String>('en');
  final fullLanguages = <String>['Türkmen', 'Русский', 'English'];

  Map<String, String> languageTitle = {
    'tm': 'Dil',
    'ru': 'Язык',
    'en': 'Language',
  };
  Map<String, String> choseLang = {
    'tm': 'Dil sayla',
    'ru': 'Выберите язык',
    'en': 'Choose language',
  };
  Map<String, String> searchHint = {
    'tm': 'Gözle',
    'ru': 'Поиск',
    'en': 'Search',
  };

  Map<String, String> cardTitle = {
    'tm': 'Sebet',
    'ru': 'Корзина',
    'en': 'Cart',
  };
  Map<String, String> total = {
    'tm': 'Jemi',
    'ru': 'Сумма',
    'en': 'Total',
  };
  Map<String, String> settings = {
    'tm': 'huy znaet',
    'ru': 'Настройки',
  };
  Map<String, String> waiting = {
    'tm': 'Garaşyn...',
    'ru': 'Загрузка...',
    'en': 'Waitng...',
  };
  Map<String, String> recs = {
    'tm': 'Hödürlemeler',
    'ru': 'Рекомендации',
    'en': 'Recomdations',
  };
  Map<String, String> addToCart = {
    'tm': 'Sebete gos',
    'ru': 'В корзину',
    'en': 'Add to cart',
  };
  Map<String, String> results = {
    'tm': 'Tapylan',
    'ru': 'Найдено',
    'en': 'Found',
  };
  
}

enum Flavor {
  PRODUCTION,
  STAGING,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return 'Animelist';
      case Flavor.STAGING:
        return 'Staging Animelist';
      default:
        return 'title';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.STAGING:
        return 'https://api.jikan.moe/v4/';
      case Flavor.PRODUCTION:
        return 'https://api.jikan.moe/v4/';
      default:
        return 'https://api.jikan.moe/v4/';
    }
  }
}

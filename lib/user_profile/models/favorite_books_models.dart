class FavoritesBooksModels {
  static List<String> favoriteBookTitles = [];
  static List<String> favoriteBookCovers = [];

  // Method to add a book to favorites
  static void addToFavorites(String title, String cover) {
    favoriteBookTitles.add(title);
    favoriteBookCovers.add(cover);
  }

  static void removeFromFavorites(int index) {

    if (index >= 0 && index < favoriteBookTitles.length) {
      favoriteBookTitles.removeAt(index);
      favoriteBookCovers.removeAt(index);
    }
  }

  // Getter method for book title by index
  static String getBookTitleByIndex(int index) {
    if (index >= 0 && index < favoriteBookTitles.length) {
      return favoriteBookTitles[index];
    } else {
      // Handle index out of bounds, return an empty string or throw an exception
      return '';
    }
  }

  // Getter method for cover by index
  static String getCoverByIndex(int index) {
    if (index >= 0 && index < favoriteBookCovers.length) {
      return favoriteBookCovers[index];
    } else {
      // Handle index out of bounds, return an empty string or throw an exception
      return '';
    }
  }

  static List<String> getFavoriteBooks() {
    return favoriteBookTitles;
  }

  static List<String> getFavoriteBookCovers() {
    return favoriteBookCovers;
  }

  static bool isBookInFavorites(String title) {
    return favoriteBookTitles.contains(title);
  }

}
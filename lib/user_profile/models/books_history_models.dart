class BooksHistoryModel {
  // untuk Judul buku
  static List<String> bookTitle = [];
  // untuk cover buku
  static List<String> cover = [];

  static void returnBooks(String title, String bookCover){
    bookTitle.add(title);
    cover.add(bookCover);
  }

  // Getter method for book title by index
  static String getBookTitleByIndex(int index) {
    if (index >= 0 && index < bookTitle.length) {
      return bookTitle[index];
    } else {
      // Handle index out of bounds, return an empty string or throw an exception
      return '';
    }
  }

  // Getter method for cover by index
  static String getCoverByIndex(int index) {
    if (index >= 0 && index < cover.length) {
      return cover[index];
    } else {
      // Handle index out of bounds, return an empty string or throw an exception
      return '';
    }
  }

  static List<String> getReturnedBooks() {
    return bookTitle;
  }

  static List<String> getReturnedBookCovers() {
    return cover;
  }
}
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bookly_app/Features/Presentation/Controller/bookStates.dart';
import 'package:bookly_app/Features/Presentation/ViewModel/bookModel.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

enum Categories {Business, Food}

class BookController extends Cubit<BookStates> {
  BookController() : super(InitialBookSates()) {
    // getBooks();
    createDatabase();
    getArchiveDatabase();
    getWishlistDatabase();
    getAllCategories();
  }
  List categories = [ 'Food','Business','Art'];
  // String selectedCategory = Categories.Business.toString().split('.')[1].trim();
//https://play.google.com/store/books/details?id=gL34DwAAQBAJ&pli=1&key=AIzaSyAnir1H8lUFUuXr-9hZ3RwJb3OG-95ZCrE
  String apiKey = "AIzaSyAnir1H8lUFUuXr-9hZ3RwJb3OG-95ZCrE";
  String domain = "https://www.googleapis.com/books/v1/volumes";
  List<BookModel> books = [];
  List<BookModel> searchList = [];
  List<BookModel> categoryList = [];
  //List<BookModel> favList = [];
  List<BookModel> archiveList = [];
  List<BookModel> wishListList = [];
  List<Map> bookDetails = [];
  String selectedSearch = "";
  bool isSearch = false;
  List<String> searchTitle=[
  "Category","author","Publisher","Title"
];
  void getBookDetails(BookModel model){
    bookDetails= [
      {
        "title":"Page Number",
        "data":model.bookPageNumber.toString(),
      },
      {
        "title":"Publisher Date",
        "data":model.bookPublisherDate,
      },
      {
        "title":"Rating ",
        "data":model.bookRating.toString(),
      },
      {
        "title":"Publisher",
        "data":model.bookPublisher,
      }
    ];
  }
  Future<void> getAllCategories() async {
    for (int i = 0; i < categories.length; i++) {
      await getBooks(categories[i]);
    }
    print('legnth ========> ${books.length}');
  }
  Database? database;
//"https://www.googleapis.com/books/v1/volumes?q=food&maxResults=40&key=$AIzaSyAnir1H8lUFUuXr-9hZ3RwJb3OG-95ZCrE"
  Future<void> getBooks(String category) async {
    emit(LoadingBookSates());
    try {
      http.Response res =
      await http.get(Uri.parse("$domain?q=$category&maxResults=40&key=$apiKey"));
      if (res.statusCode == 200) {
        Map data = json.decode(res.body);
        List items = data["items"];
        for (Map item in items) {
          books.add(BookModel.fromJson(item));
          // print(books);
        }
        emit(SuccessBookSates());
      } else {
        emit(ErrorBookSates());
      }
    } catch (error) {
      print(error);
      emit(ErrorBookSates());
    }
  }

 Future<void> downLoadBookByGooglePlay(String id) async{
    try{
      http.Response res =
          await http.get(Uri.parse("https://play.google.com/store/books/details?id=$id&pli=1&key=$apiKey"));

    }catch(e){
      print(e);
    }
}
  Future<void> searchBy(String search) async {
    searchList.clear();
    emit(LoadingBookSates());
    try {
      http.Response res =
      await http.get(Uri.parse(
          "$domain?q=$search+$selectedSearch&maxResults=10&key=$apiKey"));
      print(selectedSearch);
      if (res.statusCode == 200) {
        print(res.statusCode);
        Map data = json.decode(res.body);
        List items = data["items"];
        for (Map item in items) {
          searchList.add(BookModel.fromJson(item));
          books.add(BookModel.fromJson(item));
          print(searchList);
          print("${ searchList.length} loop");


        }
        print("${ searchList.length} end loop");

        emit(SuccessBookSates());
      } else {
        emit(ErrorBookSates());
      }
    } catch (error) {
      print(error);
      emit(ErrorBookSates());
    }
  }

  void getSelectedSearch(int index) {
    if (index == 0) {
      selectedSearch = "subject";
      isSearch = true;
      //.titleSearch=searchTitle[index];
      emit(ChangeSearchSates());
    } else if (index == 1) {
      selectedSearch = "inauthor";
      isSearch = true;
     // titleSearch=searchTitle[index];
      emit(ChangeSearchSates());
    } else if (index == 2) {
      selectedSearch = "inpublisher";
      isSearch = true;
     // titleSearch=searchTitle[index];
      emit(ChangeSearchSates());
    } else {
      selectedSearch = "intitle";
      isSearch = true;
     // titleSearch=searchTitle[index];
      emit(ChangeSearchSates());
    }
  }

  getCategoryForModel(BookModel model){
    categoryList.clear();
    for(BookModel book in books){

        book.bookCategory.forEach((element) {
          String categoryBook=element.toString();
          model.bookCategory.forEach((element) {
            String categoryModel=element.toString();
              if(categoryBook==categoryModel){
                print("${book.bookCategory} books");
                print("${model.bookCategory} model");
                 categoryList.add(book);
              }
          });
        });

    }

  }

  Future<void> createDatabase() async{
 emit(LoadingBookSates());
    try{
   database = await openDatabase("database.db", version: 1,
       onCreate: (Database db, int version) async {
         // When creating the db, create the table
         await db.execute(
             'CREATE TABLE archivedBooks (id INTEGER PRIMARY KEY, bookId TEXT)');
         print("createdSuccessfully archive");
         await db.execute(
             'CREATE TABLE wishListedBooks (id INTEGER PRIMARY KEY, bookId TEXT)');
         print("createdSuccessfully wishlist");
       },
       onOpen: (Database db){
         print("da opened");

       }
   );
   emit(SuccessBookSates());

    }catch(error){
      print(error);
      emit(ErrorBookSates());

    }
}
///////////////////////////////////////////////////////////////////////////////////////////
  Future<void> archiveHandle(BookModel model)async{
        emit(AddArchiveLoadingBookSates());
    if(!model.isArchive){
      await _insertArchiveDatabase(model);
        emit(AddFavSuccessBookSates());
    }else{
      await _deleteArchivedItemFromDatabase(model);
        emit(AddFavSuccessBookSates());

    }

}
  Future<void> _insertArchiveDatabase(BookModel model )async {
  try{
    print('inserted1: ${model.bookId}');
    await database!.transaction((txn) async {
      int id = await txn.rawInsert(
          'INSERT INTO archivedBooks(bookId) VALUES(?)',
          ['${model.bookId}']);
      model.idDB=id;
      model.isArchive=true;
          archiveList.add(model);
      print('inserted1: $id');
    });
   // getArchiveDatabase();
  }catch(error){
    print(error);
    emit(AddArchiveErrorBookSates());
  }
}
  Future<void> getArchiveDatabase()async{
    archiveList.clear();
    try{
    List<Map> list = await database!.rawQuery('SELECT * FROM archivedBooks');
    print(list.length);
    list.forEach((elementDB) {
      books.forEach((element) {
        if(element.idDB==elementDB["id"]){
          archiveList.add(element);
        }
      });
    });
    emit(AddArchiveSuccessBookSates());

  }catch(error){
    print(error);
    emit(AddArchiveErrorBookSates());

  }
}
  Future<void> _deleteArchivedItemFromDatabase(BookModel model)async{
  try{
    model.isArchive=false;
    await database!.rawDelete('DELETE FROM archivedBooks WHERE bookId =${model.idDB}');
      for(int i= 0; i<archiveList.length; i++) {
      if( model.idDB == archiveList[i].idDB){
        archiveList.removeAt(i);
        break;
      }
    };
  }catch(error){
    emit(AddArchiveErrorBookSates());
    print(error);

  }
}
  Future<void> deleteArchivedDatabase()async{
    emit(AddArchiveLoadingBookSates());
    try{
      await database!.rawDelete('DELETE  FROM archivedBooks');
      archiveList.clear();
      books.forEach((element) {
        element.isArchive=false;
      });
      emit(AddArchiveSuccessBookSates());
    }catch(error){
      print(error);
      emit(AddArchiveErrorBookSates());

    }
  }
///////////////////////////////////////////////////////////////////////////////////////////
  Future<void> wishListHandle(BookModel model)async{
    emit(AddArchiveLoadingBookSates());
    if(!model.isFav){
      await _insertWishListDatabase(model);
      emit(AddFavSuccessBookSates());
    }else{
      await _deleteWishListedItemFromDatabase(model);
      emit(AddFavSuccessBookSates());

    }

  }
  Future<void> _insertWishListDatabase(BookModel model )async {
    try{
      print('inserted1: ${model.bookId}');
      await database!.transaction((txn) async {
        int id = await txn.rawInsert(
            'INSERT INTO wishListedBooks(bookId) VALUES(?)',
            ['${model.bookId}']);
             model.idDB=id;
            wishListList.add(model);
            model.isFav=true;
        print('inserted1: $id');
      });
     // getWishlistDatabase();
    }catch(error){
      print(error);
      emit(AddArchiveErrorBookSates());
    }
  }
  Future<void> getWishlistDatabase()async{
    wishListList.clear();
    try{
      List<Map> list = await database!.rawQuery('SELECT * FROM wishListedBooks');
      print(list.length);
      list.forEach((elementDB) {
        books.forEach((element) {
          if(element.idDB==elementDB["id"]){
            wishListList.add(element);
          }
        });
      });
      emit(AddArchiveSuccessBookSates());

    }catch(error){
      print(error);
      emit(AddArchiveErrorBookSates());

    }
  }
  Future<void> _deleteWishListedItemFromDatabase(BookModel model)async{
    try{
      await database!.rawDelete('DELETE FROM wishListedBooks WHERE bookId =${model.idDB}');
      for(int i=0 ; i<wishListList.length; i++) {
        print(model.idDB);
        if( model.idDB == wishListList[i].idDB){
          print(model.idDB);
          print(wishListList[i].idDB);
          wishListList.removeAt(i);
          model.isFav=false;
          break;
        }
      };

    }catch(error){
      emit(AddArchiveErrorBookSates());
      print(error);

    }
  }
  Future<void> deleteWishListDatabase()async{
    emit(AddArchiveLoadingBookSates());
    try{
      await database!.rawDelete('DELETE  FROM wishListedBooks');
      wishListList.clear();
      books.forEach((element) {
        element.isFav=false;
      });
      emit(AddArchiveSuccessBookSates());
    }catch(error){
      print(error);
      emit(AddArchiveErrorBookSates());

    }
  }

}




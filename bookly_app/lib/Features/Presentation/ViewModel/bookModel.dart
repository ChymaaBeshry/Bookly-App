
class BookModel{
  String bookId;
  String bookImage;
  String bookLink;
  String bookTitle;
  List bookAuthor;
  String bookSubTitle;
  String bookDescription;
  List bookCategory;
  num bookPageNumber;
  String bookPublisher;
  String bookPublisherDate;
  String bookCountry ;
  String bookLanguage;
  String bookPDF;
  num bookRating;
  String bookGooglePlay;
  bool isFav;
  bool isArchive;
  int idDB;

  BookModel({
    required this.bookAuthor,
    required this.bookLink,
    required this.bookCategory,
    required this.bookCountry,
    required this.bookDescription,
    required this.bookId,
    required this.bookImage,
    required this.bookLanguage,
    required this.bookPageNumber,
    required this.bookPDF,
    required this.bookRating,
    required this.bookPublisher,
    required this.bookPublisherDate,
    required this.bookSubTitle,
    required this.bookTitle,
    required this.bookGooglePlay,
    required this.isFav,
    required this.idDB,
    required this.isArchive
  });

  factory BookModel.fromJson(Map data){
      return BookModel(
        bookLink: data["selfLink"],
        bookTitle:data["volumeInfo"]["title"]??"" ,
        bookImage:data["volumeInfo"]["imageLinks"]["smallThumbnail"]??"" ,
        bookAuthor:data["volumeInfo"]["authors"]??[] ,
        bookCategory:data["volumeInfo"]["categories"]??[],
        bookCountry:data["saleInfo"]["country"]??"" ,
        bookDescription:data["volumeInfo"]["description"]??"" ,
        bookId:data["id"]??"",
        bookLanguage:data["volumeInfo"]["language"]??"" ,
        bookPageNumber:data["volumeInfo"]["pageCount"]??0 ,
        bookPDF:data["accessInfo"]["pdf"]["acsTokenLink"]??"",//pdf
        bookPublisher:data["volumeInfo"]["publisher"]??"" ,
        bookPublisherDate:data["volumeInfo"]["publishedDate"]??"" ,
        bookRating:data["volumeInfo"]["averageRating"]??1 ,
        bookSubTitle:data["volumeInfo"]["subtitle"]??"" ,
        bookGooglePlay:data["accessInfo"]["webReaderLink"]??"" ,
        isFav: false,
        isArchive: false,
        idDB: 0,
      );

  }

  @override
  String toString() {
    return " $bookLink  $bookId , $bookTitle , $bookRating , $bookPageNumber , $bookCategory , $bookAuthor ";
  }

}
abstract class BookStates{}
class InitialBookSates extends BookStates{}

class ErrorBookSates extends BookStates{}
class LoadingBookSates extends BookStates{}
class SuccessBookSates extends BookStates{}

class ChangeSearchSates extends BookStates{}

class AddFavErrorBookSates extends BookStates{}
class AddFavLoadingBookSates extends BookStates{}
class AddFavSuccessBookSates extends BookStates{}

class AddArchiveErrorBookSates extends BookStates{}
class AddArchiveLoadingBookSates extends BookStates{}
class AddArchiveSuccessBookSates extends BookStates{}
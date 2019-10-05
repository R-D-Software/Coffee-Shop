class RenaoException implements Exception {
  String errorMessage;

  RenaoException.notCoffeeItemException() {
    errorMessage = 'Not a CoffeeItem';
  }
}

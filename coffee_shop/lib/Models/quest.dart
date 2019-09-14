class Quest{
  int numberOfPiecies;
  int completedParts;
  String imgPath;

  Quest(this.numberOfPiecies, this.completedParts, this.imgPath);

  int get missingParts => numberOfPiecies-completedParts;
}
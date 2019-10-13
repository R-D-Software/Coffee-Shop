import 'package:flutter/material.dart';

class PuzzlePiece extends StatefulWidget 
{
    final Image image;
    final Size imageSize;
    final int row;
    final int col;
    final int maxRow;
    final int maxCol;

    PuzzlePiece
    (
        {
            Key key,
            @required this.image,
            @required this.imageSize,
            @required this.row,
            @required this.col,
            @required this.maxRow,
            @required this.maxCol
        }
    ) : super(key: key);

    @override
    PuzzlePieceState createState() 
    {
        return new PuzzlePieceState();
    }
}

class PuzzlePieceState extends State<PuzzlePiece> 
{
    @override
    Widget build(BuildContext context) 
    {
        final imageWidth = MediaQuery.of(context).size.width;
        final imageHeight = MediaQuery.of(context).size.height * MediaQuery.of(context).size.width / widget.imageSize.width;

        return Container
        (
            width: imageWidth,
            height: imageHeight,
            child: ClipPath
            (
                child: CustomPaint
                (
                    foregroundPainter: PuzzlePiecePainter(widget.row, widget.col, widget.maxRow, widget.maxCol),
                    child: widget.image
                ),
                clipper: PuzzlePieceClipper(widget.row, widget.col, widget.maxRow, widget.maxCol),
            ),
        );
    }
}

class PuzzlePieceClipper extends CustomClipper<Path> 
{
    final int row;
    final int col;
    final int maxRow;
    final int maxCol;

    PuzzlePieceClipper(this.row, this.col, this.maxRow, this.maxCol);

    @override
    Path getClip(Size size) 
    {
        return getPiecePath(size, row, col, maxRow, maxCol);
    }

    @override
    bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class PuzzlePiecePainter extends CustomPainter 
{
    final int row;
    final int col;
    final int maxRow;
    final int maxCol;

    PuzzlePiecePainter(this.row, this.col, this.maxRow, this.maxCol);

    @override
    void paint(Canvas canvas, Size size) 
    {
        final Paint paint = Paint()
        ..color = Color(0x80FFFFFF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

        canvas.drawPath(getPiecePath(size, row, col, maxRow, maxCol), paint);
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate) 
    {
        return false;
    }
}

Path getPiecePath(Size size, int row, int col, int maxRow, int maxCol) 
{
    final width = size.width / maxCol;
    final height = size.height / maxRow;
    final offsetX = col * width;
    final offsetY = row * height;
    final bumpSize = height / 4;

    Path path = Path();
    path.moveTo(offsetX, offsetY);

    if (row == 0) 
    {
        // top side piece
        path.lineTo(offsetX + width, offsetY);
    } 
    else 
    {
        // top bump
        path.lineTo(offsetX + width / 3, offsetY);
        path.cubicTo(offsetX + width / 6, offsetY - bumpSize, offsetX + width / 6 * 5, offsetY - bumpSize, offsetX + width / 3 * 2, offsetY);
        path.lineTo(offsetX + width, offsetY);
    }

    if (col == maxCol - 1) 
    {
        // right side piece
        path.lineTo(offsetX + width, offsetY + height);
    } 
    else 
    {
        // right bump
        path.lineTo(offsetX + width, offsetY + height / 3);
        path.cubicTo(offsetX + width - bumpSize, offsetY + height / 6, offsetX + width - bumpSize, offsetY + height / 6 * 5, offsetX + width, offsetY + height / 3 * 2);
        path.lineTo(offsetX + width, offsetY + height);
    }

    if (row == maxRow - 1) 
    {
        // bottom side piece
        path.lineTo(offsetX, offsetY + height);
    } 
    else 
    {
        // bottom bump
        path.lineTo(offsetX + width / 3 * 2, offsetY + height);
        path.cubicTo(offsetX + width / 6 * 5, offsetY + height - bumpSize, offsetX + width / 6, offsetY + height - bumpSize, offsetX + width / 3, offsetY + height);
        path.lineTo(offsetX, offsetY + height);
    }

    if (col == 0) 
    {
        // left side piece
        path.close();
    }
    else 
    {
        // left bump
        path.lineTo(offsetX, offsetY + height / 3 * 2);
        path.cubicTo(offsetX - bumpSize, offsetY + height / 6 * 5, offsetX - bumpSize, offsetY + height / 6, offsetX, offsetY + height / 3);
        path.close();
    }

    return path;
}
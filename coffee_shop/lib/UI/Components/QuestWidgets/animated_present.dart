import 'dart:math';

import 'package:coffee_shop/Business/Database/quest_DB.dart';
import 'package:coffee_shop/Models/quest.dart';
import 'package:coffee_shop/UI/Components/QuestWidgets/puzzle_piece.dart';
import 'package:flutter/material.dart';
import 'package:fireworks/fireworks.dart';

class AnimatedPresent extends StatefulWidget 
{
    final Quest quest;
    final double imageHeight;
    bool fireworks = true;
    final QuestStatus questStatus;

    AnimatedPresent({this.quest, this.imageHeight, this.questStatus});

    @override
    _AnimatedPresentState createState() => _AnimatedPresentState();
}

class _AnimatedPresentState extends State<AnimatedPresent> with SingleTickerProviderStateMixin 
{
    AnimationController animationController;
    List<AnimationPerPiece> animations = new List<AnimationPerPiece>();
    List<PuzzlePiece> pieces = new List<PuzzlePiece>();
    bool showAnimation = true;

    @override
    void initState() 
    {
        super.initState();

        if(widget.questStatus == QuestStatus.ITEM_ADDED_TO_CART 
            || widget.questStatus == QuestStatus.ITEM_ORDERED) 
        {
            showAnimation = false;
        }

        pieces = splitImage(Image.asset(widget.quest.imgPath), Size(50,50), widget.quest.numberOfPieciesRow, widget.quest.numberOfPieciesColumn);
        animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));

        for(int i = 0; i < (widget.quest.numberOfPieciesRow*widget.quest.numberOfPieciesColumn); i++)
        {
            animations.add(new AnimationPerPiece
                (
                    animationController: animationController,
                    animation1: Tween<double>(begin: Random().nextInt(1000).toDouble() - 300, end: 0).animate(animationController),
                    animation2: Tween<double>(begin: Random().nextInt(1000).toDouble() - 300, end: 0).animate(animationController)
                )
            );
        }

        for(AnimationPerPiece animation in animations)
        {
            animation.animation1.addListener(() 
            {
                setState(() {});
            });

            animation.animation2.addListener(() 
            {
                setState(() {});
            });
        }

        animationController.forward();
    }

    @override
    void dispose() 
    {
        animationController.stop();
        animationController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) 
    {
        int completedParts = widget.quest.completedParts;

        if(completedParts > (widget.quest.numberOfPieciesColumn * widget.quest.numberOfPieciesRow))
        {
            completedParts = (widget.quest.numberOfPieciesColumn * widget.quest.numberOfPieciesRow);
        }
        return Container
        (
            height: 260,
            width: MediaQuery.of(context).size.width*0.9,
            child: Stack
            (
                children: <Widget>
                [
                    Center
                    (
                        child: Opacity
                        (
                            opacity: (showAnimation) ? 0.2 : 1.0,
                            child: Container
                            (
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset
                                (
                                    widget.quest.imgPath,
                                    fit: BoxFit.contain,
                                ),
                            ),
                        ),
                    ),
                    if(showAnimation)
                        for(int i = 0; i < completedParts; i++) Transform.translate
                        (
                            offset: Offset
                            (
                                animations[i].animation1.value,
                                animations[i].animation2.value
                            ),
                            child: pieces[i],
                        ),
                ],
            ),
        );
    }

    List<PuzzlePiece> splitImage(Image image, Size imageSize, int row, int col) 
    {
        List<PuzzlePiece> retList = new List<PuzzlePiece>();

        for (int x = 0; x < row; x++) 
        {
            for (int y = 0; y < col; y++) 
            {
                retList.add
                (
                    PuzzlePiece
                    (
                        key: LabeledGlobalKey(""),
                        image: image,
                        imageSize: imageSize,
                        row: x,
                        col: y,
                        maxRow: row,
                        maxCol: col
                    )
                );
            }
        }

        return retList;
    }
}

class AnimationPerPiece
{
    final AnimationController animationController;
    final Animation animation1;
    final Animation animation2;

    AnimationPerPiece({this.animationController, this.animation1, this.animation2});
}
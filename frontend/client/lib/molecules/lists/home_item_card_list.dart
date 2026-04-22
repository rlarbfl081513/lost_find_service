import 'package:client/models/home/home_item_card_model.dart';
import 'package:client/molecules/cards/home_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class HomeItemCardList extends StatefulWidget {
  final List<HomeItemCardModel> cardData;
  const HomeItemCardList({super.key, required this.cardData});

  @override
  State<HomeItemCardList> createState() => _HomeItemCardListState();
}

class _HomeItemCardListState extends State<HomeItemCardList> {
  List<HomeItemCard> cards = [];
  int currentIndex = 0;

  void initCards() {
    if (widget.cardData.isEmpty) return;
    for (var card in widget.cardData) {
      cards.add(
        HomeItemCard(
          imageProvider: card.imageProvider,
          date: card.date,
          category: card.category,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    initCards();
  }

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: 300,
          height: 230,
          child: CardSwiper(
            scale: .85,
            maxAngle: 60,
            allowedSwipeDirection: AllowedSwipeDirection.only(
              down: false,
              up: false,
              right: true,
              left: true,
            ),
            numberOfCardsDisplayed: 3,
            backCardOffset: Offset(-30, 10),
            padding: EdgeInsets.zero,
            onSwipe: (previousIndex, currIndex, direction) {
              setState(() {
                currentIndex = currIndex ?? 0;
              });
              return true;
            },
            cardBuilder:
                (
                  context,
                  index,
                  horizontalOffsetPercentage,
                  verticalOffsetPercentage,
                ) {
                  return cards[index];
                },
            cardsCount: cards.length,
          ),
        ),
      ),
    );
  }
}

//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Shaked Dunsky on 01/05/2023.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *broadcastLabel;
@end

@implementation SetCardGameViewController

- (Deck *)createDeck
{
  return [[SetCardDeck alloc] init];
}

- (int) nCardsToMatch 
{
  return 3;
}

- (void) updateUIButton:(UIButton *)cardButton withCard:(SetCard *)card
{
  [cardButton setAttributedTitle:[self titleForCard:card] forState:(UIControlStateNormal)];
  if (card.isChosen && !card.isMatched) {
    [cardButton setBackgroundColor:UIColor.blackColor];
  } else if (card.isMatched){
    [cardButton setBackgroundColor:UIColor.grayColor];
  } else {
    [cardButton setBackgroundColor:UIColor.whiteColor];
  }
}

- (NSDictionary *)attributesFromCard:(SetCard *)card withWidth:(int)width
{
  double r = [card.color[0] doubleValue];
  double g = [card.color[1] doubleValue];
  double b = [card.color[2] doubleValue];
  double a = [card.alpha doubleValue];

  return @{NSForegroundColorAttributeName : [UIColor colorWithRed:r green:g blue:b alpha:a],
           NSStrokeColorAttributeName: [UIColor colorWithRed:r green:g blue:b alpha:1],
           NSStrokeWidthAttributeName: @(-1*width)};

}

- (NSAttributedString *)titleForCard:(SetCard *)card
{
  NSString *content = @"";
  for (int i=0; i<[card.number intValue]; i++) {
    content = [content stringByAppendingString:[NSString stringWithFormat:@"%@\n", card.shape]];
  }
  content = [content substringToIndex:[content length] - 1];

  NSDictionary *cardAttributes = [self attributesFromCard:card withWidth:8];

  return [[NSAttributedString alloc] initWithString:content attributes:cardAttributes];
}

- (NSMutableAttributedString *)messageStringForSelectedCards: (NSArray *)selectedCards
{
  NSMutableAttributedString *message = [[NSMutableAttributedString alloc] init];
  for (SetCard *card in selectedCards) {
    NSDictionary *cardAttributes = [self attributesFromCard:card withWidth:4];
    NSMutableAttributedString *cardsMessage = [[NSMutableAttributedString alloc] initWithString:card.contents attributes:cardAttributes];
    [message appendAttributedString:cardsMessage];
  };
  return message;
}

@end

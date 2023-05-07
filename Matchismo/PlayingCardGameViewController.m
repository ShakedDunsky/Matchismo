//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Shaked Dunsky on 01/05/2023.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *broadcastLabel;
@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
  return [[PlayingCardDeck alloc] init];
}

- (int) nCardsToMatch
{
  return 2;
}

- (void) updateUIButton:(UIButton *)cardButton withCard:(Card *)card
{
  [cardButton setAttributedTitle:[self titleForCard:card] forState:(UIControlStateNormal)];
  [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:(UIControlStateNormal)];
}


- (UIImage *)backgroundImageForCard:(Card *)card
{
  return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
  if (!card.isChosen) return [[NSAttributedString alloc] initWithString:@""];
  return [[NSAttributedString alloc] initWithString:card.contents];
}

@end

//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Shaked Dunsky on 03/05/2023.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@end

static const int FONT_SIZE = 20;

@implementation HistoryViewController

- (void)setText:(NSAttributedString *)text
{
  _text = text;
  [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self updateUI];
}

- (void)updateUI
{
  self.body.attributedText = self.text;
  [self.body setFont:[UIFont systemFontOfSize:FONT_SIZE]];
}

@end

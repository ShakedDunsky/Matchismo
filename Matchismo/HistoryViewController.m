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
}

@end

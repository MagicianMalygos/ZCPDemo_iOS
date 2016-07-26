//
//  LCVodView.m
//  LCPlayerSDKConsumerDemo
//
//  Created by tingting on 16/3/31.
//  Copyright © 2016年 CC. All rights reserved.
//

#import "LCVodView.h"

@interface LCVodView ()

@property (weak, nonatomic) IBOutlet UILabel *uuLabel;

@property (weak, nonatomic) IBOutlet UILabel *vuLabel;

@property (weak, nonatomic) IBOutlet UITextField *uuTextField;

@property (weak, nonatomic) IBOutlet UITextField *vuTextField;

@property (weak, nonatomic) IBOutlet UIView *vuView;

@end

@implementation LCVodView


+(LCVodView *)instanceTextView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"LCVodView" owner:nil options:nil];
    
    return [nibView objectAtIndex:0];
}

- (void)awakeFromNib{
    self.uuTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.vuTextField.clearButtonMode = UITextFieldViewModeAlways;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {

    }
    return self;
}


- (IBAction)clickStartButton:(id)sender {
    
    [self.delegate vodStartPlayUU:self.uuTextField.text vu:_vuTextField.text segType:0];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

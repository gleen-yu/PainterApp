//
//  PainterSetupViewController.m
//  PainterApp
//
//  Created by YUGWANGYONG on 1/25/16.
//  Copyright © 2016 yong. All rights reserved.
//

#import "PainterSetupViewController.h"

@interface PainterSetupViewController ()

@end

@implementation PainterSetupViewController
@synthesize delegate;

// 색상이나 두께가 변경될 때 호출됩니다.
-(IBAction)ValueChange:(id)sender {
    UIColor *tColor = [[UIColor alloc] initWithRed:[self.redBar value] green:[self.greenBar value] blue:[self.blueBar value] alpha:1];
    [self.colorPreView setBackgroundColor:tColor];
}

// 확인 버튼 클릭시 호출
// 델리게이트를 이용해 선의 색상과 두께를 알려준다.
-(IBAction)PushBackClick {
    UIColor *tColor = [[UIColor alloc] initWithRed:[self.redBar value] green:[self.greenBar value] blue:[self.blueBar value] alpha:1];
    [delegate painterSetupViewController:self setColor:tColor];
    [delegate painterSetupViewController:self setWidth:[self.widthBar value]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ViewController.m
//  PainterApp
//
//  Created by YUGWANGYONG on 1/25/16.
//  Copyright © 2016 yong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// Pen 기능 버튼을 클릭할 때 호출
-(IBAction)PenClick {
    [(MainPainterView *)self.view setpCurType:PEN];
}

// Line 기능 버튼을 클릭할 때 호출
-(IBAction)LineClick {
    [(MainPainterView *)self.view setpCurType:LINE];
}

// Circle 기능 버튼을 클릭할 때 호출
-(IBAction)CircleClick {
    [(MainPainterView *)self.view setpCurType:CIRCLE];
}

// Erase 기능 버튼을 클릭할 때 호출
-(IBAction)EraseClick {
    [(MainPainterView *)self.view setpCurType:ERASE];
}

// Rectangle 기능 버튼을 클릭할 때 호출.
-(IBAction)RectangleClick {
    [(MainPainterView *)self.view setpCurType:RECTANGLE];
}

// PainterSetupViewDelegate 델리게이트 구현 함수(색상 설정)
-(void)painterSetupViewController:(PainterSetupViewController *)controller setColor:(UIColor *)color {
    [(MainPainterView *) self.view setpCurColore:color];
}

// PainterSetupViewDelegate 델리게이트 구현 함수(선의 두께 설정)
-(void)painterSetupViewController:(PainterSetupViewController *)controller setWidth:(float)width {
    [(MainPainterView *) self.view setpCurWidth:width];
}

-(IBAction)SetupClick {
    if(pPainterSetupViewController == nil) {
        PainterSetupViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PainterSetupViewController"];
        viewController.delegate = self;
        pPainterSetupViewController = viewController;
    }
    [self presentViewController:pPainterSetupViewController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

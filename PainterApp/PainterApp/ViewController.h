//
//  ViewController.h
//  PainterApp
//
//  Created by YUGWANGYONG on 1/25/16.
//  Copyright © 2016 yong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPainterView.h"
#import "PainterSetupViewController.h"

@interface ViewController : UIViewController<PainterSetupViewDelegate> {
    PainterSetupViewController *pPainterSetupViewController;
}

-(IBAction)PenClick; // Pen 버튼 클릭시 호출
-(IBAction)LineClick; // Line 버튼 클릭시 호출
-(IBAction)CircleClick; // Circle 버튼 클릭시 호출
-(IBAction)EraseClick; // Erase 버튼 클릭시 호출
-(IBAction)RectangleClick; // Rectangle 버튼 클릭시 호출
-(IBAction)SetupClick; // 설정 화면으로 전환

@end


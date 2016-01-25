//
//  MainPainterView.h
//  PainterApp
//
//  Created by YUGWANGYONG on 1/25/16.
//  Copyright © 2016 yong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointData.h"

@interface MainPainterView : UIView {
    NSMutableArray *pPointArray; // 모든 좌표 저장
    
    UIColor *pCurColor; // 선의 색상
    float pCurWidth; // 선의 두께
    TYPES pCurType; // 드로잉 타입
}
@property (nonatomic, retain) PointData *curPointData;
-(void)drawScreen:(PointData *)pData inContext:(CGContextRef)context;
-(void)drawPen:(PointData *)pData inContext:(CGContextRef)context;
-(void)drawLine:(PointData *)pData inContext:(CGContextRef)context;
-(void)drawCircle:(PointData *)pData inContext:(CGContextRef)context;
-(void)drawErase:(PointData *)pData inContext:(CGContextRef)context;
-(void)drawFillRectangle:(PointData *)pData inContext:(CGContextRef)context;
-(void)initCurPointData;
-(void)setpCurType:(TYPES)type;
-(void)setpCurColore:(UIColor *)color;
-(void)setpCurWidth:(float)width;
@end

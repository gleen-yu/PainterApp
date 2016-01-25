//
//  PointData.h
//  PainterApp
//
//  Created by YUGWANGYONG on 1/25/16.
//  Copyright © 2016 yong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    PEN = 0,
    LINE = 1,
    CIRCLE = 2,
    RECTANGLE = 3,
    ERASE = 4
} TYPES;

@interface PointData : NSObject

@property (readonly, nonatomic) NSMutableArray *points;
@property (strong, nonatomic) UIColor *pColor; // 현재 색상
@property float pWidth; // 현재 선의 두께
@property TYPES pType; // 현재 드로잉 타입(PEN, LINE, CIRCLE, RECTANGLE, ERASE)

-(void)addPoint:(CGPoint)point;

@end

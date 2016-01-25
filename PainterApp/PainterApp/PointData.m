//
//  PointData.m
//  PainterApp
//
//  Created by YUGWANGYONG on 1/25/16.
//  Copyright © 2016 yong. All rights reserved.
//

#import "PointData.h"

@implementation PointData
@synthesize points;
-(id)init {
    if(self=[super init]) {
        points = [[NSMutableArray alloc] init]; // 객체 생성
    }
    return self;
}

-(void)addPoint:(CGPoint)point {
    [points addObject:[NSValue valueWithCGPoint:point]];
}

@end

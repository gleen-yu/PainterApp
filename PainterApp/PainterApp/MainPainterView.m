//
//  MainPainterView.m
//  PainterApp
//
//  Created by YUGWANGYONG on 1/25/16.
//  Copyright © 2016 yong. All rights reserved.
//

#import "MainPainterView.h"

@implementation MainPainterView
@synthesize curPointData;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithCoder:(NSCoder *)decoder {
    if(self = [super initWithCoder:decoder]) {
        pPointArray = [[NSMutableArray alloc] init];
        pCurColor = [UIColor blackColor]; // 디폴트 색상을 black으로 설정
        pCurWidth = 2; // 디폴트 선의 두께를 2로 설정
        pCurType = PEN; // 디폴트 드로잉 타입을 PEN으로 설정
        [self initCurPointData];
    }
    return self;
}

-(void)initCurPointData {
    curPointData = [[PointData alloc] init];
    [curPointData setPColor:pCurColor]; // 현재 선의 색상
    [curPointData setPWidth:pCurWidth]; // 현재 선의 두께
    [curPointData setPType:pCurType]; // 현재 드로잉 타입
}

-(void)setpCurType:(TYPES)type { // 드로잉 타입 설정
    pCurType = type;
    [curPointData setPType:type];
}

-(void)setpCurColore:(UIColor *)color{ // 선의 색상 설정
    pCurColor = color;
    [curPointData setPColor:color];
}

-(void)setpCurWidth:(float)width { // 선의 굵기 설정
    pCurWidth = width;
    [curPointData setPWidth:width];
}

-(void)addPointArray {
    [pPointArray addObject:curPointData];
    [self initCurPointData];
}

-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 그래픽 컨텍스트를 구합니다.
    
    for(PointData *pPoint in pPointArray) {
        [self drawScreen:pPoint inContext:context];
    }
    // 저장된 PointData를 이용해 화면을 갱신합니다.
    [self drawScreen:curPointData inContext:context];
}

-(void)drawScreen:(PointData *)pData inContext:(CGContextRef)context {
    switch (pData.pType) {
        case PEN: // 드로잉 타입이 펜(PEN)일 때
            [self drawPen:pData inContext:context];
            break;
        case LINE: // 드로잉 타입이 선(LINE)일 때
            [self drawLine:pData inContext:context];
            break;
        case CIRCLE: // 드로잉 타입이 원(CIRCLE)일 때
            [self drawCircle:pData inContext:context];
            break;
        case RECTANGLE: // 드로잉 타입이 사각형(RECTANGLE)일 때
            [self drawFillRectangle:pData inContext:context];
            break;
        case ERASE: // 드로잉 타입이 지우개(ERASE)일 때
            [self drawErase:pData inContext:context];
            break;
        default:
            break;
    }
}

// 사용자가 터치한 좌표를 따라 순차적으로 선을 그려나가는 메서드
-(void)drawPen:(PointData *)pData inContext:(CGContextRef)context {
    CGColorRef colorRef = [pData.pColor CGColor];
    CGContextSetStrokeColorWithColor(context, colorRef);
    
    // 컨텍스트의 선의 두께 설정
    CGContextSetLineWidth(context, pData.pWidth);
    NSMutableArray *points = [pData points];
    if(points.count == 0) return;
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGPoint firstPoint;
    [[points objectAtIndex:0] getValue:&firstPoint];
    
    // 시작점 설정
    CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
    for (int i=1; i< [points count]; i++) {
        NSValue *value = [points objectAtIndex:i];
        CGPoint point;
        [value getValue:&point];
        CGContextAddLineToPoint(context, point.x, point.y); // 다음 좌표로 이동
    }
    CGContextStrokePath(context); // 좌표에 따라 선 그리기
    
}

// 손가락으로 화면에 터치를 시작한 좌표와 끝 좌표를 이용해 선을 그림
-(void)drawLine:(PointData *)pData inContext:(CGContextRef)context {
    CGColorRef colorRef = [pData.pColor CGColor];
    CGContextSetStrokeColorWithColor(context, colorRef); //  선의 색상 결정
    // 선의 굵기 설정
    CGContextSetLineWidth(context, pData.pWidth);
    NSMutableArray *points = [pData points];
    if(points.count ==0 ) return;
    
    CGPoint firstPoint;
    [[points objectAtIndex:0] getValue:&firstPoint];
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    // 시작점 설정
    CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
    // 끝점 설정
    CGPoint lastPoint;
    [[points objectAtIndex:points.count -1] getValue:&lastPoint];
    CGContextAddLineToPoint(context, lastPoint.x, lastPoint.y);
    CGContextStrokePath(context); // 선 그리기
    
}

// 사각형의 시작 좌표와 끝 좌표 내에 포함된 원형을 그리는 메서드
-(void)drawCircle:(PointData *)pData inContext:(CGContextRef)context {
    CGColorRef colorRef = [pData.pColor CGColor];
    CGContextSetStrokeColorWithColor(context, colorRef);
    
    // 선의 굵기 설정
    CGContextSetLineWidth(context, pData.pWidth);
    
    NSMutableArray *points = [pData points];
    if(points.count == 0) return;
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGPoint firstPoint;
    [[points objectAtIndex:0] getValue:&firstPoint];
    // 끝점 설정
    CGPoint lastPoint;
    [[points objectAtIndex:points.count -1 ] getValue:&lastPoint];
    // 사각형 박스 안에 원 그리기
    CGContextStrokeEllipseInRect(context, CGRectMake(firstPoint.x, firstPoint.y, (lastPoint.x - firstPoint.x), (lastPoint.y - firstPoint.y)));
    CGContextStrokePath(context);
    
}

// 그림을 그리기 위해 CGContext를 이용하는데, 그림판의 지우는 방법은 Blending Mode를 Clear로
// 설정하면 해당 경로의 좌표에 따라 그려지는 부분이 Clear 컬러로 그려진다.
// Clear 컬러는 윈도우의 배경 색으로 설정되므로 설정하지 않으면 검은색으로 표현,
// MainPainterView의 배경색을 흰색으로 설정한다.
// AppDelegate.m 파일을 수정.
// self.window.backgroundColor = [UIColor whiteColor];
-(void)drawErase:(PointData *)pData inContext:(CGContextRef)context {
    // 선의 굵기 설정
    CGContextSetLineWidth(context, 10);
    NSMutableArray *points = [pData points];
    if(points.count == 0) return;
    
    CGPoint firstPoint;
    [[points objectAtIndex:0] getValue:&firstPoint];
    CGContextSetBlendMode(context, kCGBlendModeClear);
    
    // 시작점 설정
    CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
    for (int i=1; i<[points count]; i++) {
        NSValue *value = [points objectAtIndex:i];
        CGPoint point;
        [value getValue:&point];
        
        CGContextAddLineToPoint(context, point.x, point.y);
    }
    // 좌표에 따라 선 그리기
    CGContextStrokePath(context);
}

// 사각형의 시작 좌표와 끝 좌표 내에 설정된 색으로 채운다.
-(void)drawFillRectangle:(PointData *)pData inContext:(CGContextRef)context {
    CGColorRef colorRef = [pData.pColor CGColor];
    CGContextSetStrokeColorWithColor(context, colorRef);
    CGContextSetFillColorWithColor(context, colorRef);
    
    NSMutableArray *points = [pData points];
    if(points.count == 0) return;
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    CGPoint firstPoint;
    [[points objectAtIndex:0] getValue:&firstPoint];
    
    // 끝점 설정
    CGPoint lastPoint;
    [[points objectAtIndex:points.count -1] getValue:&lastPoint];
    // 사각형 박스 안을 지정된 색으로 채웁니다.
    CGContextFillRect(context, CGRectMake(firstPoint.x, firstPoint.y, (lastPoint.x - firstPoint.x), (lastPoint.y - firstPoint.y)));
    
    CGContextStrokePath(context);
}

// 사용자가 터치를 시작하면 호출되는 이벤트 함수
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *array = [touches allObjects];
    for (UITouch *touch in array)
        [curPointData addPoint:[touch locationInView:self]];
    [self setNeedsDisplay]; // 화면을 다시 그립니다.
}

// 메서드 사용자가 화면을 터치한 상태에서 이동 중일 때 호출
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *array = [touches allObjects];
    for (UITouch *touch in array)
        [curPointData addPoint:[touch locationInView:self]];
    [self setNeedsDisplay]; // 화면을 다시 그립니다.
}

// 메서드 사용자가 화면에서 손가락을 떼면 호출되는 이벤트
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *array = [touches allObjects];
    
    for(UITouch *touch in array)
        [curPointData addPoint:[touch locationInView:self]];
    [self addPointArray];
    [self setNeedsDisplay]; // 화면을 다시 그립니다.
}


@end





















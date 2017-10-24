//
//  DictToDataTransformer.m
//  QQ
//
//  Created by weida on 2017/10/23.
//  Copyright © 2017年 weida. All rights reserved.
//

#import "DictToDataTransformer.h"

@implementation DictToDataTransformer
+(BOOL)allowsReverseTransformation
{
    return YES;
}

+(Class)transformedValueClass
{
    return [NSDictionary class];
}

-(id)transformedValue:(id)value
{
    return [NSKeyedArchiver archivedDataWithRootObject:value];
}

-(id)reverseTransformedValue:(id)value
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:value];  
}
@end

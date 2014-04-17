
#import "Kiwi.h"
#import "NSObject+DynamicProperties.h"

@interface SimpleClass : NSObject
@property (nonatomic, strong) NSString *firstString;
@property (nonatomic, strong) NSString *secondString;
@end

@implementation SimpleClass
@end


SPEC_BEGIN(DynamicPropertiesSpec)

describe(@"SimpleClass", ^{
    
    __block SimpleClass *simpleObject;
    
    beforeAll(^{
        simpleObject = [SimpleClass new];
    });
    
    context(@"when asked for all NSString properties", ^{
        
        __block NSArray *allNSStringProperties;
        
        beforeAll(^{
            allNSStringProperties = [simpleObject allPropertiesOfClass:[NSString class]];
        });
        
        it(@"should return [firstString, secondString]", ^{
            [[allNSStringProperties shouldNot] beNil];
            [[theValue(allNSStringProperties.count) should] equal:theValue(2)];
            [[allNSStringProperties[0] should] equal:simpleObject.firstString]; // are the properties guaranteed to be returned in the same order?
            [[allNSStringProperties[1] should] equal:simpleObject.secondString];
        });
    });
});

SPEC_END
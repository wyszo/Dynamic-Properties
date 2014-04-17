
#import "RootClass.h"
#import "NSObject+DynamicProperties.h"


@implementation SmallObject
@end


@interface RootClass ()

@property (nonatomic, strong) SmallObject *smallObject1;
@property (nonatomic, strong) SmallObject *smallObject2;

@end


@implementation RootClass

- (id)init
{
	self = [super init];
	if (self) {
		_smallObject1 = [SmallObject new];
		_smallObject2 = [SmallObject new];
	}
	return self;
}

- (NSArray *)allSmallObjects
{
	return [self allNonemptyPropertiesOfClass:[SmallObject class]];
}

- (void) printSmallObjectProperties
{
	NSArray *smallObjects = [self allSmallObjects];
	NSLog(@"small objects: %@", smallObjects);
}

@end
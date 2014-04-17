
#import "RootClass.h"
#import <objc/message.h>


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
	return [self allPropertiesOfClass:[SmallObject class]];
}

- (NSArray *)allPropertiesOfClass:(Class)aClass
{
	NSLog(@"inside method: %@", NSStringFromSelector(_cmd));
	NSMutableArray *smallObjects = [NSMutableArray new];
	
	// 1. copy property list
	unsigned int numberOfProperties;
	objc_property_t *properties = class_copyPropertyList([self class], &numberOfProperties);
	
	NSLog(@"class has %d properties", numberOfProperties);
	
	// 2. traverse the list and print property names and types
	for (int i=0; i<numberOfProperties; i++) {
		objc_property_t property = properties[i];
		NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
		NSLog(@"property name: %@", propertyName);
		
		id propertyInstance = [self valueForKey:propertyName];
		
		NSLog(@"instance: %@", propertyInstance);
		NSLog(@"property class: %@", NSStringFromClass([propertyInstance class]));
		
		// 3. if class == SmallObject, add to smallObjects array
		if ([propertyInstance isKindOfClass:aClass]) {
			NSLog(@"added %@ to allSmartObjects array", propertyInstance);
			[smallObjects addObject:propertyInstance];
		}
	}
	free(properties);
	
	return [smallObjects copy];
}

- (void) printSmallObjectProperties
{
	NSArray *smallObjects = [self allSmallObjects];
	NSLog(@"small objects: %@", smallObjects);
}

@end
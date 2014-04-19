
Dynamically listing properties of a given type (class)
======================================================

The code shows how to list all nonempty properties of a given type (class) on any object. It's implemented as an NSObject category. You can invoke: 
- (NSArray *)allNonemptyPropertiesOfClass:(Class)aClass;
on any object to get a list of properties that are not nil. 

See main.m and SampleClass.m implementation for usage examples. Also check DynamicPropertiesTestsSpec.m file for kiwi unit tests. 

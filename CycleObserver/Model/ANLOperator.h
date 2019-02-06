#import "_ANLOperator.h"



@interface ANLOperator : _ANLOperator

+(instancetype)operatorInManagedObjectContext:(NSManagedObjectContext *)moc;
+(NSArray *)pathToRoot;

-(NSArray *)pathFromMeasure;
-(NSMutableDictionary *)relationShipsCounter:(NSMutableDictionary *)dictionary;
-(NSString *)alertMessage;

@end

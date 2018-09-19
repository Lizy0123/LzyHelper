
#import "UITableViewCell+Extension.h"

@implementation UITableViewCell(Extension)


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}


- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setSelectedBackgroundView:[[UIView alloc] initWithFrame:self.frame]];
    [self.selectedBackgroundView setBackgroundColor:[UIColor clearColor]];
}


@end

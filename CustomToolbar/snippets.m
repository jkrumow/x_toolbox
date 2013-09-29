/*
- (void)setUpToolBarButtons
{
    CGRect buttonFrame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    
    UIButton *one = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    one.frame = buttonFrame;
    [one setTitle:@"one" forState:UIControlStateNormal];
    
    UIButton *two = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    two.frame = buttonFrame;
    [two setTitle:@"two" forState:UIControlStateNormal];
    
    UIButton *three = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    three.frame = buttonFrame;
    [three setTitle:@"three" forState:UIControlStateNormal];
    
    NSArray *toolBarButtons = [NSArray arrayWithObjects:one, two, three, nil];
    [self.customToolBar setToolBarButtons:toolBarButtons];
    
    CustomContextButton *oneA = [[CustomContextButton alloc] initWithFrame:buttonFrame];
    [oneA setTitle:@"A" forState:UIControlStateNormal];
    [oneA addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
    oneA.hidesContextButtonsWhenPressed = YES;
    
    CustomContextButton *oneB = [[CustomContextButton alloc] initWithFrame:buttonFrame];
    [oneB setTitle:@"B" forState:UIControlStateNormal];
    [oneB addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *contextButtonsForOne = [NSArray arrayWithObjects:oneA, oneB, nil];
    [self.customToolBar setContextButtons:contextButtonsForOne forToolBarButton:one];
    
    
    CustomContextButton *twoX = [[CustomContextButton alloc] initWithFrame:buttonFrame];
    [twoX setTitle:@"X" forState:UIControlStateNormal];
    [twoX addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    CustomContextButton *twoY = [[CustomContextButton alloc] initWithFrame:buttonFrame];
    [twoY setTitle:@"Y" forState:UIControlStateNormal];
    [twoY addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *contextButtonsForTwo = [NSArray arrayWithObjects:twoX, twoY, nil];
    [self.customToolBar setContextButtons:contextButtonsForTwo forToolBarButton:two];
    
    
    CustomContextButton *threePlus = [[CustomContextButton alloc] initWithFrame:buttonFrame];
    [threePlus setTitle:@"+" forState:UIControlStateNormal];
    [threePlus addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    CustomContextButton *threeStar = [[CustomContextButton alloc] initWithFrame:buttonFrame];
    [threeStar setTitle:@"*" forState:UIControlStateNormal];
    [threeStar addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *contextButtonsForThree = [NSArray arrayWithObjects:threePlus, threeStar, nil];
    [self.customToolBar setContextButtons:contextButtonsForThree forToolBarButton:three];
    
}
*/
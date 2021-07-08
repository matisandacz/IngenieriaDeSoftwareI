!classDefinition: #CartWindow category: 'TusLibros-Gui'!
Panel subclass: #CartWindow
	instanceVariableNames: 'tusLibrosClient session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Gui'!

!CartWindow methodsFor: 'initialization' stamp: 'ms 7/7/2021 11:52:16'!
defaultExtent

	^ 1035@485
	! !

!CartWindow methodsFor: 'initialization' stamp: 'MS 7/8/2021 12:43:32'!
initializeTitling: aTitle with: aSession	

	session := aSession .
		
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (CartWindowModel for: session cartId ownedBy: session clientId ).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	
	self subscribeToReturnToShopping.
	self subscribeCheckoutSuccesfull.
	self subscribeCheckoutUnsuccesfull.! !


!CartWindow methodsFor: 'GUI building' stamp: 'GDH 7/8/2021 01:17:52'!
buildFlowButtons

	| buttonsLayoutMorphRow |
	
	buttonsLayoutMorphRow := LayoutMorph newRow.
	buttonsLayoutMorphRow separation: 20; 
	axisEdgeWeight: 0.5;
	addMorph: self returnToShoppingButtonMorph;
	addMorph: self checkOutButtonMorph.
	
	^buttonsLayoutMorphRow.
	! !

!CartWindow methodsFor: 'GUI building' stamp: 'GDH 7/8/2021 15:38:54'!
buildMorphicWindow
		
	self layoutMorph beColumn ;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: self cartMorph;
	addMorph: self buildFlowButtons.
! !


!CartWindow methodsFor: 'component creation' stamp: 'ms 7/7/2021 15:21:51'!
cartMorph
	
	| catalogListWithLabelLayout catalogListMorph |
	
	catalogListMorph := PluggableListMorph model: self model listGetter: #cartContent indexGetter: #cartContentIndex indexSetter: #cartContentIndex:.

	catalogListMorph  borderColor: Color black ; borderWidth: 1; morphWidth:300.
		
	catalogListWithLabelLayout := LayoutMorph newColumn.
	catalogListWithLabelLayout separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Cart Content: ');
	addMorph: catalogListMorph.
	
	catalogListMorph layoutSpec proportionalWidth: 100.
		
	^catalogListWithLabelLayout.! !

!CartWindow methodsFor: 'component creation' stamp: 'GDH 7/8/2021 00:48:18'!
checkOutButtonMorph
	
	^PluggableButtonMorph model: self model action: #checkout  label: 'Checkout'.
! !

!CartWindow methodsFor: 'component creation' stamp: 'GDH 7/8/2021 00:48:27'!
returnToShoppingButtonMorph
	
	^PluggableButtonMorph model: self model action: #returnToShopping  label: 'Go Back'.! !


!CartWindow methodsFor: 'shopping - transition' stamp: 'GDH 7/8/2021 01:16:20'!
openShoppingWindow

	ShoppingWindow openWith: session.
	
	self closeButtonClicked.! !


!CartWindow methodsFor: 'error modal - transition' stamp: 'GDH 7/8/2021 01:53:59'!
openErrorModal

	ErrorMessageWindow openTitling: 'Checkout unsuccesfull :(' 
						description: self model errorMessage 
						buttonLabel:  'Close'
						buttonActionBlock: []
	! !


!CartWindow methodsFor: 'ticket - transition' stamp: 'GDH 7/8/2021 01:56:15'!
openTicketWindow
	
	TicketWindow openWith: session issued: self model ticket.
	
	self closeButtonClicked.
! !


!CartWindow methodsFor: 'subscriptions' stamp: 'GDH 7/8/2021 01:38:16'!
subscribeCheckoutSuccesfull

	^ self model when: #checkoutSuccesfull send: #openTicketWindow to: self! !

!CartWindow methodsFor: 'subscriptions' stamp: 'GDH 7/8/2021 01:38:41'!
subscribeCheckoutUnsuccesfull

	^ self model when: #checkoutUnsuccesfull send: #openErrorModal to: self! !

!CartWindow methodsFor: 'subscriptions' stamp: 'ms 7/7/2021 15:53:39'!
subscribeToReturnToShopping

	^ self model when: #returnToShopping send: #openShoppingWindow to: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartWindow class' category: 'TusLibros-Gui'!
CartWindow class
	instanceVariableNames: ''!

!CartWindow class methodsFor: 'instance creation' stamp: 'GDH 7/8/2021 01:10:39'!
openWith: aSession
	
	^self new initializeTitling: 'Cart Window' with: aSession.! !


!classDefinition: #ErrorMessageWindow category: 'TusLibros-Gui'!
Panel subclass: #ErrorMessageWindow
	instanceVariableNames: 'actionButtonBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Gui'!

!ErrorMessageWindow methodsFor: 'GUI building' stamp: 'GDH 7/8/2021 01:47:50'!
buildActionButton: aButtonLabel
	
	^PluggableButtonMorph model: self model action: #actionButtonCallback label: aButtonLabel.! !

!ErrorMessageWindow methodsFor: 'GUI building' stamp: 'MS 7/8/2021 15:53:02'!
buildDescriptionMessage: aDescription

	| firstRowLayoutMorph |

	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 0;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: aDescription).
	
	^firstRowLayoutMorph.! !

!ErrorMessageWindow methodsFor: 'GUI building' stamp: 'GDH 7/8/2021 01:46:41'!
buildMorphicWindowWithDescription: aDescription buttonLabel: aButtonLabel
		
	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: (self buildDescriptionMessage: aDescription);
	addMorph: (self buildActionButton: aButtonLabel).! !


!ErrorMessageWindow methodsFor: 'initialization' stamp: 'MS 7/8/2021 15:53:59'!
defaultExtent

	^1600@200.
	! !

!ErrorMessageWindow methodsFor: 'initialization' stamp: 'GDH 7/8/2021 01:45:42'!
initializeTitling: aTitle description: aDescription buttonLabel: aButtonLabel

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (ErrorMessageWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindowWithDescription: aDescription buttonLabel: aButtonLabel .
	self openInWorld.
	self yourself.
	
	self suscribeToCallback .
	
	! !

!ErrorMessageWindow methodsFor: 'initialization' stamp: 'GDH 7/8/2021 01:49:02'!
initializeTitling: aTitle description: aDescription buttonLabel: aButtonLabel buttonAction: aButtonActionBlock
	
	actionButtonBlock := aButtonActionBlock.
	
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (ErrorMessageWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindowWithDescription: aDescription buttonLabel: aButtonLabel .
	self openInWorld.
	self yourself.
	
	self suscribeToCallback .
	
	! !

!ErrorMessageWindow methodsFor: 'initialization' stamp: 'GDH 7/8/2021 01:42:47'!
suscribeToCallback

	^ self model when: #executeCallback send: #executeCallbackBlock to: self! !


!ErrorMessageWindow methodsFor: 'action - transitions' stamp: 'GDH 7/8/2021 01:51:40'!
executeCallbackBlock

	actionButtonBlock value.
	
	self closeButtonClicked .! !

!ErrorMessageWindow methodsFor: 'action - transitions' stamp: 'ms 7/7/2021 16:15:55'!
openLoginWindow

	LoginWindow open.
	
	self closeButtonClicked.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ErrorMessageWindow class' category: 'TusLibros-Gui'!
ErrorMessageWindow class
	instanceVariableNames: ''!

!ErrorMessageWindow class methodsFor: 'instance creation' stamp: 'GDH 7/8/2021 01:50:32'!
openTitling: aTitle description: aDescription buttonLabel: buttonLabel buttonActionBlock: aButtonActionBlock
	
	^self new initializeTitling: aTitle description: aDescription buttonLabel: buttonLabel buttonAction: aButtonActionBlock! !


!classDefinition: #LoginWindow category: 'TusLibros-Gui'!
Panel subclass: #LoginWindow
	instanceVariableNames: 'clientIdTextBoxMorph passwordTextBoxMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Gui'!

!LoginWindow methodsFor: 'initialization' stamp: 'ms 7/6/2021 17:03:48'!
defaultExtent

	^ 1035@485
	! !

!LoginWindow methodsFor: 'initialization' stamp: 'GDH 7/7/2021 19:06:30'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (LoginWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	
	self suscribeToCartCreated.
	self suscribeCartNotCreated 
			
	! !


!LoginWindow methodsFor: 'GUI building' stamp: 'ms 7/6/2021 19:40:26'!
buildClientIdInput

	| firstRowLayoutMorph |
	
	clientIdTextBoxMorph := TextModelMorph textProvider: self model textGetter: #clientIdText textSetter: #clientIdText:. 
	clientIdTextBoxMorph textMorph setProperty: #keyStroke: toValue: [ :key | clientIdTextBoxMorph textMorph acceptContents ] .
	clientIdTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300. 
		
	firstRowLayoutMorph := LayoutMorph newRow.
	firstRowLayoutMorph separation: 10;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'clientId:');
	addMorph: clientIdTextBoxMorph.

	
	^firstRowLayoutMorph.! !

!LoginWindow methodsFor: 'GUI building' stamp: 'GDH 7/7/2021 23:52:38'!
buildLoginButton
	
	^PluggableButtonMorph model: self model action: #createCartRequest  label: 'Login'.! !

!LoginWindow methodsFor: 'GUI building' stamp: 'ms 7/6/2021 19:40:46'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self buildClientIdInput;
	addMorph: self buildPasswordInput;
	addMorph: self buildLoginButton.
! !

!LoginWindow methodsFor: 'GUI building' stamp: 'GDH 7/6/2021 22:14:21'!
buildPasswordInput

	| secondRowLayoutMorph |

	passwordTextBoxMorph := TextModelMorph textProvider: self model textGetter: #passwordText textSetter: #passwordText:. 
	passwordTextBoxMorph textMorph setProperty: #keyStroke: toValue: [ :key | passwordTextBoxMorph textMorph acceptContents ] .
	passwordTextBoxMorph  borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300. 
	
	secondRowLayoutMorph := LayoutMorph newRow.
	secondRowLayoutMorph separation: 10;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'password:');
	addMorph: passwordTextBoxMorph.

	
	^secondRowLayoutMorph.
	
	! !


!LoginWindow methodsFor: 'shopping - transition' stamp: 'GDH 7/8/2021 01:02:20'!
openShoppingWindow

	ShoppingWindow openWith: self model session.
	
	self closeButtonClicked.! !


!LoginWindow methodsFor: 'event suscriptions' stamp: 'GDH 7/7/2021 19:03:47'!
suscribeCartNotCreated

	^ self model when: #cartNotCreated send: #openInvalidCredentialsWindow to: self! !

!LoginWindow methodsFor: 'event suscriptions' stamp: 'GDH 7/8/2021 00:37:35'!
suscribeToCartCreated

	^ self model when: #cartCreated send: #openShoppingWindow to: self! !


!LoginWindow methodsFor: 'invalid creds - transition' stamp: 'GDH 7/8/2021 01:51:48'!
openInvalidCredentialsWindow
	
	ErrorMessageWindow openTitling: 'Invalid Credentials Window' 
						description: 'Invalid clientId or password. Please try again.' 
						buttonLabel: 'Please try again'
						buttonActionBlock: [ LoginWindow open. ].
	
	self closeButtonClicked.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LoginWindow class' category: 'TusLibros-Gui'!
LoginWindow class
	instanceVariableNames: ''!

!LoginWindow class methodsFor: 'as yet unclassified' stamp: 'GDH 7/7/2021 23:13:13'!
open
	
	^self new initializeWith: 'Login Window'.! !


!classDefinition: #PurchasesWindow category: 'TusLibros-Gui'!
Panel subclass: #PurchasesWindow
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Gui'!

!PurchasesWindow methodsFor: 'initialization' stamp: 'GDH 7/8/2021 00:19:27'!
defaultExtent
	
	^1035@485.
	! !

!PurchasesWindow methodsFor: 'initialization' stamp: 'GDH 7/8/2021 01:13:26'!
initializeTitling: aTitle with: aSession

	session := aSession.
	
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (PurchasesWindowModel for: session clientId authenticating: session password ).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	
	self suscribeShowShoppingWindow.
	! !


!PurchasesWindow methodsFor: 'shopping - transition' stamp: 'GDH 7/8/2021 01:12:53'!
openShoppingWindow
	
	ShoppingWindow openWith: session.
	
	self closeButtonClicked.
	! !


!PurchasesWindow methodsFor: 'event suscription' stamp: 'GDH 7/8/2021 00:54:05'!
suscribeShowShoppingWindow
	
	^ self model when: #showShoppingWindow send: #openShoppingWindow to: self
! !


!PurchasesWindow methodsFor: 'GUI building' stamp: 'GDH 7/8/2021 00:51:20'!
buildFlowButtons
	
	^PluggableButtonMorph model: self model action: #showShoppingWindow label: 'Go back'! !

!PurchasesWindow methodsFor: 'GUI building' stamp: 'GDH 7/8/2021 00:27:59'!
buildMorphicWindow
	
	self layoutMorph beColumn ;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: self purchasesListMorph;
	addMorph: self buildFlowButtons .! !


!PurchasesWindow methodsFor: 'Components creation' stamp: 'GDH 7/8/2021 00:27:34'!
purchasesListMorph
	
	| pruchasesListWithLabelLayout catalogListMorph |
	
	catalogListMorph := PluggableListMorph model: self model listGetter: #purchases indexGetter: #purchasesListIndex indexSetter: #purchasesListIndex:.
	catalogListMorph  borderColor: Color black ; borderWidth: 1.
		
	pruchasesListWithLabelLayout := LayoutMorph newColumn.
	pruchasesListWithLabelLayout separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Purchase history: ');
	addMorph: catalogListMorph.
	
	catalogListMorph layoutSpec proportionalWidth: 200.
		
	^pruchasesListWithLabelLayout.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchasesWindow class' category: 'TusLibros-Gui'!
PurchasesWindow class
	instanceVariableNames: ''!

!PurchasesWindow class methodsFor: 'as yet unclassified' stamp: 'GDH 7/8/2021 01:05:34'!
openWith: aSession
	
	^self new initializeTitling: 'Purchases list Window' with: aSession.! !


!classDefinition: #ShoppingWindow category: 'TusLibros-Gui'!
Panel subclass: #ShoppingWindow
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Gui'!

!ShoppingWindow methodsFor: 'initialization' stamp: 'ms 7/6/2021 18:02:48'!
defaultExtent

	^ 1035@485
	! !

!ShoppingWindow methodsFor: 'initialization' stamp: 'GDH 7/8/2021 15:32:53'!
initializeTitling: aTitle with: aSession

	session := aSession.
	
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (ShoppingWindowModel for: session cartId ).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	
	self suscribeAddedToCartSuccessfully.
	self suscribeShowListCart .
	self suscribeShowUserPurchases.
	self suscribeRemoveSuccesful.
	self suscribeRemoveUnsuccesful.
			
	! !


!ShoppingWindow methodsFor: 'GUI building' stamp: 'GDH 7/7/2021 23:51:26'!
buildFlowButtons
	
	| flowButtonLayoutMorphRow |
		
	flowButtonLayoutMorphRow := LayoutMorph newRow.
	flowButtonLayoutMorphRow separation: 20;
	axisEdgeWeight: 0.5;
	addMorph: self purchasesButtonMorph ;
	addMorph: self cartButtonMorph.
	
	^flowButtonLayoutMorphRow 
	
! !

!ShoppingWindow methodsFor: 'GUI building' stamp: 'GDH 7/7/2021 23:38:11'!
buildMorphicWindow
		
	self layoutMorph beColumn ;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: self buildShopping;
	addMorph: self buildFlowButtons .
! !

!ShoppingWindow methodsFor: 'GUI building' stamp: 'GDH 7/7/2021 23:53:15'!
buildShopping
	
	| shoppingLayoutMorphRow |
	
	shoppingLayoutMorphRow := LayoutMorph newRow.
	shoppingLayoutMorphRow separation: 20; 
	axisEdgeWeight: 0.5;
	addMorph: self catalogMorph;
	addMorph: self quantityToAddMorph;
	addMorph: self addToCartButtonMorph;
	addMorph: self removeFromCartButtonMorph.
		
	^shoppingLayoutMorphRow.! !

!ShoppingWindow methodsFor: 'GUI building' stamp: 'GDH 7/7/2021 23:37:50'!
cartButtonMorph
	
	^PluggableButtonMorph model: self model action: #showCartList label: 'Go to cart'.! !

!ShoppingWindow methodsFor: 'GUI building' stamp: 'GDH 7/8/2021 00:03:15'!
purchasesButtonMorph
	
	^PluggableButtonMorph model: self model action: #openUserPurchases label: 'See purchases'.! !


!ShoppingWindow methodsFor: 'Components creation' stamp: 'GDH 7/7/2021 23:44:33'!
addToCartButtonMorph
	
	^PluggableButtonMorph model: self model action: #addToCart  label: 'Add selected to cart'.
! !

!ShoppingWindow methodsFor: 'Components creation' stamp: 'GDH 7/7/2021 01:46:21'!
catalogMorph
	
	| catalogListWithLabelLayout catalogListMorph |
	
	catalogListMorph := PluggableListMorph model: self model listGetter: #catalog indexGetter: #catalogListIndex indexSetter: #catalogListIndex:.
	catalogListMorph  borderColor: Color black ; borderWidth: 1; morphWidth:300.
		
	catalogListWithLabelLayout := LayoutMorph newColumn.
	catalogListWithLabelLayout separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Catalog: ');
	addMorph: catalogListMorph.
	
	catalogListMorph layoutSpec proportionalWidth: 100.
		
	^catalogListWithLabelLayout.! !

!ShoppingWindow methodsFor: 'Components creation' stamp: 'GDH 7/7/2021 02:59:26'!
openAddedSuccesfullyDialog
	
	"Mostrar dialogo que salio bien"! !

!ShoppingWindow methodsFor: 'Components creation' stamp: 'GDH 7/7/2021 02:42:39'!
quantityToAddMorph

	| quantityWithLabelLayoutMorph quantityFieldMorph |
	
	quantityFieldMorph := PluggableListMorph model: self model listGetter: #itemQuantities indexGetter: #itemQuantitiesListIndex indexSetter: #itemQuantitiesListIndex:.
	quantityFieldMorph  borderColor: Color black ; borderWidth: 1.
	
	quantityWithLabelLayoutMorph := LayoutMorph newColumn.
	quantityWithLabelLayoutMorph axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: 'Set quantity (default 1)' );
	addMorph: quantityFieldMorph.
	
	quantityFieldMorph layoutSpec proportionalWidth: 100. 
	" wordsListMorph layoutSpec proportionalHeight: 100."
		
	^quantityWithLabelLayoutMorph.! !

!ShoppingWindow methodsFor: 'Components creation' stamp: 'GDH 7/7/2021 23:45:30'!
removeFromCartButtonMorph
	
	^PluggableButtonMorph model: self model action: #removeFromCart label: 'Remove From Cart'.
! !


!ShoppingWindow methodsFor: 'event suscriptions' stamp: 'GDH 7/7/2021 02:59:40'!
suscribeAddedToCartSuccessfully

	^ self model when: #addedSuccesfullyToCart send: #openAddedSuccesfullyDialog to: self.
			
	! !

!ShoppingWindow methodsFor: 'event suscriptions' stamp: 'GDH 7/8/2021 15:32:33'!
suscribeRemoveSuccesful

	^ self model when: #removeSuccesful send: #openRemoveSuccesfulDialog to: self.
			
	! !

!ShoppingWindow methodsFor: 'event suscriptions' stamp: 'GDH 7/8/2021 15:32:38'!
suscribeRemoveUnsuccesful

	^ self model when: #removeUnsuccesful send: #openRemoveErrorDialog to: self.
			
	! !

!ShoppingWindow methodsFor: 'event suscriptions' stamp: 'GDH 7/7/2021 03:02:29'!
suscribeShowListCart

	^ self model when: #showListCart send: #openCartListWindow to: self.
			
	! !

!ShoppingWindow methodsFor: 'event suscriptions' stamp: 'GDH 7/8/2021 00:03:15'!
suscribeShowUserPurchases

	^ self model when: #openUserPurchases send: #openUserPurchases to: self.
			
	! !


!ShoppingWindow methodsFor: 'cart - transition' stamp: 'GDH 7/8/2021 01:05:02'!
openCartListWindow
	
	CartWindow openWith: session.
	
	self closeButtonClicked.! !


!ShoppingWindow methodsFor: 'purchases - transition' stamp: 'GDH 7/8/2021 01:04:43'!
openUserPurchases
	
	PurchasesWindow openWith: session.
	
	self closeButtonClicked .! !


!ShoppingWindow methodsFor: 'remove - transition' stamp: 'GDH 7/8/2021 15:31:47'!
openRemoveErrorDialog
	
	ErrorMessageWindow openTitling: 'Error while trying to remove items' 
						description: 'Number of items exceeded the ones you have.'
						buttonLabel:  'Close'
						buttonActionBlock: []
			
	! !

!ShoppingWindow methodsFor: 'remove - transition' stamp: 'GDH 7/8/2021 15:33:30'!
openRemoveSuccesfulDialog
			
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingWindow class' category: 'TusLibros-Gui'!
ShoppingWindow class
	instanceVariableNames: ''!

!ShoppingWindow class methodsFor: 'instance creation' stamp: 'GDH 7/8/2021 01:02:45'!
openWith: aSession

	self new initializeTitling: 'Shopping Window' with: aSession.
! !


!classDefinition: #TicketWindow category: 'TusLibros-Gui'!
Panel subclass: #TicketWindow
	instanceVariableNames: 'tusLibrosClient session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Gui'!

!TicketWindow methodsFor: 'GUI building' stamp: 'GDH 7/8/2021 01:17:52'!
buildFlowButtons

	| buttonsLayoutMorphRow |
	
	buttonsLayoutMorphRow := LayoutMorph newRow.
	buttonsLayoutMorphRow separation: 20; 
	axisEdgeWeight: 0.5;
	addMorph: self continueShoppingButtonMorph ;
	addMorph: self logoutButtonMorph.
	
	^buttonsLayoutMorphRow.
	! !

!TicketWindow methodsFor: 'GUI building' stamp: 'GDH 7/8/2021 02:01:00'!
buildMorphicWindow
		
	self layoutMorph beColumn ;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: self ticketMorph;
	addMorph: self buildFlowButtons.
! !


!TicketWindow methodsFor: 'initialization' stamp: 'MS 7/7/2021 21:21:26'!
defaultExtent

	^ 1035@485
	! !

!TicketWindow methodsFor: 'initialization' stamp: 'GDH 7/8/2021 02:48:20'!
initializeTitling: aTitle with: aSession issued: aTicket

	session := aSession.
	
	tusLibrosClient := TusLibrosClient new.
	
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TicketWindowModel with: aSession issued: aTicket ).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	
	self subscribeToLogout.
	self subscribeToContinueShopping.	! !


!TicketWindow methodsFor: 'component creation' stamp: 'MS 7/7/2021 21:28:29'!
continueShoppingButtonMorph

	| continueShoppingButtonMorph secondRowLayoutMorph |
	
	continueShoppingButtonMorph := PluggableButtonMorph model: self model action: #continueShopping  label: 'Continue Shopping'.

	secondRowLayoutMorph := LayoutMorph newRow.
	secondRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
 	addMorph: continueShoppingButtonMorph.
	
	^secondRowLayoutMorph.
! !

!TicketWindow methodsFor: 'component creation' stamp: 'MS 7/7/2021 21:29:52'!
logoutButtonMorph

	| logoutCartButtonMorph secondRowLayoutMorph |
	
	logoutCartButtonMorph := PluggableButtonMorph model: self model action: #logout  label: 'Logout'.

	secondRowLayoutMorph := LayoutMorph newRow.
	secondRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
 	addMorph: logoutCartButtonMorph.
	
	^secondRowLayoutMorph.
! !

!TicketWindow methodsFor: 'component creation' stamp: 'GDH 7/8/2021 02:05:23'!
ticketMorph
	
	| ticketLabelLayout ticketMorph |
	
	ticketMorph := PluggableListMorph model: self model listGetter: #ticket indexGetter: #ticketIndex indexSetter: #ticketIndex:.

	ticketMorph  borderColor: Color black ; borderWidth: 1.
		
	ticketLabelLayout := LayoutMorph newColumn.
	ticketLabelLayout separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Ticket: ');
	addMorph: ticketMorph.
	
	ticketMorph layoutSpec proportionalWidth: 200.
		
	^ticketLabelLayout.! !


!TicketWindow methodsFor: 'login - transition' stamp: 'MS 7/7/2021 21:39:45'!
openLoginWindow

	LoginWindow open.
	
	self closeButtonClicked.! !


!TicketWindow methodsFor: 'shopping - transition' stamp: 'GDH 7/8/2021 02:41:42'!
openShoppingWindow

	ShoppingWindow openWith: self model session.
	
	self closeButtonClicked.! !


!TicketWindow methodsFor: 'suscriptions' stamp: 'MS 7/7/2021 21:47:27'!
subscribeToContinueShopping

	^ self model when: #continueShopping send: #openShoppingWindow to: self! !

!TicketWindow methodsFor: 'suscriptions' stamp: 'MS 7/7/2021 21:40:51'!
subscribeToLogout

	^ self model when: #logout send: #openLoginWindow to: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicketWindow class' category: 'TusLibros-Gui'!
TicketWindow class
	instanceVariableNames: ''!

!TicketWindow class methodsFor: 'as yet unclassified' stamp: 'GDH 7/8/2021 01:56:45'!
openWith: aSession issued: aTicket
	
	^self new initializeTitling: 'Ticket Window' with: aSession issued: aTicket.! !


!classDefinition: #TusLibrosClient category: 'TusLibros-Gui'!
Panel subclass: #TusLibrosClient
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Gui'!

!TusLibrosClient methodsFor: 'sending requests' stamp: 'ms 7/6/2021 17:46:33'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !


!TusLibrosClient methodsFor: 'accessing' stamp: 'GDH 7/8/2021 15:30:27'!
port
	
	^port ifNil: [port:=9092].! !

!TusLibrosClient methodsFor: 'accessing' stamp: 'ms 7/6/2021 17:44:23'!
url
	
	^'http://localhost:', self port asString.! !


!TusLibrosClient methodsFor: 'get' stamp: 'GDH 7/8/2021 01:21:23'!
getCatalogRequest

	| parameteres clientResponse path |
	
	parameteres := Dictionary new.
	path := '/catalog'.
	
	clientResponse := WebClient htmlSubmit: (self url, path) fields: parameteres.

	clientResponse isSuccess 
		ifTrue:[ ^(WebUtils jsonDecode: ((clientResponse content) readStream)). ] 
		ifFalse:[ ^self error: clientResponse content ].! !

!TusLibrosClient methodsFor: 'get' stamp: 'GDH 7/8/2021 01:20:57'!
getListCartRequestFor: aCartId
	
	| parameteres clientResponse path |
	
	parameteres := Dictionary newFromPairs: {'cartId'. aCartId }.		
	path := '/listCart'.
	
	clientResponse := WebClient htmlSubmit: (self url, path) fields: parameteres.

	clientResponse isSuccess 
		ifTrue:[ ^(WebUtils jsonDecode: ((clientResponse content) readStream)) asOrderedCollection . ] 
		ifFalse:[ ^self error: clientResponse content ].! !

!TusLibrosClient methodsFor: 'get' stamp: 'GDH 7/8/2021 00:16:25'!
getPurchasesFor: aClientId authenticatingWith: aPassword
	
	| parameteres clientResponse path |
	
	parameteres := Dictionary newFromPairs: {'clientId'. aClientId.
									    'password'. aPassword.}.		
	path := '/listPurchases'.
	
	clientResponse := WebClient htmlSubmit: (self url, path) fields: parameteres.

	clientResponse isSuccess 
		ifTrue:[ ^(WebUtils jsonDecode: ((clientResponse content) readStream)) . ] 
		ifFalse:[ ^self error: clientResponse content ].! !


!TusLibrosClient methodsFor: 'post' stamp: 'GDH 7/8/2021 01:20:44'!
postAddToCart: aCartId of: aCatalogItem amount: anItemQuantity
	
	| parameters clientResponse path |
	
	path := '/addToCart'.
	parameters := Dictionary newFromPairs: {'cartId'. aCartId. 
									  'bookIsbn'. aCatalogItem.
									  'bookQuantity'. anItemQuantity.	}.		
	
	clientResponse := WebClient htmlSubmit: (self url, path) fields: parameters.

	clientResponse isSuccess 
		ifFalse:[^self error: clientResponse content].! !

!TusLibrosClient methodsFor: 'post' stamp: 'MS 7/8/2021 12:41:18'!
postCheckoutCart: aCartId ownedBy: aClientId
	
	| parameters clientResponse path |
	
	path := '/checkOutCart'.
	parameters := Dictionary newFromPairs: {'cartId'. aCartId. 'clientId'. aClientId }.		
		
	clientResponse := WebClient htmlSubmit: (self url, path) fields: parameters.

	clientResponse isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((clientResponse content) readStream)).]
		ifFalse:[^self error: clientResponse content].! !

!TusLibrosClient methodsFor: 'post' stamp: 'GDH 7/8/2021 01:20:34'!
postCreateCartRequestAuthenticating: aClientId with: aPassword

	| parameters clientResponse urlEncodedclientId urlEncodedPassword path |

	urlEncodedclientId := self correctlyEncodeSpacesForUrlRequestParameter: aClientId.	
	urlEncodedPassword := self correctlyEncodeSpacesForUrlRequestParameter: aPassword.	
	
	path := '/createCart'.
	parameters := Dictionary newFromPairs: {'clientId'. urlEncodedclientId . 'password'. urlEncodedPassword }.		
	
	clientResponse := WebClient htmlSubmit: (self url, path) fields: parameters.

	clientResponse isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((clientResponse content) readStream)).] 
		ifFalse:[^self error: clientResponse content].! !

!TusLibrosClient methodsFor: 'post' stamp: 'ms 7/7/2021 15:10:57'!
postRemoveFromCart: aCartId of: aCatalogItem amount: anItemQuantity

	| parameters clientResponse endpoint |
	
	endpoint := '/removeFromCart'.
	parameters := Dictionary newFromPairs: {'cartId'. aCartId. 
									  'bookIsbn'. aCatalogItem.
									  'bookQuantity'. anItemQuantity.	}.		
	
	clientResponse := WebClient htmlSubmit: (self url, endpoint) fields: parameters.

	clientResponse isSuccess 
		ifFalse:[^self error: clientResponse content].! !


!classDefinition: #CartWindowModel category: 'TusLibros-Gui'!
Object subclass: #CartWindowModel
	instanceVariableNames: 'cartId cartContent cartContentIndex tusLibrosClient quantity quantitiyListIndex ticket errorMessage clientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Gui'!

!CartWindowModel methodsFor: 'cartContent' stamp: 'GDH 7/8/2021 01:23:48'!
cartContent

	^tusLibrosClient getListCartRequestFor: cartId .! !

!CartWindowModel methodsFor: 'cartContent' stamp: 'ms 7/7/2021 12:09:22'!
cartContentIndex

	^cartContentIndex.! !

!CartWindowModel methodsFor: 'cartContent' stamp: 'ms 7/7/2021 12:09:42'!
cartContentIndex: aNewCartContentIndex

	cartContentIndex := aNewCartContentIndex.! !


!CartWindowModel methodsFor: 'initialization' stamp: 'GDH 7/8/2021 01:23:57'!
initializeFor: aCartId


	tusLibrosClient := TusLibrosClient new.
	
	cartId := aCartId.	
	cartContentIndex := 1.
	! !

!CartWindowModel methodsFor: 'initialization' stamp: 'MS 7/8/2021 12:44:36'!
initializeFor: aCartId ownedBy: aClientId


	tusLibrosClient := TusLibrosClient new.
	
	cartId := aCartId.	
	clientId := aClientId.
	cartContentIndex := 1.
	! !


!CartWindowModel methodsFor: 'checkout' stamp: 'MS 7/8/2021 13:15:16'!
checkout

	[ ticket := tusLibrosClient postCheckoutCart: cartId ownedBy: clientId. 
		self triggerEvent: #checkoutSuccesfull with: self ]
		on: Error
		do: [ :anError | errorMessage := anError messageText.
					 self triggerEvent: #checkoutUnsuccesfull with: self ]! !


!CartWindowModel methodsFor: 'shopping' stamp: 'GDH 7/8/2021 01:24:31'!
returnToShopping

	self triggerEvent: #returnToShopping with: self.! !


!CartWindowModel methodsFor: 'checkout unsuccess - accesing' stamp: 'GDH 7/8/2021 01:37:38'!
errorMessage
	
	^errorMessage ! !


!CartWindowModel methodsFor: 'checkout success - accessing' stamp: 'GDH 7/8/2021 01:36:57'!
ticket
	
	^ticket! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartWindowModel class' category: 'TusLibros-Gui'!
CartWindowModel class
	instanceVariableNames: ''!

!CartWindowModel class methodsFor: 'as yet unclassified' stamp: 'MS 7/8/2021 12:44:19'!
for: aCartId ownedBy: aClientId

	^self new initializeFor: aCartId ownedBy: aClientId.
! !


!classDefinition: #ErrorMessageWindowModel category: 'TusLibros-Gui'!
Object subclass: #ErrorMessageWindowModel
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Gui'!

!ErrorMessageWindowModel methodsFor: 'action' stamp: 'GDH 7/8/2021 01:42:23'!
actionButtonCallback

	self triggerEvent: #executeCallback with: self.! !


!classDefinition: #LoginWindowModel category: 'TusLibros-Gui'!
Object subclass: #LoginWindowModel
	instanceVariableNames: 'clientId password tusLibrosClient session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Gui'!

!LoginWindowModel methodsFor: 'passwordSelectors' stamp: 'ms 7/6/2021 17:17:24'!
passwordText

	^password.! !

!LoginWindowModel methodsFor: 'passwordSelectors' stamp: 'ms 7/6/2021 17:17:44'!
passwordText: aPassword

	password := aPassword.
	^true.! !


!LoginWindowModel methodsFor: 'initialization' stamp: 'ms 7/6/2021 18:04:18'!
initialize

	clientId := ''.
	password := ''.
	tusLibrosClient := TusLibrosClient new.! !


!LoginWindowModel methodsFor: 'clientIdSelectors' stamp: 'ms 7/6/2021 17:17:08'!
clientIdText 

	^clientId.! !

!LoginWindowModel methodsFor: 'clientIdSelectors' stamp: 'ms 7/6/2021 17:16:59'!
clientIdText: aClientId

	clientId := aClientId.
	^true.! !


!LoginWindowModel methodsFor: 'accessing' stamp: 'GDH 7/8/2021 01:01:24'!
session

	^session! !


!LoginWindowModel methodsFor: 'createCartButtonSelectors' stamp: 'GDH 7/8/2021 01:33:58'!
createCartRequest
	
	[	| cartId | 
		cartId := tusLibrosClient postCreateCartRequestAuthenticating: clientId with: password.
		session := Session for: clientId authenticatedWith: password withCartIdentifiedAs: cartId. 
		self triggerEvent: #cartCreated with: self.]
		on: Error do: [ ^self triggerEvent: #cartNotCreated with: self ].
	
	
	
	
	! !


!classDefinition: #PurchasesWindowModel category: 'TusLibros-Gui'!
Object subclass: #PurchasesWindowModel
	instanceVariableNames: 'tusLibrosClient purchasesList purchasesListIndex clientId password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Gui'!

!PurchasesWindowModel methodsFor: 'purchases' stamp: 'MS 7/8/2021 12:06:13'!
purchases
	
	[ 	| purchases formattedPurchases catalog |
		
		purchases := tusLibrosClient getPurchasesFor: clientId authenticatingWith: password.
		purchases isEmpty ifTrue: [ ^OrderedCollection with: 'No purchases were made :(' ].
	
		catalog := tusLibrosClient getCatalogRequest.
		
		formattedPurchases := OrderedCollection new.
		purchases keysAndValuesDo: [:aKey :aValue | 
			formattedPurchases add: (aKey , '---', (catalog at: aKey) asString , '---', aValue asString)].
		^formattedPurchases.
		
	]
		on: Error
		do: [ :error | ^OrderedCollection with: error messageText ]
		
	! !

!PurchasesWindowModel methodsFor: 'purchases' stamp: 'GDH 7/8/2021 00:31:15'!
purchasesListIndex
	
	^purchasesListIndex ! !

!PurchasesWindowModel methodsFor: 'purchases' stamp: 'GDH 7/8/2021 00:31:30'!
purchasesListIndex: anIndex
	
	purchasesListIndex :=  anIndex.! !


!PurchasesWindowModel methodsFor: 'initialization' stamp: 'GDH 7/8/2021 00:33:27'!
initializeFor: aClientId authenticating: aPassword
	
	tusLibrosClient := TusLibrosClient new.
	clientId := aClientId.
	password := aPassword.
	
	purchasesListIndex := 0.! !


!PurchasesWindowModel methodsFor: 'shopping' stamp: 'GDH 7/8/2021 00:53:13'!
showShoppingWindow
	
	self triggerEvent: #showShoppingWindow with: self.

	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PurchasesWindowModel class' category: 'TusLibros-Gui'!
PurchasesWindowModel class
	instanceVariableNames: ''!

!PurchasesWindowModel class methodsFor: 'instance creation' stamp: 'GDH 7/8/2021 00:13:05'!
for: aClientId authenticating: aPassword
	
	^self new initializeFor: aClientId authenticating: aPassword.! !


!classDefinition: #Session category: 'TusLibros-Gui'!
Object subclass: #Session
	instanceVariableNames: 'clientId password cartId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Gui'!

!Session methodsFor: 'accessing' stamp: 'GDH 7/8/2021 00:59:03'!
cartId
	
	^cartId! !

!Session methodsFor: 'accessing' stamp: 'GDH 7/8/2021 00:58:49'!
clientId
	
	^clientId! !

!Session methodsFor: 'accessing' stamp: 'GDH 7/8/2021 00:58:55'!
password
	
	^password! !


!Session methodsFor: 'initialization' stamp: 'GDH 7/8/2021 01:15:21'!
initializeFor: aClientId authenticatedWith: aPassword withCartIdentifiedAs: aCartId
	
	clientId := aClientId.
	password := aPassword.
	cartId := aCartId .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Session class' category: 'TusLibros-Gui'!
Session class
	instanceVariableNames: ''!

!Session class methodsFor: 'instance creation' stamp: 'GDH 7/8/2021 00:57:59'!
for: aClientId authenticatedWith: aPassword withCartIdentifiedAs: aCartId
	
	^self new initializeFor: aClientId authenticatedWith: aPassword withCartIdentifiedAs: aCartId.! !


!classDefinition: #ShoppingWindowModel category: 'TusLibros-Gui'!
Object subclass: #ShoppingWindowModel
	instanceVariableNames: 'tusLibrosClient cartId catalogItem catalogListIndex catalog quantityListIndex quantities cartList catalogWithTitles isbns'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Gui'!

!ShoppingWindowModel methodsFor: 'catalog' stamp: 'GDH 7/7/2021 19:14:13'!
catalog
	
	^catalogWithTitles
	
	
	! !

!ShoppingWindowModel methodsFor: 'catalog' stamp: 'GDH 7/7/2021 02:30:55'!
catalogListIndex
	
	^catalogListIndex
	
	! !

!ShoppingWindowModel methodsFor: 'catalog' stamp: 'GDH 7/7/2021 02:31:19'!
catalogListIndex: anIndex
	
	catalogListIndex := anIndex.
	
	! !


!ShoppingWindowModel methodsFor: 'initialization' stamp: 'GDH 7/7/2021 18:54:34'!
formatIsbn: anIsbn withTitle: aTitle
	
	^'Codigo: ', anIsbn , ' , titulado: ', aTitle
	
	! !

!ShoppingWindowModel methodsFor: 'initialization' stamp: 'GDH 7/8/2021 15:37:36'!
initializeFor: aCartId

	tusLibrosClient := TusLibrosClient new.
	
	catalog := tusLibrosClient getCatalogRequest.
	isbns := catalog keys asOrderedCollection .
	catalogWithTitles := self isbnsWithTitles.
	quantities := self quantities.
	
	cartId := aCartId.
	
	quantityListIndex := 1.
	catalogListIndex := 1.! !

!ShoppingWindowModel methodsFor: 'initialization' stamp: 'GDH 7/7/2021 19:13:55'!
isbnsWithTitles
	
	| isbnsAndTitles |
	
	isbnsAndTitles := OrderedCollection new.
	
	catalog keysAndValuesDo: [ :aKey :aValue | isbnsAndTitles add: (self formatIsbn: aKey withTitle: aValue) ].
	
	^isbnsAndTitles.! !

!ShoppingWindowModel methodsFor: 'initialization' stamp: 'GDH 7/8/2021 15:36:12'!
quantities
	
	^OrderedCollection with: 1 with: 2 with: 3 with: 4 with: 5.! !


!ShoppingWindowModel methodsFor: 'adding' stamp: 'GDH 7/7/2021 19:18:36'!
addToCart
	
	tusLibrosClient postAddToCart: cartId of: (isbns at: catalogListIndex) amount: (quantities at: quantityListIndex).
	
	self triggerEvent: #addedSuccesfullyToCart with: self. "Mostrar que se agregó"! !


!ShoppingWindowModel methodsFor: 'quantity' stamp: 'GDH 7/7/2021 02:45:02'!
itemQuantities
	
	^quantities.! !

!ShoppingWindowModel methodsFor: 'quantity' stamp: 'GDH 7/7/2021 02:39:24'!
itemQuantitiesListIndex
	
	^quantityListIndex 
	
	! !

!ShoppingWindowModel methodsFor: 'quantity' stamp: 'GDH 7/7/2021 02:39:31'!
itemQuantitiesListIndex: anIndex
	
	quantityListIndex := anIndex.
	
	! !


!ShoppingWindowModel methodsFor: 'purchases' stamp: 'GDH 7/8/2021 00:03:15'!
openUserPurchases
	
	self triggerEvent: #openUserPurchases with: self.! !


!ShoppingWindowModel methodsFor: 'list cart' stamp: 'GDH 7/7/2021 03:05:58'!
showCartList
	
	self triggerEvent: #showListCart with: self.
	
	
	! !


!ShoppingWindowModel methodsFor: 'removing' stamp: 'GDH 7/8/2021 15:31:19'!
removeFromCart

	[ tusLibrosClient postRemoveFromCart: cartId of: (isbns at: catalogListIndex) amount: (quantities at: quantityListIndex) ]
		on: Error 
		do: [ self triggerEvent: #removeUnsuccesful with: self.].
	
	self triggerEvent: #removeSuccesful with: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingWindowModel class' category: 'TusLibros-Gui'!
ShoppingWindowModel class
	instanceVariableNames: ''!

!ShoppingWindowModel class methodsFor: 'instance creation' stamp: 'GDH 7/7/2021 01:03:21'!
for: aCartId
	
	^self new initializeFor: aCartId .! !


!classDefinition: #TicketWindowModel category: 'TusLibros-Gui'!
Object subclass: #TicketWindowModel
	instanceVariableNames: 'tusLibrosClient ticketIndex ticket session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Gui'!

!TicketWindowModel methodsFor: 'initialization' stamp: 'GDH 7/8/2021 02:53:44'!
initializeWith: aSession issued: aTicket
	
	tusLibrosClient := TusLibrosClient new.
	
	ticket := aTicket.
	session := aSession.
	
	ticketIndex := 1.
! !


!TicketWindowModel methodsFor: 'ticket' stamp: 'GDH 7/8/2021 02:38:38'!
ticket

	^ticket collect: [ :aTicketLine | | isbnKey |  
		isbnKey := aTicketLine keys at: 1.
		isbnKey, ' ------------ ', (aTicketLine at: isbnKey) asString].! !

!TicketWindowModel methodsFor: 'ticket' stamp: 'MS 7/7/2021 21:34:03'!
ticketIndex

	^ticketIndex.! !

!TicketWindowModel methodsFor: 'ticket' stamp: 'MS 7/7/2021 21:34:10'!
ticketIndex: anIndex

	ticketIndex := anIndex.! !


!TicketWindowModel methodsFor: 'logout' stamp: 'GDH 7/8/2021 00:50:33'!
logout

	self triggerEvent: #logout with: self.! !


!TicketWindowModel methodsFor: 'continue' stamp: 'GDH 7/8/2021 02:53:07'!
continueShopping
	
	| cartId |
	
	cartId := tusLibrosClient postCreateCartRequestAuthenticating: session clientId with: session password.
	session := Session for: session clientId authenticatedWith: session password withCartIdentifiedAs: cartId.
	
	self triggerEvent: #continueShopping with: self.! !


!TicketWindowModel methodsFor: 'continue - accessing' stamp: 'GDH 7/8/2021 02:45:31'!
session
	
	^session! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicketWindowModel class' category: 'TusLibros-Gui'!
TicketWindowModel class
	instanceVariableNames: ''!

!TicketWindowModel class methodsFor: 'instance creation' stamp: 'GDH 7/8/2021 02:48:20'!
with: aSession issued: aTicket

	^self new initializeWith: aSession issued: aTicket.! !

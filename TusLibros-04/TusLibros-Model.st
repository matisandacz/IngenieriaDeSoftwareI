!classDefinition: #TusLibrosEncoder category: 'TusLibros-Model'!
WebUtils subclass: #TusLibrosEncoder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosEncoder class' category: 'TusLibros-Model'!
TusLibrosEncoder class
	instanceVariableNames: ''!

!TusLibrosEncoder class methodsFor: 'line item encode' stamp: 'GDH 7/7/2021 20:28:15'!
if: anObject IsLineItemDo: aBlock 
	
	(anObject isKindOf: LineItem) ifTrue: aBlock! !

!TusLibrosEncoder class methodsFor: 'line item encode' stamp: 'GDH 7/7/2021 20:37:28'!
if: anObject IsTicketDo: aBlock 
	
	(anObject isKindOf: Ticket) ifTrue: aBlock! !

!TusLibrosEncoder class methodsFor: 'line item encode' stamp: 'GDH 7/7/2021 20:30:33'!
lineItemAsDictionary: aLineItem
	
	| asDictionary |
	
	asDictionary  := Dictionary new.
	asDictionary at: aLineItem item put: aLineItem total.
	^ asDictionary.! !


!TusLibrosEncoder class methodsFor: 'json-encode' stamp: 'GDH 7/7/2021 23:31:08'!
jsonObj: anObject on: aStream
	
	self if: anObject IsLineItemDo: [ ^self jsonObj: (self lineItemAsDictionary: anObject) on: aStream ]. 
	self if: anObject IsTicketDo: [ ^self jsonObj: (self ticketAsArray: anObject) on: aStream ].
	self if: anObject IsBagDo: [ ^self jsonObj: (self bagAsArray: anObject) on: aStream ].
	
	^super jsonObj: anObject on: aStream! !


!TusLibrosEncoder class methodsFor: 'ticket encode' stamp: 'GDH 7/7/2021 23:01:22'!
if: anObject IsBagDo: aBlock 
	
	(anObject isKindOf: Bag) ifTrue: aBlock! !

!TusLibrosEncoder class methodsFor: 'ticket encode' stamp: 'GDH 7/8/2021 02:37:09'!
ticketAsArray: aTicket
	
	| ticketAsCollection |
	
	ticketAsCollection := OrderedCollection new.
	
	aTicket lineItemsDo: [ :aLineItem | ticketAsCollection add: aLineItem ].
	ticketAsCollection add: (Dictionary newFromPairs: { 'total'. aTicket total }).
	
	^ticketAsCollection asArray ! !


!TusLibrosEncoder class methodsFor: 'bag encode' stamp: 'GDH 7/7/2021 23:31:08'!
bagAsArray: aBag
	
	^aBag asArray .! !


!classDefinition: #Cart category: 'TusLibros-Model'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^self class invalidQuantityErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'ms 7/7/2021 13:15:22'!
itemNotInCartErrorMessage

	^self class itemNotInCartErrorMessage.! !


!Cart methodsFor: 'assertions' stamp: 'GDH 7/7/2021 17:52:45'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self signalInvalidItem ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:18'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [self signalInvalidQuantity ]! !

!Cart methodsFor: 'assertions' stamp: 'ms 7/7/2021 14:36:32'!
assertIsValidQuantity: aQuantity of: anItem

	^ ((self occurrencesOf: anItem) < aQuantity) ifTrue: [ self signalInvalidQuantity ]! !

!Cart methodsFor: 'assertions' stamp: 'ms 7/7/2021 14:35:30'!
assertItemInCart: anItem

	^ (self includes: anItem) ifFalse: [ self signalItemNotInCart ]! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:17'!
catalog

	^ catalog! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:30'!
content

	^items copy! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/23/2013 12:10'!
itemsAndQuantitiesDo: aBlock

	^ items contents keysAndValuesDo: [ :anItem :aQuantity | aBlock value: anItem value: aQuantity ]! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:29'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:18'!
signalInvalidItem

	self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:19'!
signalInvalidQuantity

	self error: self invalidQuantityErrorMessage ! !

!Cart methodsFor: 'error signal' stamp: 'ms 7/7/2021 13:14:50'!
signalItemNotInCart

	self error: self itemNotInCartErrorMessage.! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty

	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/22/2013 12:31'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !


!Cart methodsFor: 'removing' stamp: 'GDH 7/7/2021 17:36:48'!
remove: anItem
	
	items remove: anItem ifAbsent: [self signalInvalidItem ].! !

!Cart methodsFor: 'removing' stamp: 'ms 7/7/2021 14:36:49'!
remove: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity. 
	self assertIsValidItem: anItem. 
	self assertItemInCart: anItem. 
	self assertIsValidQuantity: aQuantity of: anItem. 
	
	aQuantity timesRepeat: [ self remove: anItem ].
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Model'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^'Invalid number of items'! !

!Cart class methodsFor: 'error messages' stamp: 'ms 7/7/2021 13:15:37'!
itemNotInCartErrorMessage

	^'Item not in cart'.! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: 'TusLibros-Model'!
Object subclass: #CartSession
	instanceVariableNames: 'owner cart lastUsedTime systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:34'!
assertIsNotExpirtedAt: aTime

	(self isExpiredAt: aTime) ifTrue: [ self signalCartSessionExpired ]! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
isExpiredAt: aTime

	^ (lastUsedTime + systemFacade sessionDuration) < aTime! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
now

	^systemFacade now! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:37'!
today

	^systemFacade today! !


!CartSession methodsFor: 'session management' stamp: 'HernanWilkinson 6/17/2015 20:35'!
do: aBlock

	| now |

	now := self now.
	self assertIsNotExpirtedAt: now.

	^ [ aBlock value: self ] ensure: [ lastUsedTime := now  ]! !


!CartSession methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2015 20:36'!
initializeOwnedBy: aCustomer with: aCart on: aSystemFacade

	owner := aCustomer.
	cart := aCart.
	systemFacade := aSystemFacade.
	lastUsedTime := self now.! !


!CartSession methodsFor: 'error signal' stamp: 'HernanWilkinson 6/17/2015 20:37'!
signalCartSessionExpired

	self error: systemFacade sessionHasExpiredErrorDescription ! !


!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:34'!
addToCart: anAmount of: aBook

	^cart add: anAmount of: aBook! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
cartContent

	^cart content! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
checkOutCartWithCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	^(Cashier
		toCheckout: cart
		ownedBy: owner
		charging: (CreditCard expiringOn: anExpirationMonthOfYear)
		throught: systemFacade merchantProcessor
		on: self today
		registeringOn: systemFacade salesBook) checkOut ! !

!CartSession methodsFor: 'cart' stamp: 'ms 7/7/2021 14:53:36'!
removeFromCart: anAmount of: aBook

	^cart remove: anAmount of: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: 'TusLibros-Model'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2015 20:37'!
ownedBy: aCustomer with: aCart on: aSystemFacade

	^self new initializeOwnedBy: aCustomer with: aCart on: aSystemFacade! !


!classDefinition: #Cashier category: 'TusLibros-Model'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard owner ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
createLineItemOf: anItem quantity: aQuantity

	^LineItem of: anItem quantity: aQuantity total: (self totalOf: anItem quantity: aQuantity) ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:25'!
createSale

	^ Sale doneBy: owner certifiedWith: ticket
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:28'!
createTicket

	| lineItems |

	lineItems := OrderedCollection new.
	cart itemsAndQuantitiesDo: [ :anItem :aQuantity |
		lineItems add: (self createLineItemOf: anItem quantity: aQuantity)].

	ticket := Ticket of: lineItems
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:20'!
debitTotal

	merchantProcessor debit: ticket total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'GDH 7/7/2021 17:53:45'!
totalOf: anItem quantity: aQuantity

	^(cart catalog priceOf: anItem) * aQuantity  ! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/22/2013 12:28'!
checkOut

	self createTicket.
	self debitTotal.
	self registerSale.

	^ ticket ! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:02'!
initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook

	cart := aCart.
	owner := anOwner.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros-Model'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotEmpty: aCart

	aCart isEmpty ifTrue: [self signalCartCanNotBeEmpty ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotExpired: aCreditCard on: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [self signalCanNotChargeAnExpiredCreditCard]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:00'!
toCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook

	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.

	^self new initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage

	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage

	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage

	^'Credit card has no credit'! !


!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCanNotChargeAnExpiredCreditCard

	 self error: self canNotChargeAnExpiredCreditCardErrorMessage ! !

!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCartCanNotBeEmpty

	self error: self cartCanNotBeEmptyErrorMessage! !


!classDefinition: #Clock category: 'TusLibros-Model'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
now

	self subclassResponsibility ! !

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
today

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Clock class' category: 'TusLibros-Model'!
Clock class
	instanceVariableNames: ''!

!Clock class methodsFor: 'as yet unclassified' stamp: 'MS 6/27/2021 21:12:37'!
now: aTime

	^self new initializeNow: aTime ! !


!classDefinition: #CreditCard category: 'TusLibros-Model'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate

	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth

	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-Model'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth

	^self new initializeExpiringOn: aMonth! !


!classDefinition: #LineItem category: 'TusLibros-Model'!
Object subclass: #LineItem
	instanceVariableNames: 'item quantity total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:33'!
item

	^ item! !

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:21'!
total

	^ total! !


!LineItem methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:18'!
initializeOf: anItem quantity: aQuantity total: aTotal

	item := anItem.
	quantity := aQuantity.
	total := aTotal

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LineItem class' category: 'TusLibros-Model'!
LineItem class
	instanceVariableNames: ''!

!LineItem class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:18'!
of: anItem quantity: aQuantity total: aTotal

	^self new initializeOf: anItem quantity: aQuantity total: aTotal

! !


!classDefinition: #MerchantProcessor category: 'TusLibros-Model'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:31'!
README

	"Aunque nadie subclasifica esta clase, esta para definir el protocolo que se espera que todo MerchantProcessor sepa responder - Hernan"! !

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:30'!
debit: anAmount from: aCreditCard

	self subclassResponsibility ! !


!classDefinition: #Sale category: 'TusLibros-Model'!
Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Sale methodsFor: 'testing' stamp: 'HernanWilkinson 6/22/2013 12:06'!
wasDoneBy: aCustomer

	^customer = aCustomer ! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:26'!
initializeDoneBy: aCustomer certifiedWith: aTicket

	customer := aCustomer.
	ticket := aTicket ! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/22/2013 12:26'!
total

	^ ticket total! !


!Sale methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^ticket lineItemsDo: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros-Model'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:25'!
doneBy: aCustomer certifiedWith: aTicket

	^self new initializeDoneBy: aCustomer certifiedWith: aTicket ! !


!classDefinition: #Ticket category: 'TusLibros-Model'!
Object subclass: #Ticket
	instanceVariableNames: 'lineItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Ticket methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2015 20:39'!
total

	^lineItems sum: [ :aLineItem | aLineItem total]! !


!Ticket methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:20'!
initializeOf: aCollectionOfLineItems

	lineItems := aCollectionOfLineItems ! !


!Ticket methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^lineItems do: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: 'TusLibros-Model'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:20'!
of: aCollectionOfLineItems

	^self new initializeOf: aCollectionOfLineItems ! !


!classDefinition: #TusLibrosCatalog category: 'TusLibros-Model'!
Object subclass: #TusLibrosCatalog
	instanceVariableNames: 'titleByIsbn priceByIsbn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosCatalog methodsFor: 'initialization' stamp: 'GDH 7/7/2021 18:43:03'!
initialize
	
	titleByIsbn := Dictionary new.
	priceByIsbn := Dictionary new.! !


!TusLibrosCatalog methodsFor: 'testing' stamp: 'GDH 7/7/2021 18:42:15'!
includes: anIsbn
	
	^titleByIsbn includesKey: anIsbn.! !


!TusLibrosCatalog methodsFor: 'accessing' stamp: 'GDH 7/7/2021 18:42:49'!
isbns 

	^titleByIsbn keys.! !

!TusLibrosCatalog methodsFor: 'accessing' stamp: 'GDH 7/7/2021 19:53:16'!
priceOf: anIsbn
	
	^priceByIsbn at: anIsbn.! !

!TusLibrosCatalog methodsFor: 'accessing' stamp: 'GDH 7/7/2021 18:44:20'!
prices
	
	^priceByIsbn! !

!TusLibrosCatalog methodsFor: 'accessing' stamp: 'GDH 7/7/2021 19:53:21'!
titleOf: anIsbn 

	^titleByIsbn at: anIsbn.! !

!TusLibrosCatalog methodsFor: 'accessing' stamp: 'GDH 7/7/2021 18:44:26'!
titles
	
	^titleByIsbn ! !


!TusLibrosCatalog methodsFor: 'adding' stamp: 'GDH 7/7/2021 18:41:51'!
add: anIsbn titled: aTitle pricing: aPriceNumber
	
	titleByIsbn at: anIsbn put: aTitle.
	priceByIsbn at: anIsbn put: aPriceNumber! !


!classDefinition: #TusLibrosRestInterface category: 'TusLibros-Model'!
Object subclass: #TusLibrosRestInterface
	instanceVariableNames: 'port webServer testObjectsFactory clock systemFacade systemFacadeTestObjectFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosRestInterface methodsFor: 'initialization' stamp: 'MS 7/8/2021 12:36:32'!
initializeWith: aPortNumber
	
	port:= aPortNumber.
	
	webServer := WebServer new listenOn: self port.
	
	testObjectsFactory := StoreTestObjectsFactory new.
	
	systemFacadeTestObjectFactory := TusLibrosSystemFacadeTest new.
	
	systemFacade := TusLibrosSystemFacade
		authenticatingWith: systemFacadeTestObjectFactory validUsersAndPasswords
		acceptingItemsOf: testObjectsFactory defaultCatalog
		registeringOn: systemFacadeTestObjectFactory createSalesBook
		debitingThrought: systemFacadeTestObjectFactory merchantProcessor
		measuringTimeWith: DateAndTime
		usingCreditCards: systemFacadeTestObjectFactory userCreditCards.
	
	self addAddToCartService.
	self addCatalogTitlesService.
	self addCheckOutCartService.
	self addCreateCartService.
	self addListCartService.
	self addListPurchasesService.
	self addRemoveFromCartService.

	! !

!TusLibrosRestInterface methodsFor: 'initialization' stamp: 'MS 6/27/2021 18:51:10'!
port
	"Use a random port to minimise chances of concurrently running test suites clashing."
	"^ port
		ifNil: [port := (10000 to: 50000) atRandom]"
	
	^port ifNil: [port:=8080].
	
! !


!TusLibrosRestInterface methodsFor: 'enabling services' stamp: 'MS 6/27/2021 18:52:02'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosRestInterface methodsFor: 'enabling services' stamp: 'MS 6/27/2021 19:34:39'!
restart

	self stopListening.
	self destroy.
	self initializeWith: self port.
	self startListening.
	! !

!TusLibrosRestInterface methodsFor: 'enabling services' stamp: 'MS 6/27/2021 18:52:16'!
startListening
	
	webServer startListener.

	^'Listening on port: ', self port asString.
	! !

!TusLibrosRestInterface methodsFor: 'enabling services' stamp: 'MS 6/27/2021 18:52:30'!
stopListening
	
	webServer stopListener.
	
	^'Stopped listening from port: ', self port asString! !


!TusLibrosRestInterface methodsFor: 'services' stamp: 'GDH 7/7/2021 22:42:44'!
addAddToCartService
	
	self addService: '/addToCart' withAction: [ :request | | cartId bookIsbn bookQuantity | 
			cartId := (request fields at:'cartId') asNumber.
			bookIsbn := (request fields at: 'bookIsbn').
			bookQuantity := (request fields at: 'bookQuantity') asNumber.
			systemFacade add: bookQuantity of: bookIsbn toCartIdentifiedAs: cartId.
			request send200Response: ''.
		].
	
	
	
	! !

!TusLibrosRestInterface methodsFor: 'services' stamp: 'GDH 7/7/2021 22:42:54'!
addCatalogTitlesService
	
	self addService: '/catalog' withAction: [ :request | | booksInCatalog |
			booksInCatalog := systemFacade catalog titles .
			request send200Response: (TusLibrosEncoder jsonEncode: booksInCatalog).
		].
	


	! !

!TusLibrosRestInterface methodsFor: 'services' stamp: 'MS 7/8/2021 12:34:23'!
addCheckOutCartService
	
	self addService: '/checkOutCart' withAction: [ :request | | cartId clientId ticket | 
			cartId := (request fields at:'cartId') asNumber.
			clientId := (request fields at:'clientId').
			ticket := systemFacade
				checkOutCartIdentifiedAs: cartId
				ownedBy: clientId.
			request send200Response: (TusLibrosEncoder jsonEncode: ticket).
		].
	


	! !

!TusLibrosRestInterface methodsFor: 'services' stamp: 'GDH 7/7/2021 22:43:02'!
addCreateCartService
		
	self addService: '/createCart' withAction:
		[ : request | 	| clientId password cartId | 
			clientId := (request fields at:'clientId').
			password := (request fields at: 'password').
			cartId := systemFacade createCartFor: clientId authenticatedWith: password.
			request send200Response: (TusLibrosEncoder jsonEncode: cartId).
		].


	! !

!TusLibrosRestInterface methodsFor: 'services' stamp: 'GDH 7/7/2021 22:46:07'!
addListCartService
	
	self addService: '/listCart' withAction: [ :request | | cartId cartContent | 
		 	cartId := (request fields at:'cartId') asNumber.
			cartContent := systemFacade listCartIdentifiedAs: cartId.
			request send200Response: (TusLibrosEncoder jsonEncode: cartContent )
		].
	
	
	! !

!TusLibrosRestInterface methodsFor: 'services' stamp: 'GDH 7/7/2021 22:50:44'!
addListPurchasesService

	self addService:  '/listPurchases' withAction: [ :request | | clientId password purchases | 
			clientId := (request fields at:'clientId').
			password := (request fields at:'password').
			purchases := systemFacade listPurchasesOf: clientId authenticatingWith: password.
			request send200Response: (TusLibrosEncoder jsonEncode: purchases).
		].
	

	! !

!TusLibrosRestInterface methodsFor: 'services' stamp: 'GDH 7/7/2021 22:43:28'!
addRemoveFromCartService
	
	self addService: '/removeFromCart' withAction: [ :request | | cartId bookIsbn bookQuantity | 
			cartId := (request fields at:'cartId') asNumber.
			bookIsbn := (request fields at: 'bookIsbn').
			bookQuantity := (request fields at: 'bookQuantity') asNumber.
			systemFacade remove: bookQuantity of: bookIsbn toCartIdentifiedAs: cartId.
			request send200Response: ''.
		].
	
	
	
	! !

!TusLibrosRestInterface methodsFor: 'services' stamp: 'MS 6/27/2021 21:20:40'!
addService: aServiceName withAction: aBlock
		
	webServer addService: aServiceName action: [ :request |
		[aBlock value: request]
		on: Error 
		do: [ :anError |
			request send400Response: anError messageText ]].
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestInterface class' category: 'TusLibros-Model'!
TusLibrosRestInterface class
	instanceVariableNames: ''!

!TusLibrosRestInterface class methodsFor: 'as yet unclassified' stamp: 'MS 6/27/2021 18:49:34'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !


!classDefinition: #TusLibrosSystemFacade category: 'TusLibros-Model'!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'validUsersAndPasswords catalog lastId merchantProcessor salesBook clock cartSessions validCreditCards userCreditCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:24'!
canNotChargeAnExpiredCreditCardErrorMessage

	^Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage

	^Cashier cartCanNotBeEmptyErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:27'!
invalidCartIdErrorDescription

	^'Invalid cart id'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^Cart invalidItemErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:03'!
invalidUserAndOrPasswordErrorDescription

	^'Invalid user and/or password'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'ms 7/7/2021 15:00:37'!
itemNotInCartErrorMessage

	^Cart itemNotInCartErrorMessage! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 13:07'!
sessionHasExpiredErrorDescription

	^'Can not use the cart after ', self sessionDuration minutes printString , ' minutes of inactivity'! !


!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:02'!
now

	^clock now! !

!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:49'!
today

	^clock today! !


!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
does: aUser authenticatesWith: aPassword

	"Recordar que esto es solo un ejemplo. No se deben guardar passwords en un sistema de verdad sino un
	hash o similar - Hernan"

	| storedPassword |

	storedPassword := validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	^aPassword = storedPassword ! !

!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
if: aUser authenticatesWith: aPassword do: aBlock

	^ (self does: aUser authenticatesWith: aPassword)
		ifTrue: aBlock
		ifFalse: [ self signalInvalidUserAndOrPassword ].
	! !


!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:27'!
signalInvalidCartId

	self error: self invalidCartIdErrorDescription ! !

!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:02'!
signalInvalidUserAndOrPassword

	self error: self invalidUserAndOrPasswordErrorDescription! !


!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId

	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"

	lastId := lastId + 1.
	^lastId! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/22/2013 13:02'!
sessionDuration

	^30 minutes! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/17/2015 20:50'!
withCartSessionIdentifiedAs: aCartId do: aBlock

	| cartSession |

	cartSession := cartSessions at: aCartId ifAbsent: [self signalInvalidCartId ].
	^cartSession do: aBlock
! !


!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:18:41'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession addToCart: anAmount of: aBook ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'GDH 7/7/2021 18:04:56'!
catalog

	^catalog 
	
	! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'MS 7/8/2021 14:06:24'!
checkOutCartIdentifiedAs: aCartId ownedBy: aClientId

	| creditCardNumber creditCardOwner expirationMonthOfYear |
		
	creditCardNumber := (userCreditCards at: aClientId) at: 1.
	creditCardOwner := (userCreditCards at: aClientId) at: 2.
	expirationMonthOfYear := (userCreditCards at: aClientId) at: 3.
	
	^self 
		checkOutCartIdentifiedAs: aCartId 
		withCreditCardNumbered: creditCardNumber 
		ownedBy: creditCardOwner 
		expiringOn: expirationMonthOfYear.
! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'GDH 7/7/2021 19:49:48'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	self
		withCartSessionIdentifiedAs: aCartId
		do: [ :cartSession | ^cartSession
			checkOutCartWithCreditCardNumbered: aCreditCartNumber
			ownedBy: anOwner
			expiringOn: anExpirationMonthOfYear ]
! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'ms 7/7/2021 14:56:29'!
createCartFor: aUser authenticatedWith: aPassword

	^ self if: aUser authenticatesWith: aPassword do: [ | cartId cartSession |

		cartId := self generateCartId.
		cartSession := CartSession ownedBy: aUser with: (Cart acceptingItemsOf: catalog) on: self..
		cartSessions at: cartId put: cartSession.

		cartId  ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:48'!
listCartIdentifiedAs: aCartId

	^ self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession cartContent ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:33:49'!
listPurchasesOf: aUser authenticatingWith: aPassword

	^self if: aUser authenticatesWith: aPassword do: [ | sales |
		sales := self salesDoneBy: aUser.
		sales
			inject: Dictionary new
			into: [ :salesOrderedByBook :aSale |
				self list: aSale on: salesOrderedByBook.
				salesOrderedByBook ] ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'ms 7/7/2021 14:52:42'!
remove: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession removeFromCart: anAmount of: aBook ]
	
	! !


!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:49'!
merchantProcessor

	^ merchantProcessor! !

!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:50'!
salesBook

	^ salesBook! !


!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:56'!
list: aSale on: salesOrderedByBook

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	aSale lineItemsDo: [ :aLineItem | | oldTotal newTotal |
		oldTotal := salesOrderedByBook at: aLineItem item ifAbsentPut: [ 0 ].
		newTotal := oldTotal + aLineItem total.
		salesOrderedByBook at: aLineItem item put: newTotal ]! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:55'!
salesDoneBy: aUser

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	^ salesBook select: [ :aSale | aSale wasDoneBy: aUser ]! !


!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'MS 7/8/2021 12:28:38'!
initializeAuthenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock
	usingCreditCards: aUserStoredCreditCards

	validUsersAndPasswords := aValidUsersAndPasswords.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.

	cartSessions := Dictionary new.
	lastId := 0.
	
	userCreditCards := aUserStoredCreditCards.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: 'TusLibros-Model'!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'MS 7/8/2021 12:29:33'!
authenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock
	usingCreditCards: aUserStoredCreditCards

	^self new
		initializeAuthenticatingWith: aValidUsersAndPasswords
		acceptingItemsOf: aCatalog
		registeringOn: aSalesBook
		debitingThrought: aMerchantProcessor
		measuringTimeWith: aClock
		usingCreditCards: aUserStoredCreditCards.! !

!classDefinition: #CartTest category: 'TusLibros-Tests'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |

	cart := testObjectsFactory createCart.

	self
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |

	cart := testObjectsFactory createCart.

	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |

	cart := testObjectsFactory createCart.

	self
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |

	cart := testObjectsFactory createCart.

	self
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |

	cart := testObjectsFactory createCart.

	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |

	cart := testObjectsFactory createCart.

	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |

	cart := testObjectsFactory createCart.

	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'ms 7/7/2021 12:44:58'!
test09CanNotRemoveItemsThatDoNotBelongToStore

	| cart |

	cart := testObjectsFactory createCart.

	self
		should: [ cart remove: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'ms 7/7/2021 13:21:00'!
test10CanNotRemoveItemsThatDoNotBelongToCart

	| cart itemToAdd |

	cart := testObjectsFactory createCart.
	
	itemToAdd := testObjectsFactory itemSellByTheStore.

	cart add: itemToAdd.
	
	self 
		should:  [ cart remove: testObjectsFactory anotherItemSellByTheStore ]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Cart invalidItemErrorMessage equals: anError messageText.
			self deny: cart isEmpty ]
! !

!CartTest methodsFor: 'tests' stamp: 'ms 7/7/2021 12:56:43'!
test11AfterRemovingAnItemTheCartIsEmpty

	| cart |

	cart := testObjectsFactory createCart.

	cart add: testObjectsFactory itemSellByTheStore.
	
	cart remove: testObjectsFactory itemSellByTheStore.
	
	self assert: cart isEmpty.
	
	
! !

!CartTest methodsFor: 'tests' stamp: 'ms 7/7/2021 13:32:27'!
test12CanNotRemoveNonPositiveNumberOfItems

	| cart item |

	cart := testObjectsFactory createCart.
	
	item := testObjectsFactory itemSellByTheStore.
	
	cart add: item.

	self
		should: [cart remove: 0 of: item ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart includes: item ]! !

!CartTest methodsFor: 'tests' stamp: 'ms 7/7/2021 13:32:38'!
test13CanNotRemoveMoreThanOneItemNotSellByTheStore

	| cart |

	cart := testObjectsFactory createCart.

	self
		should: [cart remove: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'ms 7/7/2021 13:33:24'!
test14CanNotRemoveMoreThanOneItemNotInCart

	| cart |

	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	
	self 
		should:  [ cart remove: 2 of: testObjectsFactory anotherItemSellByTheStore ]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Cart itemNotInCartErrorMessage equals: anError messageText.
			self deny: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'ms 7/7/2021 13:33:34'!
test15CanNotRemoveMoreItemsThanCartContains

	| cart item |

	cart := testObjectsFactory createCart.
	
	item := testObjectsFactory itemSellByTheStore.

	cart add: 2 of: item.
	
	self 
		should:  [ cart remove: 3 of: item. ]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Cart invalidQuantityErrorMessage equals: anError messageText.
			self assert: (cart occurrencesOf: item) equals: 2 ].! !

!CartTest methodsFor: 'tests' stamp: 'ms 7/7/2021 13:33:52'!
test16CartUpdatesTheNumberOfItemsAfterRemoving

	| cart item |

	cart := testObjectsFactory createCart.
	
	item := testObjectsFactory itemSellByTheStore.

	cart add: 5 of: item.
	
	cart remove: 4 of: item.
	
	self assert: 1 equals: (cart occurrencesOf: item).
	
	
! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros-Tests'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:00'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |

	salesBook := OrderedCollection new.
	self
		should: [ Cashier
			toCheckout: testObjectsFactory createCart
			ownedBy: testObjectsFactory customer
			charging: testObjectsFactory notExpiredCreditCard
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test02CalculatedTotalIsCorrect

	| cart cashier |

	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.

	cashier :=  Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: OrderedCollection new.

	self assert: cashier checkOut total = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:01'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.

	self
		should: [ Cashier
				toCheckout: cart
				ownedBy: testObjectsFactory customer
				charging: testObjectsFactory expiredCreditCard
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:23'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	total := cashier checkOut total.

	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:22'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	debitBehavior := [ :anAmount :aCreditCard |
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut total.

	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 12:02'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].

	cashier:= Cashier
		toCheckout: cart
		ownedBy: testObjectsFactory customer
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.

	self
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #CatalogTest category: 'TusLibros-Tests'!
TestCase subclass: #CatalogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!CatalogTest methodsFor: 'as yet unclassified' stamp: 'GDH 7/7/2021 17:28:44'!
test01CanAskPriceOfIsbnToCatalog

	| catalog |
	
	catalog := TusLibrosCatalog new.
	catalog add: 'isbn1' titled: 'Mi primer libro' pricing: 30.
	
	self assert: (catalog priceOf: 'isbn1') equals: 30! !


!CatalogTest methodsFor: 'tests' stamp: 'GDH 7/7/2021 17:44:30'!
test02IncludesShouldReturnIfIsbnExistsInCatalog

	| catalog |
	
	catalog := TusLibrosCatalog new.
	catalog add: 'isbn1' titled: 'Mi primer libro' pricing: 30.
	
	self assert: (catalog includes: 'isbn1').
	self deny: (catalog includes: 'isbn2').
! !

!CatalogTest methodsFor: 'tests' stamp: 'GDH 7/7/2021 17:52:07'!
test03CanAskForTitleOfIsbn

	| catalog |
	
	catalog := TusLibrosCatalog new.
	catalog add: 'isbn1' titled: 'Mi primer libro' pricing: 30.
	
	self assert: (catalog titleOf: 'isbn1') equals: 'Mi primer libro'.
	self deny: (catalog titleOf: 'isbn1') = 'Titulo falso'.
! !

!CatalogTest methodsFor: 'tests' stamp: 'GDH 7/7/2021 18:12:47'!
test04CanAskForKnownIsbn

	| catalog |
	
	catalog := TusLibrosCatalog new.
	catalog add: 'isbn1' titled: 'Mi primer libro' pricing: 30.
	
	self assert: catalog isbns equals: #('isbn1').
	self deny: catalog isbns = #('isbn2').
! !


!classDefinition: #TusLibrosEncoderTest category: 'TusLibros-Tests'!
TestCase subclass: #TusLibrosEncoderTest
	instanceVariableNames: 'encoder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!TusLibrosEncoderTest methodsFor: 'tests' stamp: 'GDH 7/7/2021 20:31:32'!
test01ShouldEncodeLineItemCorrectly
	
	| lineItem |
	
	lineItem := LineItem of: 'isbn1' quantity: 2 total: 30.
	
	self assert: (encoder jsonEncode: lineItem ) equals: '{"isbn1": 30}' ! !

!TusLibrosEncoderTest methodsFor: 'tests' stamp: 'MS 7/8/2021 11:20:42'!
test02ShouldEncodeTicketCorrectly
	
	| ticket lineItems isbn1LineItem isbn2LineItem |
	
	isbn1LineItem := LineItem of: 'isbn1' quantity: 2 total: 30.
	isbn2LineItem := LineItem of: 'isbn2' quantity: 1 total: 40.
		
	lineItems := OrderedCollection with: isbn1LineItem with: isbn2LineItem .
	
	ticket := Ticket of: lineItems .
	
	self assert: (encoder jsonEncode: ticket ) equals: '[{"isbn1": 30}, {"isbn2": 40}, {"total": 70}]' ! !

!TusLibrosEncoderTest methodsFor: 'tests' stamp: 'GDH 7/7/2021 23:07:28'!
test03ShouldEncodeBagCorrectly
	
	| bag |
	
	bag := Bag with: 'isbn1' with: 'isbn2'.
	
	self assert: (encoder jsonEncode: bag ) equals: '["isbn2", "isbn1"]' ! !


!TusLibrosEncoderTest methodsFor: 'setUp/tearDown' stamp: 'GDH 7/7/2021 20:27:30'!
setUp
	
	encoder := TusLibrosEncoder.! !


!classDefinition: #TusLibrosSystemFacadeTest category: 'TusLibros-Tests'!
TestCase subclass: #TusLibrosSystemFacadeTest
	instanceVariableNames: 'testObjectsFactory clock systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 6/19/2018 11:41:46'!
test04CanAddItemsToACreatedCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.

	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self assert: ((systemFacade listCartIdentifiedAs: cartId) occurrencesOf: self validBook) equals: 1
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 11/26/2018 18:03:02'!
test05CanNotAddItemToNotCreatedCart

	self
		should: [systemFacade add: 1 of: self validBook toCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 11/26/2018 18:03:17'!
test06CanNotAddItemNotSellByTheStore

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [systemFacade add: 1 of: self invalidBook toCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidItemErrorMessage.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - add to cart' stamp: 'HAW 11/26/2018 18:03:58'!
test17CanNotAddToCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self
		should: [systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription.
			self revertTime: systemFacade sessionDuration.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 11/26/2018 18:07:48'!
test14ListPurchasesIncludesBoughtItems

	| cartId purchases |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 1 of: self anotherValidBook toCartIdentifiedAs: cartId.
	systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: '1111222233334444'
		ownedBy: 'Juan Perez'
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	purchases := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.

	self assert: (purchases at: self validBook) equals: (testObjectsFactory itemSellByTheStorePrice * 2).
	self assert: (purchases at: self anotherValidBook) equals: testObjectsFactory anotherItemSellByTheStorePrice.! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 11/26/2018 18:10:29'!
test15CanNotListPurchasesOfInvalidCustomer

	self
		should: [systemFacade listPurchasesOf: self invalidUser authenticatingWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list purchases' stamp: 'HAW 11/26/2018 18:10:45'!
test16CanNotListPurchasesOfValidCustomerWithInvalidPassword

	self
		should: [systemFacade listPurchasesOf: self validUser authenticatingWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 6/19/2018 11:40:51'!
test01CanCreateCartWithValidUserAndPassword

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 11/26/2018 18:02:23'!
test02CanNotCreateCartWithInvalidUser

	self
		should: [ systemFacade createCartFor: self invalidUser authenticatedWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - create cart' stamp: 'HAW 11/26/2018 18:02:33'!
test03CanNotCreateCartWithInvalidPassword

	self
		should: [ systemFacade createCartFor: self validUser authenticatedWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidUserAndOrPasswordErrorDescription ]! !


!TusLibrosSystemFacadeTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/22/2013 11:48'!
debit: anAmount from: aCreditCard
! !


!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:42'!
createSalesBook

	^OrderedCollection new! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/22/2013 11:47'!
merchantProcessor

	^self! !

!TusLibrosSystemFacadeTest methodsFor: 'setup' stamp: 'MS 7/8/2021 14:01:43'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	clock := ManualClock now: testObjectsFactory today.
	systemFacade := TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords
		acceptingItemsOf: testObjectsFactory defaultCatalog
		registeringOn: self createSalesBook
		debitingThrought: self merchantProcessor
		measuringTimeWith: clock
		usingCreditCards: self userCreditCards.
! !


!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/22/2013 00:15'!
anotherValidBook

	^testObjectsFactory anotherItemSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'MS 7/8/2021 12:39:39'!
expiredCreditCardDetails
	
	"	{ clientId -> (ccn, cco, cced)  } "
	
	| creditCardNumber creditCardOwner creditCardExpirationDate testObjects |
	
	testObjects := StoreTestObjectsFactory new.
	
	creditCardNumber := testObjects notExpiredCreditCardNumber.
	creditCardOwner := testObjects notExpiredCreditCardOwner.
	creditCardExpirationDate := testObjects expiredMonthOfYear.
	
	^OrderedCollection with: creditCardNumber with: creditCardOwner with: creditCardExpirationDate.
	
! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'MS 7/8/2021 13:11:09'!
expiredUser

	^'expiredUser'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'MS 7/8/2021 13:11:20'!
expiredUserPassword

	^'expiredUserPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:49'!
invalidBook

	^testObjectsFactory itemNotSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:25'!
invalidCartId

	"Devuelvo nil porque seguro que siempre sera un id invalido, no importa que sea el id - Hernan"
	^nil! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:06'!
invalidPassword

	^'invalidPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:30'!
invalidUser

	^'invalidUser'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'MS 7/8/2021 12:39:51'!
notExpiredCreditCardDetails
	
	"	{ clientId -> (ccn, cco, cced)  } "
	
	| creditCardNumber creditCardOwner creditCardExpirationDate testObjects |
	
	testObjects := StoreTestObjectsFactory new.
	
	creditCardNumber := testObjects notExpiredCreditCardNumber.
	creditCardOwner := testObjects notExpiredCreditCardOwner.
	creditCardExpirationDate := testObjects notExpiredMonthOfYear.
	
	^OrderedCollection with: creditCardNumber with: creditCardOwner with: creditCardExpirationDate.
	
! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'MS 7/8/2021 13:28:00'!
userCreditCards

	^Dictionary new
		at: self validUser put: self notExpiredCreditCardDetails;
		at: self expiredUser put: self expiredCreditCardDetails;
		yourself
		
	"	{ clientId -> (ccn, cco, cced)  } "! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 23:50'!
validBook

	^testObjectsFactory itemSellByTheStore ! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:27'!
validUser

	^'validUser'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'HernanWilkinson 6/21/2013 22:28'!
validUserPassword

	^'validUserPassword'! !

!TusLibrosSystemFacadeTest methodsFor: 'test objects' stamp: 'MS 7/8/2021 13:10:54'!
validUsersAndPasswords

	^Dictionary new
		at: self validUser put: self validUserPassword;
		at: self expiredUser put: self expiredUserPassword;
		yourself! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'MS 7/8/2021 14:02:38'!
test10CanCheckoutACart

	| cartId purchases |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
		ownedBy: testObjectsFactory notExpiredCreditCardOwner
		expiringOn: testObjectsFactory notExpiredMonthOfYear.

	purchases := systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword.

	self assert: (purchases at: self validBook) equals: testObjectsFactory itemSellByTheStorePrice.
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 11/26/2018 18:05:20'!
test11CanNotCheckoutANotCreatedCart

	self
		should: [systemFacade
			checkOutCartIdentifiedAs: self invalidCartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 11/26/2018 18:06:07'!
test12CanNotCheckoutAnEmptyCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade cartCanNotBeEmptyErrorMessage.
			self assert: (systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword) isEmpty ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 11/26/2018 18:07:02'!
test13CanNotCheckoutWithAnExpiredCreditCard

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	self
		should: [systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory expiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: (systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword) isEmpty ]

		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'HAW 11/26/2018 18:07:15'!
test19CanNotCheckOutCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self should: [
		systemFacade
			checkOutCartIdentifiedAs: cartId
			withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
			ownedBy: testObjectsFactory notExpiredCreditCardOwner
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription.
			self assert: (systemFacade listPurchasesOf: self validUser authenticatingWith: self validUserPassword) isEmpty ]


	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'GDH 7/7/2021 19:53:40'!
test26CheckoutGivesATicket

	| cartId ticket expectedLineItems index |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 1 of: self anotherValidBook toCartIdentifiedAs: cartId.
	
	ticket := systemFacade
		checkOutCartIdentifiedAs: cartId
		withCreditCardNumbered: testObjectsFactory notExpiredCreditCardNumber
		ownedBy: testObjectsFactory notExpiredCreditCardOwner
		expiringOn: testObjectsFactory notExpiredMonthOfYear.
		
	expectedLineItems := OrderedCollection with: (LineItem of: self anotherValidBook quantity: 1 total: 15) 
										with: (LineItem of: self validBook quantity: 2 total: 20).
	index := 1.
	ticket lineItemsDo: [ :aLineItem | | expectedLineItem |
								expectedLineItem  := (expectedLineItems at: index).
								self assert: aLineItem item equals: expectedLineItem item .
								self assert: aLineItem total equals: expectedLineItem total .
								index := index + 1. ].
	
	self assert: ticket total equals: 35.

	
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - checkout' stamp: 'MS 7/8/2021 14:04:23'!
test27CanCheckOutACartLookingForCreditCardsInDataBase

	| cartId ticket expectedLineItems index |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 2 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 1 of: self anotherValidBook toCartIdentifiedAs: cartId.
	
	ticket := systemFacade
		checkOutCartIdentifiedAs: cartId ownedBy: self validUser.
		
		
	expectedLineItems := OrderedCollection with: (LineItem of: self anotherValidBook quantity: 1 total: 15) 
										with: (LineItem of: self validBook quantity: 2 total: 20).
	index := 1.
	ticket lineItemsDo: [ :aLineItem | | expectedLineItem |
								expectedLineItem  := (expectedLineItems at: index).
								self assert: aLineItem item equals: expectedLineItem item .
								self assert: aLineItem total equals: expectedLineItem total .
								index := index + 1. ].
	
	self assert: ticket total equals: 35.

	
! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HernanWilkinson 6/17/2015 20:53'!
test07ListCartOfAnEmptyCartReturnsAnEmptyBag

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 11/26/2018 18:04:15'!
test08CanNotListCartOfInvalidCartId

	self
		should: [systemFacade listCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]
	! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 11/26/2018 18:04:32'!
test09ListCartReturnsTheRightNumberOfItems

	| cartId cartContent |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade add: 2 of: self anotherValidBook toCartIdentifiedAs: cartId.
	cartContent := systemFacade listCartIdentifiedAs: cartId.

	self assert: (cartContent occurrencesOf: self validBook) equals: 1.
	self assert: (cartContent occurrencesOf: self anotherValidBook) equals: 2
! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - list cart' stamp: 'HAW 11/26/2018 18:04:42'!
test18CanNotListCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	self
		should: [systemFacade listCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription ].

! !


!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
advanceTime: aDuration

	clock advanceTime: aDuration ! !

!TusLibrosSystemFacadeTest methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:07'!
revertTime: aDuration

	clock revertTime: aDuration ! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - remove from cart' stamp: 'ms 7/7/2021 14:51:56'!
test20CanRemoveItemsFromACreatedCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.

	systemFacade add: 1 of: self validBook toCartIdentifiedAs: cartId.
	systemFacade remove: 1 of: self validBook toCartIdentifiedAs: cartId.
	
	self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty.
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - remove from cart' stamp: 'ms 7/7/2021 14:54:36'!
test21CanNotRemoveItemToNotCreatedCart

	self
		should: [systemFacade remove: 1 of: self validBook toCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidCartIdErrorDescription ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - remove from cart' stamp: 'ms 7/7/2021 14:55:00'!
test22CanNotRemoveItemNotSellByTheStore

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [systemFacade remove: 1 of: self invalidBook toCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade invalidItemErrorMessage.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - remove from cart' stamp: 'ms 7/7/2021 15:00:51'!
test23CanNotRemoveItemNotInCart

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.	
	
	self
		should: [systemFacade remove: 1 of: testObjectsFactory itemSellByTheStore toCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade itemNotInCartErrorMessage.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
		! !

!TusLibrosSystemFacadeTest methodsFor: 'tests - remove from cart' stamp: 'ms 7/7/2021 15:01:34'!
test24CanNotRemoveFromCartWhenSessionIsExpired

	| cartId |

	cartId := systemFacade createCartFor: self validUser authenticatedWith: self validUserPassword.
	self advanceTime: (systemFacade sessionDuration + 1 minutes) .
	
	self
		should: [systemFacade remove: 2 of: self validBook toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: systemFacade sessionHasExpiredErrorDescription.
			self revertTime: systemFacade sessionDuration.
			self assert: (systemFacade listCartIdentifiedAs: cartId) isEmpty ]
! !


!TusLibrosSystemFacadeTest methodsFor: 'tests - catalog' stamp: 'GDH 7/7/2021 18:18:55'!
test25CanAskForSystemCatalog

	| catalog defaultCatalog |

	catalog := systemFacade catalog.
	defaultCatalog := testObjectsFactory defaultCatalog.
	
	self assert: defaultCatalog isbns equals: catalog isbns.
	
	self assert: (defaultCatalog titleOf: 'validBook') equals: (catalog titleOf: 'validBook').
	self assert: (defaultCatalog titleOf: 'anotherValidBook') equals: (catalog titleOf: 'anotherValidBook').
	
	self assert: (defaultCatalog priceOf: 'validBook') equals: (catalog priceOf: 'validBook').
	self assert: (defaultCatalog priceOf: 'anotherValidBook') equals: (catalog priceOf: 'anotherValidBook').! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros-Tests'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStore

	^'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStorePrice

	^15! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'GDH 7/7/2021 17:57:04'!
anotherItemSellByTheStoreTitle

	^'Mi segundo librito'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore

	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore

	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice

	^10! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'GDH 7/7/2021 17:56:51'!
itemSellByTheStoreTitle

	^ 'Mi primero libro'! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart

	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'GDH 7/7/2021 17:57:35'!
defaultCatalog

	^ TusLibrosCatalog new
		add: self itemSellByTheStore titled: self itemSellByTheStoreTitle pricing: self itemSellByTheStorePrice;
		add: self anotherItemSellByTheStore titled: self anotherItemSellByTheStoreTitle pricing: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredCreditCard

	^CreditCard expiringOn: self expiredMonthOfYear ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:24'!
expiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredCreditCard

	^CreditCard expiringOn: self notExpiredMonthOfYear! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 6/19/2018 11:45:30'!
notExpiredCreditCardNumber

	^ '1111222233334444' ! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HAW 6/19/2018 11:45:48'!
notExpiredCreditCardOwner

	^'Juan Perez'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber + 1! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today

	^ today! !


!StoreTestObjectsFactory methodsFor: 'customer' stamp: 'HernanWilkinson 6/22/2013 12:02'!
customer

	^'aCustomer'! !


!classDefinition: #ManualClock category: 'TusLibros-Tests'!
ProtoObject subclass: #ManualClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Tests'!

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 12:54'!
advanceTime: aDuration

	now := now + aDuration ! !

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 13:08'!
revertTime: aDuration

	now := now + aDuration negated ! !


!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:56'!
now

	^ now! !

!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
today

	^now date! !


!ManualClock methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:52'!
initializeNow: aTime

	now := aTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualClock class' category: 'TusLibros-Tests'!
ManualClock class
	instanceVariableNames: ''!

!ManualClock class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:52'!
now: aTime

	^self new initializeNow: aTime ! !

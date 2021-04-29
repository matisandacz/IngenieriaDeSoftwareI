!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 4/22/2021 17:25:26'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstObject'.
	secondPushedObject := 'secondObject'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentenceFinder stackWithFormalHello stackWithFormalHelloByeInformalHello formalHelloSentence informalHelloSentence informalGoodbyeSentence'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'GDH 4/29/2021 01:13:33'!
test01EmptyPrefixShouldThrowError
	
	| emptyStack |
	
	emptyStack := OOStack new.

	self 
		should: [ sentenceFinder findSentencesWithPrefix: '' in: emptyStack ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix EmptyPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'GDH 4/29/2021 01:15:16'!
test02OnlySpacesPrefixShouldThrowError
	
	| emptyStack |
	
	emptyStack := OOStack new.

	self 
		should: [ sentenceFinder findSentencesWithPrefix: '  ' in: emptyStack ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix PrefixCanNotContainEmptySpacesErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'GDH 4/29/2021 01:15:59'!
test03PrefixWithSpacesShouldThrowError
	
	| emptyStack |
	
	emptyStack := OOStack new.

	self 
		should: [ sentenceFinder findSentencesWithPrefix: 'hi how' in: emptyStack ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix PrefixCanNotContainEmptySpacesErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'GDH 4/29/2021 01:15:01'!
test04NoSentenceFoundWhenStackIsEmpty
	
	| emptyStack |
	
	emptyStack := OOStack new.
	
	self assert: (sentenceFinder findSentencesWithPrefix: 'something' in: emptyStack) isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'GDH 4/29/2021 01:14:56'!
test05SentenceFinderDoesNotConfuseUpperCaseWithLowerCase
	
	| matchedSentences |
	
	matchedSentences := sentenceFinder findSentencesWithPrefix: 'Hello' in: stackWithFormalHello .
	
	self assert: matchedSentences isEmpty.
	
	matchedSentences := sentenceFinder findSentencesWithPrefix: 'hello' in: stackWithFormalHello .
	
	self assert: matchedSentences isEmpty not .! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'GDH 4/29/2021 01:14:52'!
test06StackHasNotChangedAfterFindSentencesWithPrefixIn
	
	| nonEmptyStack |
	
	nonEmptyStack := OOStack new.
	
	nonEmptyStack push: formalHelloSentence .
	nonEmptyStack push: informalGoodbyeSentence .
	
	sentenceFinder findSentencesWithPrefix: 'something' in: nonEmptyStack .
	
	self assert: nonEmptyStack pop = informalGoodbyeSentence .
	self assert: nonEmptyStack pop = formalHelloSentence .! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'GDH 4/29/2021 01:14:47'!
test07FindsAllSentencesWithGivenPrefix
	
	| helloPrefix matchedSentences |
	
	helloPrefix := 'hello'.
		
	matchedSentences := sentenceFinder findSentencesWithPrefix: helloPrefix in: stackWithFormalHelloByeInformalHello .
	
	self assert: matchedSentences size = 2 .
	self assert: matchedSentences includes: formalHelloSentence .
	self assert: matchedSentences includes: informalHelloSentence .! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'GDH 4/29/2021 01:14:42'!
test08NoSentenceFoundWhenNoSentenceInStackMatchesPrefix
	
	| hiPrefix matchedSentences |
	
	hiPrefix := 'hi'.
		
	matchedSentences := sentenceFinder findSentencesWithPrefix: hiPrefix in: stackWithFormalHelloByeInformalHello .
	
	self assert: matchedSentences isEmpty .! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'GDH 4/29/2021 01:14:37'!
test09NoSentenceFoundWhenSearchedPrefixIsStemOfSentece
	
	| howPrefix matchedSentences |

	howPrefix := 'how'.
			
	matchedSentences := sentenceFinder findSentencesWithPrefix: howPrefix in: stackWithFormalHello .
	
	self assert: matchedSentences isEmpty .! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'GDH 4/28/2021 17:09:04'!
setUp
		
	sentenceFinder := SentenceFinderByPrefix new.
	stackWithFormalHello := OOStack new.
	stackWithFormalHelloByeInformalHello := OOStack new.
	
	formalHelloSentence := 'hello how are you'.
	informalHelloSentence := 'hello, whats up'.
	informalGoodbyeSentence := 'bye bye'.
	
	stackWithFormalHello push: formalHelloSentence .
	
	stackWithFormalHelloByeInformalHello push: formalHelloSentence .
	stackWithFormalHelloByeInformalHello push: informalGoodbyeSentence.
	stackWithFormalHelloByeInformalHello push: informalHelloSentence .! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'testing' stamp: 'GDH 4/26/2021 18:20:29'!
isEmpty
	
	^top isEmpty.! !

!OOStack methodsFor: 'testing' stamp: 'GDH 4/26/2021 18:20:53'!
size
	
	^size! !


!OOStack methodsFor: 'initialization' stamp: 'GDH 4/26/2021 19:21:42'!
initialize
	
	top := EmptyState new.
	size := 0! !


!OOStack methodsFor: 'grow' stamp: 'GDH 4/26/2021 19:53:23'!
push: anObject 
	
	top := top push: anObject.
	size := size + 1! !


!OOStack methodsFor: 'removing' stamp: 'GDH 4/28/2021 15:10:15'!
pop
	
	| lastElement |
	
	lastElement := top nodeValue.
	top := top previous .
	^lastElement! !


!OOStack methodsFor: 'accessing' stamp: 'GDH 4/26/2021 19:50:46'!
top
	
	^top nodeValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 4/22/2021 17:22:41'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'searching' stamp: 'GDH 4/29/2021 01:00:25'!
findSentencesWithPrefix: aPrefix in: aStack

	| aStackCopy matchedSentences |
	
	aStackCopy := aStack copy.
	matchedSentences := OrderedCollection new.
	
	self validatePrefix: aPrefix.
		
	self addTo: matchedSentences sentencesWithPrefix: aPrefix in: aStackCopy.
			
	^matchedSentences ! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'GDH 4/28/2021 16:55:27'!
addTo: matchedSentences sentencesWithPrefix: aPrefix in: aStack  
		
	| poppedSentence |
		
	self while: aStack IsNotEmptyDo:
		[ poppedSentence := aStack pop.
			self if: poppedSentence hasPrefix: aPrefix addTo: matchedSentences .].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'GDH 4/28/2021 16:55:13'!
if: aSentence hasPrefix: aPrefix addTo: aCollection

	( aSentence beginsWith: aPrefix ) ifTrue: [ aCollection add: aSentence ]. ! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'GDH 4/28/2021 16:10:49'!
while: aStack IsNotEmptyDo: aClosure
	
	^[ aStack isEmpty ] whileFalse: aClosure 
	
	! !


!SentenceFinderByPrefix methodsFor: 'validations' stamp: 'GDH 4/29/2021 01:01:12'!
validatePrefix: aPrefix
	
	self validatePrefixNotEmpty: aPrefix.
	self validatePrefixDoesNotContainEmptySpaces: aPrefix! !

!SentenceFinderByPrefix methodsFor: 'validations' stamp: 'GDH 4/29/2021 01:21:29'!
validatePrefixDoesNotContainEmptySpaces: aPrefix

	( aPrefix includesSubString: ' ' ) ifTrue: [ self throwPrefixCanNotContainEmptySpacesError ]! !

!SentenceFinderByPrefix methodsFor: 'validations' stamp: 'GDH 4/29/2021 01:02:27'!
validatePrefixNotEmpty: aPrefix.
	
	( aPrefix = '' ) ifTrue: [ self throwEmptyPrefixError ]! !


!SentenceFinderByPrefix methodsFor: 'exceptions' stamp: 'GDH 4/29/2021 00:59:17'!
throwEmptyPrefixError
	
	self error: self class EmptyPrefixErrorDescription ! !

!SentenceFinderByPrefix methodsFor: 'exceptions' stamp: 'GDH 4/29/2021 00:59:33'!
throwPrefixCanNotContainEmptySpacesError
	
	self error: self class PrefixCanNotContainEmptySpacesErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error-descriptions' stamp: 'GDH 4/29/2021 00:55:51'!
EmptyPrefixErrorDescription

	^'El prefijo ingresado no puede ser vacío'! !

!SentenceFinderByPrefix class methodsFor: 'error-descriptions' stamp: 'GDH 4/29/2021 00:56:17'!
PrefixCanNotContainEmptySpacesErrorDescription

	^'El prefijo ingresado no puede contener espacios vacíos'! !


!classDefinition: #StackState category: 'Stack-Exercise'!
Object subclass: #StackState
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackState methodsFor: 'grow' stamp: 'GDH 4/26/2021 19:49:38'!
push: anObject
	
	^WithElementsState with: anObject andPrevious: self! !


!StackState methodsFor: 'accessing' stamp: 'GDH 4/26/2021 20:57:52'!
nodeValue
	
	^self subclassResponsibility ! !

!StackState methodsFor: 'accessing' stamp: 'GDH 4/26/2021 19:44:54'!
previous
	
	^self subclassResponsibility ! !


!StackState methodsFor: 'testing' stamp: 'GDH 4/26/2021 19:13:57'!
isEmpty

	^self subclassResponsibility ! !


!classDefinition: #EmptyState category: 'Stack-Exercise'!
StackState subclass: #EmptyState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyState methodsFor: 'testing' stamp: 'GDH 4/26/2021 19:28:01'!
isEmpty
	
	^true! !


!EmptyState methodsFor: 'accessing' stamp: 'GDH 4/26/2021 19:51:45'!
nodeValue
	
	^self error: OOStack stackEmptyErrorDescription ! !

!EmptyState methodsFor: 'accessing' stamp: 'GDH 4/26/2021 19:47:32'!
previous
	
	^self error: OOStack stackEmptyErrorDescription 
	! !


!classDefinition: #WithElementsState category: 'Stack-Exercise'!
StackState subclass: #WithElementsState
	instanceVariableNames: 'previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!WithElementsState methodsFor: 'initialization' stamp: 'GDH 4/26/2021 19:41:38'!
initializeWith: anObject andPrevious: stackState
	
	value := anObject.
	previous := stackState ! !


!WithElementsState methodsFor: 'accessing' stamp: 'GDH 4/26/2021 20:58:11'!
nodeValue
	
	^value! !

!WithElementsState methodsFor: 'accessing' stamp: 'GDH 4/26/2021 19:47:49'!
previous
	
	^previous ! !


!WithElementsState methodsFor: 'testing' stamp: 'GDH 4/26/2021 19:28:13'!
isEmpty
	
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithElementsState class' category: 'Stack-Exercise'!
WithElementsState class
	instanceVariableNames: ''!

!WithElementsState class methodsFor: 'initialization' stamp: 'GDH 4/26/2021 19:40:41'!
with: anObject andPrevious: stackState

	^WithElementsState new initializeWith: anObject andPrevious: stackState! !

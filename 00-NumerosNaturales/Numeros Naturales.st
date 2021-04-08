!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: 'next predecesor suc previous'!

!I class methodsFor: 'as yet unclassified' stamp: 'Mati 4/6/2021 10:06:37'!
* factor

	^factor.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Mati 4/6/2021 10:13:57'!
+ unSumando

	^unSumando next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Mati 4/7/2021 15:50:58'!
- sustraendo
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Mati 4/8/2021 10:59:35'!
/ divisor

	self < divisor ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	
	self = divisor ifTrue: [^I].
	
	^ (self-divisor < divisor) ifTrue: [^I] ifFalse: [^I + (self-divisor/divisor)].
	
	 ! !

!I class methodsFor: 'as yet unclassified' stamp: 'Mati 4/8/2021 10:50:56'!
< unOperando
	^(unOperando isEqualTo: I) ifTrue:[false] ifFalse:[true].! !

!I class methodsFor: 'as yet unclassified' stamp: 'Mati 4/8/2021 10:53:41'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede realizar la division'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Mati 4/7/2021 15:50:34'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No se puede realizar la resta'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Mati 4/8/2021 11:00:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	predecesor := nil.
	suc := II.
	previous := nil.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Mati 4/6/2021 10:13:23'!
next

	suc ifNil: [
		suc := self createChildNamed: self name , 'I'.
		suc previous: self
		].
	^suc.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Mati 4/6/2021 10:12:49'!
previous

	^previous.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Mati 4/6/2021 10:13:01'!
previous: unNumeroNatural

	^previous := unNumeroNatural.! !

!I class methodsFor: 'as yet unclassified' stamp: 'Mati 4/6/2021 10:13:36'!
restaModificada: minuendo

	^minuendo previous.! !


!classDefinition: #II category: 'Numeros Naturales'!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'as yet unclassified' stamp: 'Mati 4/6/2021 10:14:14'!
* factor

	^ (self previous * factor) + factor.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Mati 4/6/2021 10:14:28'!
+ unSumando

	^self previous + unSumando next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Mati 4/6/2021 10:10:07'!
- sustraendo

	^sustraendo restaModificada: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Mati 4/8/2021 10:50:45'!
< unOperando
	(unOperando isEqualTo: I) ifTrue:[^false] ifFalse:[^(self-I)<(unOperando-I)].! !

!II class methodsFor: 'as yet unclassified' stamp: 'Mati 4/8/2021 11:00:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	predecesor := I.
	suc := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Mati 4/6/2021 10:14:40'!
restaModificada: minuendo

	^self previous restaModificada: minuendo previous.! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'Mati 4/8/2021 11:00:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	predecesor := nil.
	suc := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'Mati 4/8/2021 11:00:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	predecesor := nil.
	suc := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Numeros Naturales'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Numeros Naturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'Mati 4/8/2021 11:00:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	predecesor := nil.
	suc := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'Numeros Naturales'!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Numeros Naturales'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'Mati 4/8/2021 11:00:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	predecesor := nil.
	suc := nil.
	previous := IIIII.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
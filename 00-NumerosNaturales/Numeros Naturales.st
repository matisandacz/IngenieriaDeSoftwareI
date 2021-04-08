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

!I class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:15:55'!
* factor

	^factor.! !

!I class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:15:57'!
+ unSumando

	^unSumando next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:16:00'!
- sustraendo

	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:16:12'!
/ divisor

	self < divisor ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].

	self = divisor ifTrue: [^I].
	
	^self - divisor < divisor ifTrue: [I] ifFalse: [I + (self-divisor/divisor)]. ! !

!I class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:16:15'!
< unOperando

	^unOperando = I ifTrue:[false] ifFalse:[true].! !

!I class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:16:29'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'No se puede realizar la division'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:16:35'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	
	^'No se puede realizar la resta'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:17:47'!
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

!II class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:15:51'!
* factor

	^self previous * factor + factor.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Mati 4/6/2021 10:14:28'!
+ unSumando

	^self previous + unSumando next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'Mati 4/6/2021 10:10:07'!
- sustraendo

	^sustraendo restaModificada: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:13:38'!
/ divisor

	self < divisor ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	
	self = divisor ifTrue: [^I].
	
	^self - divisor < divisor ifTrue: [I] ifFalse: [I + (self-divisor/divisor)].! !

!II class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:11:53'!
< unOperando
	^unOperando = I ifTrue:[false] ifFalse:[ self - I < (unOperando - I)].! !

!II class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:17:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	predecesor := I.
	suc := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 4/5/2021 21:07:59'!
next

	next ifNil:[
		next _ self createChildNamed: self name, 'I'.
		next previous: self.
		].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:17:10'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'GDH 4/5/2021 21:04:30'!
previous: aPreviousNumber 
	previous _ aPreviousNumber! !

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

!III class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:17:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
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

!IIII class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:17:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
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

!IIIII class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:17:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
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

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:17:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIII.
	predecesor := nil.
	suc := nil.
	previous := IIIII.! !


!classDefinition: #IIIIIII category: 'Numeros Naturales'!
IIIIII subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: 'Numeros Naturales'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:17:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIII.
	predecesor := nil.
	suc := nil.
	previous := IIIIII.! !


!classDefinition: #IIIIIIII category: 'Numeros Naturales'!
IIIIIII subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: 'Numeros Naturales'!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:17:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIII.
	predecesor := nil.
	suc := nil.
	previous := IIIIIII.! !


!classDefinition: #IIIIIIIII category: 'Numeros Naturales'!
IIIIIIII subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'GDH 4/8/2021 15:17:47'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	predecesor := nil.
	suc := nil.
	previous := IIIIIIII.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!
IIIIIIIII initializeAfterFileIn!
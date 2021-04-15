!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'GDH 4/13/2021 19:57:26'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| customerBook |
	customerBook := CustomerBook new.
	self VerificarEvaluacionDe: [customerBook addCustomerNamed: 'John Lennon'.] TardeMenosQue: 50
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GDH 4/13/2021 20:12:19'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook paulMcCartney |	paulMcCartney := 'Paul McCartney' .
	customerBook := self CrearUnLibroCon: paulMcCartney. 
	self VerificarEvaluacionDe: [customerBook removeCustomerNamed: paulMcCartney.] TardeMenosQue: 100
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GDH 4/13/2021 20:14:58'!
test03CanNotAddACustomerWithEmptyName 
	| customerBook |
	customerBook := CustomerBook new.
	self EnCasoDeQue: [customerBook addCustomerNamed: ''] 
		Arroje: Error 
		EvaluarConLaExcepcion: [ :anError |
		self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
		self assert: customerBook isEmpty].
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GDH 4/13/2021 20:28:51'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook johnLennon |
	johnLennon := 'John Lennon'.
	customerBook := self CrearUnLibroCon: johnLennon. 
	
	self EnCasoDeQue: [customerBook removeCustomerNamed: 'Paul McCartney'.] Arroje: NotFound 
		VerificarQue: customerBook SoloContengaA: johnLennon 
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GDH 4/13/2021 20:11:45'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook
	| customerBook paulMcCartney|
	paulMcCartney := 'Paul McCartney'.
	customerBook := self CrearUnLibroConUnClienteSuspendido: paulMcCartney .		
	self VerificarQueEn: customerBook Con: 1 ActivosSon: 0 YSuspendidosSon: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GDH 4/13/2021 20:11:34'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	| customerBook paulMcCartney|
	paulMcCartney := 'Paul McCartney'.
		customerBook := self CrearUnLibroConUnClienteSuspendido: paulMcCartney .
	customerBook removeCustomerNamed: paulMcCartney.
	self VerificarQueEn: customerBook Con: 0 ActivosSon: 0 YSuspendidosSon: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Semaforo 4/14/2021 14:14:43'!
test07CanNotSuspendAnInvalidCustomer
	| customerBook johnLennon |
	johnLennon := 'John Lennon'.
		customerBook := self CrearUnLibroCon: johnLennon .
	
	self EnCasoDeQue: [ customerBook suspendCustomerNamed: 'George Harrison'] Arroje: CantSuspend VerificarQue: customerBook SoloContengaA: johnLennon! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GDH 4/13/2021 20:39:33'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.
	customerBook := self CrearUnLibroConUnClienteSuspendido: johnLennon.
	
	self EnCasoDeQue: [ customerBook suspendCustomerNamed: johnLennon] Arroje: CantSuspend 
		VerificarQue: 		customerBook SoloContengaA: johnLennon .
! !


!CustomerBookTest methodsFor: 'private' stamp: 'GDH 4/13/2021 19:33:15'!
CrearUnLibroCon: unCliente

	| customerBook |

	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: unCliente.
	
	^customerBook.! !

!CustomerBookTest methodsFor: 'private' stamp: 'GDH 4/13/2021 19:37:39'!
CrearUnLibroConUnClienteSuspendido: unCliente
	
	| customerBook |
	
	customerBook := self CrearUnLibroCon: unCliente .
	customerBook suspendCustomerNamed: unCliente .
	
	^customerBook ! !

!CustomerBookTest methodsFor: 'private' stamp: 'Semaforo 4/14/2021 22:05:12'!
EnCasoDeQue: unClosure Arroje: unaExcepcion EvaluarConLaExcepcion: otroClosure

	[ unClosure value.
	self fail ]
		on: unaExcepcion
		do: [ :anError | 
			otroClosure value: anError]
		
! !

!CustomerBookTest methodsFor: 'private' stamp: 'GDH 4/13/2021 20:26:53'!
EnCasoDeQue: unClosure Arroje: unaExcepcion VerificarQue: unLibro SoloContengaA: unCliente

	self EnCasoDeQue: unClosure Arroje: unaExcepcion 		EvaluarConLaExcepcion: [ :anError | 
			self assert: unLibro numberOfCustomers = 1.
			self assert: (unLibro includesCustomerNamed: unCliente) ]! !

!CustomerBookTest methodsFor: 'private' stamp: 'Semaforo 4/13/2021 18:42:33'!
VerificarEvaluacionDe: unClosure TardeMenosQue: unaCantidadDeMiliSegundos
	
	|millisecondsBeforeRunning millisecondsAfterRunning |
   
    	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
    	unClosure value.
    	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
    
    	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (unaCantidadDeMiliSegundos * millisecond)! !

!CustomerBookTest methodsFor: 'private' stamp: 'GDH 4/13/2021 20:09:38'!
VerificarQueEn: customerBook Con: cantClientesTotales ActivosSon: cantClientesActivos YSuspendidosSon: cantClientesSuspendidos

	self assert: cantClientesActivos equals: customerBook numberOfActiveCustomers.
	self assert: cantClientesSuspendidos equals: customerBook numberOfSuspendedCustomers.
	self assert: cantClientesTotales equals: customerBook numberOfCustomers.! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'Semaforo 4/14/2021 15:37:45'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'Semaforo 4/14/2021 15:38:24'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'Semaforo 4/14/2021 22:26:34'!
removeCustomerNamed: aName 


	^(self includesCustomerNamed: aName) ifTrue: [self Borrar: aName SiPerteneceEn: active. 
		self Borrar: aName SiPerteneceEn: suspended. 
		aName] 
	ifFalse: [NotFound signal].

! !

!CustomerBook methodsFor: 'customer management' stamp: 'Semaforo 4/14/2021 22:22:22'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'private' stamp: 'Semaforo 4/14/2021 22:25:56'!
Borrar: unCliente SiPerteneceEn: unSubconjuntoDeClientes 

	1 to: unSubconjuntoDeClientes  size do: 
	[ :index |
		unCliente = (unSubconjuntoDeClientes  at: index)
			ifTrue: [
				unSubconjuntoDeClientes  removeAt: index.
				^ unCliente
			] 
	].

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:13'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:09'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!!!!!'! !

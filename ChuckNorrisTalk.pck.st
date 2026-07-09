'From Cuis7.9 [latest update: #8056] on 9 July 2026 at 10:48:40 am'!
'Description new LayoutMorph hierarchy '!
!provides: 'ChuckNorrisTalk' 1 28!
!requires: 'WebClient' 1 19 nil!
!requires: 'Graphics-Files-Additional' 1 23 nil!
SystemOrganization addCategory: #ChuckNorrisTalk!


!classDefinition: #ChuckNorrisFact category: #ChuckNorrisTalk!
Object subclass: #ChuckNorrisFact
	instanceVariableNames: 'id url value categories iconUrl'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ChuckNorrisTalk'!
!classDefinition: 'ChuckNorrisFact class' category: #ChuckNorrisTalk!
ChuckNorrisFact class
	instanceVariableNames: ''!

!classDefinition: #ChuckNorrisIoClient category: #ChuckNorrisTalk!
Object subclass: #ChuckNorrisIoClient
	instanceVariableNames: 'queryStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ChuckNorrisTalk'!
!classDefinition: 'ChuckNorrisIoClient class' category: #ChuckNorrisTalk!
ChuckNorrisIoClient class
	instanceVariableNames: ''!

!classDefinition: #ChuckNorrisMorph category: #ChuckNorrisTalk!
LinearLayoutMorph subclass: #ChuckNorrisMorph
	instanceVariableNames: 'client fact chuckNorrisImage imageMorph factTextMorph'
	classVariableNames: 'ChuckNorrisIcon'
	poolDictionaries: ''
	category: 'ChuckNorrisTalk'!
!classDefinition: 'ChuckNorrisMorph class' category: #ChuckNorrisTalk!
ChuckNorrisMorph class
	instanceVariableNames: ''!


!ChuckNorrisFact commentStamp: '<historical>' prior: 0!
I am a Chuck Norris joke (ok, fact)!

!ChuckNorrisIoClient commentStamp: '<historical>' prior: 0!
I am a client for chucknorris.io,  a free JSON API for hand curated Chuck Norris facts. https://api.chucknorris.io/!

!ChuckNorrisMorph commentStamp: 'tsl 1/3/2022 07:20:57' prior: 0!
A morph to show random facts.

Execute:
ChuckNorrisMorph open.
!

!ChuckNorrisFact methodsFor: 'printing' stamp: 'tsl 31/Aug/2020, 6:23:38 pm (UTC)'!
printOn: aStream
	super printOn: aStream.
	aStream nextPut: $(;
		nextPutAll: self value;
		nextPut: $)! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'tsl 31/Aug/2020, 5:48:54 pm (UTC)'!
categories
	^ categories! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'tsl 31/Aug/2020, 5:49:16 pm (UTC)'!
categories: anArray
	categories := anArray! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/Mar/2019, 5:22:27 pm (UTC)'!
iconUrl
	^ iconUrl! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/Mar/2019, 5:22:35 pm (UTC)'!
iconUrl: aString
	iconUrl := aString! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/Mar/2019, 5:19:38 pm (UTC)'!
id
	^ id! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/Mar/2019, 5:19:27 pm (UTC)'!
id: aString
	id := aString! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/Mar/2019, 5:20:18 pm (UTC)'!
url
	^ url! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/Mar/2019, 5:20:07 pm (UTC)'!
url: aString
	url := aString! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/Mar/2019, 6:38:56 pm (UTC)'!
value
	^ value! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/Mar/2019, 6:39:03 pm (UTC)'!
value: aString
	value := aString! !

!ChuckNorrisFact class methodsFor: 'as yet unclassified' stamp: 'tsl 31/Aug/2020, 5:49:30 pm (UTC)'!
newFromJson: aJsonDictionary
	^ self new
		id: (aJsonDictionary at: #id);
		url: (aJsonDictionary at: #url); 
		categories: (aJsonDictionary at: #categories); 
		iconUrl: (aJsonDictionary at: #icon_url);
		value:  (aJsonDictionary at: #value);  
		yourself ! !

!ChuckNorrisIoClient methodsFor: 'accessing' stamp: 'TSL 2/Mar/2019, 1:49:12 pm (UTC)'!
baseUrl
	^ 'https://api.chucknorris.io/jokes/'! !

!ChuckNorrisIoClient methodsFor: 'accessing' stamp: 'TSL 3/Mar/2019, 6:53:55 pm (UTC)'!
categories
	self initializeQueryStream.
	self queryStream  
		nextPutAll: 'categories'.
		
	^ self retrieveContents! !

!ChuckNorrisIoClient methodsFor: 'accessing' stamp: 'tsl 1/Sep/2024, 1:36:18 pm (UTC)'!
chuckNorrisImage
	 ^ (WebClient httpGet: 'https://api.chucknorris.io/img/chucknorris_logo_coloured_small.png') content! !

!ChuckNorrisIoClient methodsFor: 'accessing' stamp: 'TSL 2/Mar/2019, 1:42:58 pm (UTC)'!
queryStream
	^ queryStream! !

!ChuckNorrisIoClient methodsFor: 'accessing' stamp: 'TSL 3/Mar/2019, 6:53:49 pm (UTC)'!
random
	self initializeQueryStream.
	self queryStream  
		nextPutAll: 'random'.
		
	^  ChuckNorrisFact newFromJson: (self retrieveContents)! !

!ChuckNorrisIoClient methodsFor: 'accessing' stamp: 'TSL 24/Mar/2019, 3:50:28 pm (UTC)'!
randomByCategory: aString
	self initializeQueryStream.
	self queryStream  
		nextPutAll: 'random';
		nextPutAll: '?category=';
		nextPutAll: aString .
		
	 [ ^ ChuckNorrisFact newFromJson: (self retrieveContents) ]
		on: Error do: [ ^ nil].! !

!ChuckNorrisIoClient methodsFor: 'accessing' stamp: 'TSL 24/Mar/2019, 3:51:14 pm (UTC)'!
search: aString
	
	self initializeQueryStream.
	self queryStream  
		nextPutAll: 'search';
		nextPutAll: '?query=';
		nextPutAll: aString .
		
	[ ^ (self retrieveContents at: #result) 
		collect: [ :each | ChuckNorrisFact newFromJson: each ]]
		on: Error do: [^ nil]! !

!ChuckNorrisIoClient methodsFor: 'private' stamp: 'TSL 2/Mar/2019, 1:42:39 pm (UTC)'!
execute
	^ (WebClient httpGet: self queryStream contents) content! !

!ChuckNorrisIoClient methodsFor: 'private' stamp: 'TSL 2/Mar/2019, 1:43:40 pm (UTC)'!
retrieveContents
	^ WebUtils jsonDecode: (self execute readStream) ! !

!ChuckNorrisIoClient methodsFor: 'initialization' stamp: 'TSL 2/Mar/2019, 1:44:15 pm (UTC)'!
initialize
	super initialize.
	self initializeQueryStream.! !

!ChuckNorrisIoClient methodsFor: 'initialization' stamp: 'TSL 2/Mar/2019, 1:45:32 pm (UTC)'!
initializeQueryStream
	queryStream := (ReadWriteStream on: String new).
	queryStream nextPutAll: self baseUrl.! !

!ChuckNorrisMorph methodsFor: 'initialization' stamp: 'tsl 9/Jul/2026, 1:44:49 pm (UTC)'!
initialize
	super initialize.
	self color: Color blue.
	
	client := ChuckNorrisIoClient new.
	fact := client random.
	
	imageMorph := ImageMorph new image: (Form fromBinaryStream: self chuckNorrisImage  asByteArray readStream).
	factTextMorph := TextModelMorph withText: self fact value.
	factTextMorph color: Theme current background lighter lighter.
	
	self addMorph: imageMorph;
		addMorph: factTextMorph layoutSpec: (LayoutSpec proportionalWidth: 0.8 proportionalHeight: 0.9);
		addMorph: (PluggableButtonMorph model: [ self nextRandomFact ] action: #value label: 'Next').

	! !

!ChuckNorrisMorph methodsFor: 'accessing' stamp: 'tsl 1/Sep/2024, 1:37:04 pm (UTC)'!
chuckNorrisImage
	chuckNorrisImage isNil ifTrue: [ 
		chuckNorrisImage := client chuckNorrisImage ].
	^ chuckNorrisImage! !

!ChuckNorrisMorph methodsFor: 'accessing' stamp: 'TSL 5/Mar/2019, 7:22:05 pm (UTC)'!
client
	^ client ! !

!ChuckNorrisMorph methodsFor: 'accessing' stamp: 'TSL 5/Mar/2019, 8:49:47 pm (UTC)'!
fact
	^ fact ! !

!ChuckNorrisMorph methodsFor: 'as yet unclassified' stamp: 'TSL 5/Mar/2019, 9:01:47 pm (UTC)'!
nextRandomFact
	fact := self client random.
	self redrawNeeded.! !

!ChuckNorrisMorph methodsFor: 'drawing' stamp: 'TSL 24/Mar/2019, 2:21:11 pm (UTC)'!
drawOn: aCanvas
	super drawOn: aCanvas .
	factTextMorph model:  (TextModel withText: self fact value).
! !

!ChuckNorrisMorph class methodsFor: 'accessing' stamp: 'tsl 28/Nov/2023, 4:55:41 pm (UTC)'!
chuckNorrisIcon
	^ ChuckNorrisIcon ! !

!ChuckNorrisMorph class methodsFor: 'accessing' stamp: 'tsl 9/Jul/2026, 1:46:47 pm (UTC)'!
open
	| area window |
	window := SystemWindow new.
	window setLabel: 'Chuck Norris Fact'.
	
	area := (self newColumn separation: 5) name: #AREA.
	area color: Theme current background lighter.

	window 
		addMorph: area;
		openInWorld.
	window 
		morphPosition: 1@1;
		morphExtent: 550@480.! !

!ChuckNorrisMorph class methodsFor: 'menu-world' stamp: 'tsl 28/Nov/2023, 6:37:25 pm (UTC)'!
worldMenuOptions
	| arr |
	arr := `{{
			#itemGroup 		-> 		10.
			#itemOrder 		-> 		50.
			#label 			->			'Tell me more about Chuck Norris'.
			#object 			-> 		ChuckNorrisMorph .
			#selector 		-> 		#open.
			#balloonText 	-> 		'Tell me more about Chuck Norris'.
		} asDictionary}`.
	(arr at: 1) at: #icon put: self chuckNorrisIcon.
	^ arr! !

!ChuckNorrisMorph class methodsFor: 'new-morph participation' stamp: 'tsl 28/Nov/2023, 4:45:33 pm (UTC)'!
includeInNewMorphMenu
	"Return true for all classes that can be instantiated from the menu"
	^ false! !

!ChuckNorrisMorph class methodsFor: 'class initialization' stamp: 'tsl 28/Nov/2023, 5:01:37 pm (UTC)'!
initialize
	| dirName |
	dirName :=  (self package) fullFileName upToLastPathSeparator.
	ChuckNorrisIcon := ImageReadWriter formFromFileNamed: dirName , '/', 'chuckicon.png'.
! !
ChuckNorrisMorph initialize!

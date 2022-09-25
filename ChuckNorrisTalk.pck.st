'From Cuis 6.0 [latest update: #5492] on 25 September 2022 at 12:26:53 pm'!
'Description fix image url'!
!provides: 'ChuckNorrisTalk' 1 21!
!requires: 'WebClient' 1 19 nil!
!requires: 'Graphics-Files-Additional' 1 23 nil!
SystemOrganization addCategory: 'ChuckNorrisTalk'!


!classDefinition: #ChuckNorrisMorph category: 'ChuckNorrisTalk'!
LayoutMorph subclass: #ChuckNorrisMorph
	instanceVariableNames: 'client fact chuckNorrisImage imageMorph factTextMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ChuckNorrisTalk'!
!classDefinition: 'ChuckNorrisMorph class' category: 'ChuckNorrisTalk'!
ChuckNorrisMorph class
	instanceVariableNames: ''!

!classDefinition: #ChuckNorrisFact category: 'ChuckNorrisTalk'!
Object subclass: #ChuckNorrisFact
	instanceVariableNames: 'id url value categories iconUrl'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ChuckNorrisTalk'!
!classDefinition: 'ChuckNorrisFact class' category: 'ChuckNorrisTalk'!
ChuckNorrisFact class
	instanceVariableNames: ''!

!classDefinition: #ChuckNorrisIoClient category: 'ChuckNorrisTalk'!
Object subclass: #ChuckNorrisIoClient
	instanceVariableNames: 'queryStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ChuckNorrisTalk'!
!classDefinition: 'ChuckNorrisIoClient class' category: 'ChuckNorrisTalk'!
ChuckNorrisIoClient class
	instanceVariableNames: ''!


!ChuckNorrisMorph commentStamp: 'tsl 1/3/2022 07:20:57' prior: 0!
A morph to show random facts.

Execute:
ChuckNorrisMorph open.
!

!ChuckNorrisFact commentStamp: '<historical>' prior: 0!
I am a Chuck Norris joke (ok, fact)!

!ChuckNorrisIoClient commentStamp: '<historical>' prior: 0!
I am a client for chucknorris.io,  a free JSON API for hand curated Chuck Norris facts. https://api.chucknorris.io/!

!ChuckNorrisMorph methodsFor: 'initialization' stamp: 'tsl 1/3/2022 07:19:41'!
initialize
	super initialize.
	self color: Color blue.
	
	client := ChuckNorrisIoClient new.
	fact := client random.
	
	imageMorph := ImageMorph new image: (Form fromBinaryStream: self chuckNorrisImage  asByteArray readStream).
	factTextMorph := TextModelMorph withText: self fact value.
	
	self addMorph: imageMorph;
		addMorph: factTextMorph layoutSpec: (LayoutSpec proportionalWidth: 0.8 proportionalHeight: 0.9);
		addMorph: (PluggableButtonMorph model: [ self nextRandomFact ] action: #value label: 'Next').

	! !

!ChuckNorrisMorph methodsFor: 'accessing' stamp: 'tsl 9/25/2022 12:24:13'!
chuckNorrisImage
	chuckNorrisImage isNil ifTrue: [ 
		chuckNorrisImage := (WebClient httpGet: 'https://api.chucknorris.io/img/chucknorris_logo_coloured_small.png') content ].
	^ chuckNorrisImage! !

!ChuckNorrisMorph methodsFor: 'accessing' stamp: 'TSL 3/5/2019 16:22:05'!
client
	^ client ! !

!ChuckNorrisMorph methodsFor: 'accessing' stamp: 'TSL 3/5/2019 17:49:47'!
fact
	^ fact ! !

!ChuckNorrisMorph methodsFor: 'as yet unclassified' stamp: 'TSL 3/5/2019 18:01:47'!
nextRandomFact
	fact := self client random.
	self redrawNeeded.! !

!ChuckNorrisMorph methodsFor: 'drawing' stamp: 'TSL 3/24/2019 11:21:11'!
drawOn: aCanvas
	super drawOn: aCanvas .
	factTextMorph model:  (TextModel withText: self fact value).
! !

!ChuckNorrisMorph class methodsFor: 'accessing' stamp: 'tsl 9/25/2022 12:26:07'!
open
	| area window |
	window := SystemWindow new.
	window setLabel: 'Chuck Norris Fact'.
	
	area := (self newColumn separation: 5) name: #AREA.
	area color: Color red.

	window addMorph: area .
	
	window openInWorld.
	window widgetsColor: Color blue.
	window morphPosition: 1@1 extent:550@480.

! !

!ChuckNorrisFact methodsFor: 'printing' stamp: 'tsl 8/31/2020 15:23:38'!
printOn: aStream
	super printOn: aStream.
	aStream nextPut: $(;
		nextPutAll: self value;
		nextPut: $)! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'tsl 8/31/2020 14:48:54'!
categories
	^ categories! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'tsl 8/31/2020 14:49:16'!
categories: anArray
	categories := anArray! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/3/2019 14:22:27'!
iconUrl
	^ iconUrl! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/3/2019 14:22:35'!
iconUrl: aString
	iconUrl := aString! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/3/2019 14:19:38'!
id
	^ id! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/3/2019 14:19:27'!
id: aString
	id := aString! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/3/2019 14:20:18'!
url
	^ url! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/3/2019 14:20:07'!
url: aString
	url := aString! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/3/2019 15:38:56'!
value
	^ value! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/3/2019 15:39:03'!
value: aString
	value := aString! !

!ChuckNorrisFact class methodsFor: 'as yet unclassified' stamp: 'tsl 8/31/2020 14:49:30'!
newFromJson: aJsonDictionary
	^ self new
		id: (aJsonDictionary at: #id);
		url: (aJsonDictionary at: #url); 
		categories: (aJsonDictionary at: #categories); 
		iconUrl: (aJsonDictionary at: #icon_url);
		value:  (aJsonDictionary at: #value);  
		yourself ! !

!ChuckNorrisIoClient methodsFor: 'accessing' stamp: 'TSL 3/2/2019 10:49:12'!
baseUrl
	^ 'https://api.chucknorris.io/jokes/'! !

!ChuckNorrisIoClient methodsFor: 'accessing' stamp: 'TSL 3/3/2019 15:53:55'!
categories
	self initializeQueryStream.
	self queryStream  
		nextPutAll: 'categories'.
		
	^ self retrieveContents! !

!ChuckNorrisIoClient methodsFor: 'accessing' stamp: 'TSL 3/2/2019 10:42:58'!
queryStream
	^ queryStream! !

!ChuckNorrisIoClient methodsFor: 'accessing' stamp: 'TSL 3/3/2019 15:53:49'!
random
	self initializeQueryStream.
	self queryStream  
		nextPutAll: 'random'.
		
	^  ChuckNorrisFact newFromJson: (self retrieveContents)! !

!ChuckNorrisIoClient methodsFor: 'accessing' stamp: 'TSL 3/24/2019 12:50:28'!
randomByCategory: aString
	self initializeQueryStream.
	self queryStream  
		nextPutAll: 'random';
		nextPutAll: '?category=';
		nextPutAll: aString .
		
	 [ ^ ChuckNorrisFact newFromJson: (self retrieveContents) ]
		on: Error do: [ ^ nil].! !

!ChuckNorrisIoClient methodsFor: 'accessing' stamp: 'TSL 3/24/2019 12:51:14'!
search: aString
	
	self initializeQueryStream.
	self queryStream  
		nextPutAll: 'search';
		nextPutAll: '?query=';
		nextPutAll: aString .
		
	[ ^ (self retrieveContents at: #result) 
		collect: [ :each | ChuckNorrisFact newFromJson: each ]]
		on: Error do: [^ nil]! !

!ChuckNorrisIoClient methodsFor: 'private' stamp: 'TSL 3/2/2019 10:42:39'!
execute
	^ (WebClient httpGet: self queryStream contents) content! !

!ChuckNorrisIoClient methodsFor: 'private' stamp: 'TSL 3/2/2019 10:43:40'!
retrieveContents
	^ WebUtils jsonDecode: (self execute readStream) ! !

!ChuckNorrisIoClient methodsFor: 'initialization' stamp: 'TSL 3/2/2019 10:44:15'!
initialize
	super initialize.
	self initializeQueryStream.! !

!ChuckNorrisIoClient methodsFor: 'initialization' stamp: 'TSL 3/2/2019 10:45:32'!
initializeQueryStream
	queryStream := (ReadWriteStream on: String new).
	queryStream nextPutAll: self baseUrl.! !

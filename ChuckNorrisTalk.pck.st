'From Cuis 5.0 of 7 November 2016 [latest update: #3610] on 24 March 2019 at 12:58:41 pm'!
'Description error handling'!
!provides: 'ChuckNorrisTalk' 1 13!
!requires: 'Graphics-Files-Additional' 1 22 nil!
!requires: 'WebClient' 1 16 nil!
SystemOrganization addCategory: #ChuckNorrisTalk!


!classDefinition: #ChuckNorrisMorph category: #ChuckNorrisTalk!
LayoutMorph subclass: #ChuckNorrisMorph
	instanceVariableNames: 'client fact chuckNorrisImage imageMorph factTextMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ChuckNorrisTalk'!
!classDefinition: 'ChuckNorrisMorph class' category: #ChuckNorrisTalk!
ChuckNorrisMorph class
	instanceVariableNames: ''!

!classDefinition: #ChuckNorrisFact category: #ChuckNorrisTalk!
Object subclass: #ChuckNorrisFact
	instanceVariableNames: 'id url value category iconUrl'
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


!ChuckNorrisMorph commentStamp: '<historical>' prior: 0!
A morph to show random facts.!

!ChuckNorrisFact commentStamp: '<historical>' prior: 0!
I am a Chuck Norris joke (ok, fact)!

!ChuckNorrisIoClient commentStamp: '<historical>' prior: 0!
I am a client for chucknorris.io,  a free JSON API for hand curated Chuck Norris facts. https://api.chucknorris.io/!

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/3/2019 14:22:48'!
category
	^ category! !

!ChuckNorrisFact methodsFor: 'accessing' stamp: 'TSL 3/3/2019 14:22:55'!
category: aString
	category := aString! !

!ChuckNorrisMorph methodsFor: 'initialization' stamp: 'TSL 3/24/2019 11:15:54'!
initialize
	super initialize.
	self color: Color blue.
	
	client := ChuckNorrisIoClient new.
	fact := client random.
	
	imageMorph := ImageMorph new image: (Form fromBinaryStream: self chuckNorrisImage  asByteArray readStream).
	factTextMorph := TextModelMorph withText: self fact value.
	
	self addMorph: imageMorph;
		addMorph: factTextMorph layoutSpec: (LayoutSpec proportionalWidth: 0.7 proportionalHeight: 0.5);
		addMorph: (PluggableButtonMorph model: [ self nextRandomFact ] action: #value label: 'Next').

	! !

!ChuckNorrisMorph methodsFor: 'accessing' stamp: 'TSL 3/6/2019 11:27:36'!
chuckNorrisImage
	chuckNorrisImage isNil ifTrue: [ 
		chuckNorrisImage := (WebClient httpGet: 'https://assets.chucknorris.host/img/avatar/chuck-norris.png') content ].
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

!ChuckNorrisMorph class methodsFor: 'accessing' stamp: 'TSL 3/24/2019 11:43:11'!
open
	| area window |
	window := SystemWindow new.
	window setLabel: 'Chuck Norris Fact'.
	
	area := (self newColumn separation: 5) name: #AREA.
	area color: Color red.

	window addMorph: area .
	
	window openInWorld.
	window widgetsColor: Color blue.
	window morphPosition: 1@1 extent:350@300.

! !

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

!ChuckNorrisFact class methodsFor: 'as yet unclassified' stamp: 'TSL 3/3/2019 15:40:01'!
newFromJson: aJsonDictionary
	^ self new
		id: (aJsonDictionary at: #id);
		url: (aJsonDictionary at: #url); 
		category: (aJsonDictionary at: #category); 
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

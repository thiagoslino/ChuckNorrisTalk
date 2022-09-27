# ChuckNorrisTalk

## What is it?

This project is a client for [Chuck Norris Api](https://api.chucknorris.io/) written in [Smalltalk (Cuis)](https://github.com/Cuis-Smalltalk/Cuis-Smalltalk-Dev).

## Running
After cloning this repository, open a workspace in Cuis and type:

```Smalltalk 
Feature require: #'ChuckNorrisTalk'. 
```

And then:

```Smalltalk
|client|
client := ChuckNorrisIoClient  new.

client random. "inspect it for a random fact"

client categories. "inspect it for a list of categories"

client randomByCategory: #dev. "inspect it for a random fact by category"

client  search: 'brazil' "inspect it for a list of facts"
```

## Morph for random facts.
There is a simple morph to show random facts. Execute:

```Smalltalk
ChuckNorrisMorph  open 
```

![alt text](https://github.com/thiagoslino/ChuckNorrisTalk/blob/master/screen.png "Chip-8 for Cuis")

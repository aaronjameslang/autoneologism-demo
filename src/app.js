const Elm = require('../main.js')
const anl = require('autoneologism')

const parametersApp = Elm.ParametersApp.embed(document.getElementsByClassName('params')[0])
const    resultsApp = Elm.   ResultsApp.embed(document.getElementsByClassName('results')[0])

parametersApp.ports.generateWords.subscribe(params => {
  const result = anl.generateWords(params.wordsIn);
  resultsApp.ports.generatedWords.send(result);
});

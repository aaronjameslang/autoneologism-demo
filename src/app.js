const Elm = require('../main.js')
const anl = require('autoneologism')

const app = Elm.Main.fullscreen()

app.ports.generateWords.subscribe(params => {
  const result = anl.generateWords(params.words);
  app.ports.generatedWords.send(result);
});

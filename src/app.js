const Elm = require('../main.js')
const anl = require('autoneologism')

const app = Elm.Main.fullscreen()

app.ports.generateWords.subscribe(wordsIn => {
  const result = anl.generateWords(wordsIn);
  app.ports.generatedWords.send(result);
});

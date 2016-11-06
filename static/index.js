
/**
 * Entry point. Can be required from webpack.
 */
var Elm = require('../src/Main');
var container = document.getElementById('container');
var app = Elm.Main.embed(container);


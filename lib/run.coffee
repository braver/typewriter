$ = require 'jquery'

module.exports =

  start: () ->

    atom.config.set('.gfm.source', 'editor.softWrap', true)
    atom.config.set('.html.mediawiki.text', 'editor.softWrap', true)

    editor = atom.workspace.getActiveTextEditor()

    if editor isnt undefined # e.g. settings-view
      $('[data-grammar="source gfm"] /deep/ .editor--private').css 'max-width', editor.getDefaultCharWidth() * atom.config.get(['.gfm.source'],'editor.preferredLineLength')
      $('[data-grammar="text html mediawiki"] /deep/ .editor--private').css 'max-width', editor.getDefaultCharWidth() * atom.config.get(['.text.html.mediawiki'],'editor.preferredLineLength')

  stop: () ->
    $('[data-grammar="source gfm"] /deep/ .editor--private').css 'max-width', ''
    $('[data-grammar="text html mediawiki"] /deep/ .editor--private').css 'max-width', ''

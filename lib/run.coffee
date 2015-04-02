$ = require 'jquery'

module.exports =

  run: () ->
    atom.config.set('editor.softWrap', true)
    editor = atom.workspace.getActiveTextEditor()
    width = atom.config.get 'editor.preferredLineLength'

    if editor isnt undefined # e.g. settings-view
      $('[data-grammar="source gfm"] /deep/ .editor--private').css 'max-width', editor.getDefaultCharWidth() * width

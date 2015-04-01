$ = require 'jquery'

module.exports =

  run: () ->
    atom.themes.onDidChangeActiveThemes ->
    atom.config.set('editor.softWrap', true)

    writerMode = () ->
      editor = atom.workspace.getActiveTextEditor()
      width = atom.config.get 'editor.preferredLineLength'

      if editor isnt undefined # e.g. settings-view
        $('[data-grammar="source gfm"] /deep/ .editor--private').css 'max-width', editor.getDefaultCharWidth() * width

    requestAnimationFrame ->
      writerMode()

    # Listen config changes
    @fontChanged = atom.config.onDidChange 'editor.fontSize', ->
      requestAnimationFrame ->
        writerMode()

    @widthChanged = atom.config.onDidChange 'editor.preferredLineLength', ->
      requestAnimationFrame ->
        writerMode()

    # And to tab switching, opening files, etc.
    @paneChanged = atom.workspace.onDidChangeActivePaneItem ->
      requestAnimationFrame ->
        writerMode()

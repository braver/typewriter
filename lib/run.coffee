module.exports =

  start: () ->

    editor = atom.workspace.getActiveTextEditor()

    typewriterMode = (scope) ->
      if atom.views.getView(editor).getAttribute('style') isnt null
        oldStyle = atom.views.getView(editor).getAttribute('style')
      else
        oldStyle = ''
      characterWidth = editor.getDefaultCharWidth()
      charactersPerLine = atom.config.get([scope],'editor.preferredLineLength')
      newStyle = oldStyle + 'max-width:' + characterWidth * charactersPerLine + 'px;'

      atom.config.set(scope, 'editor.softWrap', true)
      atom.views.getView(editor).setAttribute('style', newStyle)
      atom.views.getView(editor).setAttribute('data-typewriter', true)

    if editor isnt undefined # e.g. settings-view
      currentScope = editor.getRootScopeDescriptor().scopes[0]
      if currentScope is 'source.gfm' or currentScope is 'text.html.mediawiki'
        typewriterMode(currentScope)


  stop: () ->
    $ = require 'jquery'
    $('atom-text-editor:not(.mini)').css 'max-width', ''

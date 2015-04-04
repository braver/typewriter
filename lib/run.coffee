module.exports =

  start: () ->

    editor = atom.workspace.getActiveTextEditor()

    typewriterMode = (scope) ->
      atom.config.set(scope, 'editor.softWrap', true)
      if atom.views.getView(editor).getAttribute('style') isnt null
        oldStyle = atom.views.getView(editor).getAttribute('style')
      else
        oldStyle = ''
      newStyle = oldStyle + 'max-width:' + editor.getDefaultCharWidth() * atom.config.get([scope],'editor.preferredLineLength') + 'px;'
      atom.views.getView(editor).setAttribute('style', newStyle)
      atom.views.getView(editor).setAttribute('data-typewriter', true)

    if editor isnt undefined # e.g. settings-view
      if editor.getRootScopeDescriptor().scopes[0] is 'source.gfm'
        typewriterMode('source.gfm')

      if editor.getRootScopeDescriptor().scopes[0] is 'text.html.mediawiki'
        typewriterMode('text.html.mediawiki')


  stop: () ->
    $ = require 'jquery'
    $('atom-text-editor:not(.mini)').css 'max-width', ''

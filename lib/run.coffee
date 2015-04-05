module.exports =

  start: () ->
    requestAnimationFrame -> # wait for other dom changes
      scopes = atom.config.get('typewriter.scopes').split(',')
      editor = atom.workspace.getActiveTextEditor()

      if editor isnt undefined # e.g. settings-view
        currentScope = editor.getRootScopeDescriptor().scopes[0]
        if currentScope in scopes
          if atom.views.getView(editor).getAttribute('style') isnt null
            oldStyle = atom.views.getView(editor).getAttribute('style')
          else
            oldStyle = ''

          characterWidth = editor.getDefaultCharWidth()
          charactersPerLine = atom.config.get([currentScope],'editor.preferredLineLength')
          newStyle = oldStyle + 'max-width:' + characterWidth * charactersPerLine + 'px;'

          atom.config.set('.' + currentScope, 'editor.softWrap', true)
          atom.views.getView(editor).setAttribute('style', newStyle)
          atom.views.getView(editor).setAttribute('data-typewriter', true)


  stop: () ->
    $ = require 'jquery'
    $('[data-typewriter]').attr('data-typewriter', false)
    $('atom-text-editor:not(.mini)').css 'max-width', ''

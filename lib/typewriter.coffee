TypewriterView = require './typewriter-view'
{CompositeDisposable} = require 'atom'

module.exports = Typewriter =
  typewriterView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @typewriterView = new TypewriterView(state.typewriterViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @typewriterView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'typewriter:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @typewriterView.destroy()

  serialize: ->
    typewriterViewState: @typewriterView.serialize()

  toggle: ->
    console.log 'Typewriter was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

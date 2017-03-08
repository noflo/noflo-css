noflo = require 'noflo'

# @runtime noflo-browser

class SetElementTop extends noflo.Component
  description: 'Set element\'s CSS top'
  icon: 'arrows-v'
  constructor: ->
    @element = null
    @inPorts =
      element: new noflo.Port 'object'
      top: new noflo.Port 'number'
    @outPorts = {}
    
    @inPorts.element.on 'data', (element) =>
      @element = element

    @inPorts.top.on 'data', (top) =>
      return unless @element
      @element.style.position = 'absolute'
      @element.style.top = "#{top}px"

exports.getComponent = -> new SetElementTop

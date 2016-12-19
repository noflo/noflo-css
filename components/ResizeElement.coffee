noflo = require 'noflo'

# @runtime noflo-browser

class ResizeElement extends noflo.Component
  description: 'Change the size of a DOM element'
  icon: 'arrows'
  constructor: ->
    @element = null
    @inPorts =
      element: new noflo.Port 'object'
      size: new noflo.Port 'object'
      width: new noflo.Port 'number'
      height: new noflo.Port 'number'

    @inPorts.element.on 'data', (element) =>
      @element = element
    @inPorts.size.on 'data', (size) =>
      @setPosition 'width', "#{size.width}px"
      @setPosition 'height', "#{size.height}px"
    @inPorts.width.on 'data', (width) =>
      @setPosition 'width', "#{width}px"
    @inPorts.height.on 'data', (height) =>
      @setPosition 'height', "#{height}px"

  setPosition: (attr, value) ->
    @element.style.position = 'absolute'
    @element.style[attr] = value

exports.getComponent = -> new ResizeElement

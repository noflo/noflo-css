noflo = require 'noflo'

class RotateElement extends noflo.Component
  description: 'Change the coordinates of a DOM element'
  constructor: ->
    @element = null
    @inPorts =
      element: new noflo.Port 'object'
      percent: new noflo.Port 'number'

    @inPorts.element.on 'data', (element) =>
      @element = element
    @inPorts.percent.on 'data', (percent) =>
      if @element
        @setRotation @element, percent

  setRotation: (element, percent) ->
    degrees = 360 * percent % 360
    @setVendor element, "transform", "rotate(#{degrees}deg)"

  setVendor: (element, property, value) ->
    propertyCap = property.charAt(0).toUpperCase() + property.substr(1)
    element.style["webkit" + propertyCap] = value
    element.style["moz" + propertyCap] = value
    element.style["ms" + propertyCap] = value
    element.style["o" + propertyCap] = value
    element.style[property] = value

exports.getComponent = -> new RotateElement

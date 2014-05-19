noflo = require 'noflo'

class RotateElement extends noflo.Component
  description: 'Change the coordinates of a DOM element'
  icon: 'rotate-right'
  constructor: ->
    @element = null
    # GPU accelerate by default
    @gpuAccelerate = 'translateZ(0px) translate3d(0px, 0px, 0px)'
    @inPorts =
      element: new noflo.Port 'object'
      percent: new noflo.Port 'number'
      degrees: new noflo.Port 'number'
      # Pass `false` to turn off GPU acceleration
      gpu: new noflo.Port 'boolean'

    @inPorts.element.on 'data', (element) =>
      @element = element
    @inPorts.percent.on 'data', (percent) =>
      return unless @element
      degrees = 360 * percent % 360
      @setRotation @element, degrees
    @inPorts.degrees.on 'data', (degrees) =>
      return unless @element
      @setRotation @element, degrees
    @inPorts.gpu.on 'data', (gpu) =>
      @gpuAccelerate =
        if   gpu
        then 'translateZ(0px) translate3d(0px, 0px, 0px)'
        else ''

  setRotation: (element, degrees) ->
    @setVendor element, "transform", "rotate(#{degrees}deg) #{@gpuAccelerate}"

  setVendor: (element, property, value) ->
    propertyCap = property.charAt(0).toUpperCase() + property.substr(1)
    element.style["webkit" + propertyCap] = value
    element.style["moz" + propertyCap] = value
    element.style["ms" + propertyCap] = value
    element.style["o" + propertyCap] = value
    element.style[property] = value

exports.getComponent = -> new RotateElement

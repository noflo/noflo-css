noflo = require 'noflo'

# @runtime noflo-browser

setSize = (element, attr, value) ->
  element.style.position = 'absolute'
  element.style[attr] = "#{value}px"

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Change the size of a DOM element'
  c.icon = 'arrows'
  c.inPorts.add 'element',
    datatype: 'object'
    control: true
  c.inPorts.add 'size',
    datatype: 'object'
  c.inPorts.add 'width',
    datatype: 'number'
  c.inPorts.add 'height',
    datatype: 'number'
  c.outPorts.add 'out',
    datatype: 'bang'
  c.process (input, output) ->
    return unless input.hasData 'element'
    if input.hasData 'size'
      [element, size] = input.getData 'element', 'size'
      setSize element, 'width', size.width
      setSize element, 'height', size.height
      output.sendDone
        out: true
      return
    if input.hasData 'width'
      [element, width] = input.getData 'element', 'width'
      setSize element, 'width', width
      output.sendDone
        out: true
      return
    if input.hasData 'height'
      [element, height] = input.getData 'element', 'height'
      setSize element, 'height', height
      output.sendDone
        out: true
      return

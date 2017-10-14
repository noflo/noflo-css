noflo = require 'noflo'

# @runtime noflo-browser

setPosition = (element, attr, value) ->
  if attr in ['top', 'left']
    value = "#{value}px"
  element.style.position = 'absolute'
  element.style[attr] = value

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Change the coordinates of a DOM element'
  c.icon = 'arrows'
  c.inPorts.add 'element',
    datatype: 'object'
    control: true
  c.inPorts.add 'point',
    datatype: 'object'
  c.inPorts.add 'x',
    datatype: 'number'
  c.inPorts.add 'y',
    datatype: 'number'
  c.inPorts.add 'z',
    datatype: 'number'
  c.outPorts.add 'out',
    datatype: 'bang'

  c.process (input, output) ->
    return unless input.hasData 'element'
    if input.hasData 'point'
      [element, point] = input.getData 'element', 'point'
      setPosition element, 'left', point.x
      setPosition element, 'top', point.y
      output.sendDone
        out: true
      return
    if input.hasData 'x'
      [element, x] = input.getData 'element', 'x'
      setPosition element, 'left', x
      output.sendDone
        out: true
      return
    if input.hasData 'y'
      [element, y] = input.getData 'element', 'y'
      setPosition element, 'top', y
      output.sendDone
        out: true
      return
    if input.hasData 'z'
      [element, z] = input.getData 'element', 'z'
      setPosition element, 'zIndex', z
      output.sendDone
        out: true
      return

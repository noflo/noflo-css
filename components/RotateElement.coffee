noflo = require 'noflo'

# @runtime noflo-browser

setRotation = (element, degrees, gpu) ->
  transform = "rotate(#{degrees}deg)"
  if gpu
    transform = "#{transform} translateZ(0px) translate3d(0px, 0px, 0px)"
  element.style.transform = transform

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Change the coordinates of a DOM element'
  c.icon = 'rotate-right'
  c.inPorts.add 'element',
    datatype: 'object'
    control: true
  c.inPorts.add 'percent',
    datatype: 'number'
  c.inPorts.add 'degrees',
    datatype: 'number'
  c.inPorts.add 'gpu',
    datatype: 'boolean'
    control: true
    default: true
    description: 'Whether to GPU-accelerate the rotation'
  c.outPorts.add 'out',
    datatype: 'bang'

  c.process (input, output) ->
    return unless input.hasData 'element'
    if input.hasData 'percent'
      [element, percent] = input.getData 'element', 'percent'
      gpu = if input.hasData('gpu') then input.getData('gpu') else true
      degrees = 360 * percent % 360
      setRotation element, degrees, gpu
      output.sendDone
        out: true
      return
    if input.hasData 'degrees'
      [element, degrees] = input.getData 'element', 'degrees'
      gpu = if input.hasData('gpu') then input.getData('gpu') else true
      setRotation element, degrees, gpu
      output.sendDone
        out: true
      return

noflo = require 'noflo'

# @runtime noflo-browser

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Set element\'s CSS top'
  c.icon = 'arrows-v'
  c.inPorts.add 'element',
    datatype: 'object'
  c.inPorts.add 'top',
    datatype: 'number'
  c.outPorts.add 'out',
    datatype: 'bang'
  c.process (input, output) ->
    return unless input.hasData 'element', 'top'
    [element, top] = input.getData 'element', 'top'
    element.style.position = 'absolute'
    element.style.top = "#{top}px"
    output.sendDone
      out: true

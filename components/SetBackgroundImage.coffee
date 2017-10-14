noflo = require 'noflo'

# @runtime noflo-browser

exports.getComponent = ->
  c = new noflo.Component
  c.description = 'Set element\'s CSS background image'
  c.icon = 'picture'
  c.inPorts.add 'element',
    datatype: 'object'
    control: true
  c.inPorts.add 'imagedata',
    datatype: 'string'
  c.outPorts.add 'out',
    datatype: 'bang'

  c.process (input, output) ->
    return unless input.hasData 'element', 'imagedata'
    [element, imagedata] = input.getData 'element', 'imagedata'
    element.style.background = 'url(' + imagedata + ') no-repeat center'
    output.sendDone
      out: true

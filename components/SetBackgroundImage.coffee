noflo = require 'noflo'

class SetBackgroundImage extends noflo.Component
  description: 'Set element\'s CSS background image'
  icon: 'picture'
  constructor: ->
    @element = null
    @inPorts =
      element: new noflo.Port 'object'
      imagedata: new noflo.Port 'string'
    
    @inPorts.element.on 'data', (element) =>
      @element = element

    @inPorts.imagedata.on 'data', (imagedata) =>
      return unless @element
      @element.style.background = 'url(' + imagedata + ') no-repeat center'

exports.getComponent = -> new SetBackgroundImage

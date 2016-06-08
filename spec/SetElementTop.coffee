noflo = require 'noflo'
baseDir = 'noflo-css'

describe 'SetElementTop component', ->
  c = null
  element = null
  top = null
  out = null
  before (done) ->
    @timeout 4000
    loader = new noflo.ComponentLoader baseDir
    loader.load 'css/SetElementTop', (err, instance) ->
      return done err if err
      c = instance
      element = noflo.internalSocket.createSocket()
      c.inPorts.element.attach element
      top = noflo.internalSocket.createSocket()
      c.inPorts.top.attach top
      done()

  describe 'receiving an element and value', ->
    it 'should update element properties', (done) ->
      el = document.getElementById 'setelementtop'
      unless el
        return done new Error 'Fixture not available'
      element.send el
      top.send 10
      setTimeout ->
        chai.expect(el.style.position).to.equal 'absolute'
        chai.expect(el.style.top).to.equal '10px'
        done()
      , 1

noflo = require 'noflo'
baseDir = 'noflo-css'

describe 'ResizeElement component', ->
  c = null
  element = null
  size = null
  out = null
  before (done) ->
    @timeout 4000
    loader = new noflo.ComponentLoader baseDir
    loader.load 'css/ResizeElement', (err, instance) ->
      return done err if err
      c = instance
      element = noflo.internalSocket.createSocket()
      c.inPorts.element.attach element
      size = noflo.internalSocket.createSocket()
      c.inPorts.size.attach size
      done()
  beforeEach ->
    out = noflo.internalSocket.createSocket()
    c.outPorts.out.attach out
  afterEach ->
    c.outPorts.out.detach out
    out = null

  describe 'receiving an element and value', ->
    it 'should update element properties', (done) ->
      el = document.getElementById 'resizeelement'
      unless el
        return done new Error 'Fixture not available'
      out.on 'data', ->
        chai.expect(el.style.position).to.equal 'absolute'
        chai.expect(el.style.width).to.equal '20px'
        chai.expect(el.style.height).to.equal '42px'
        done()
      element.send el
      size.send
        height: 42
        width: 20

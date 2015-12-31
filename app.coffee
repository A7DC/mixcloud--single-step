# Import file "mixcloudframer-two"
$ = Framer.Importer.load("imported/mixcloudframer-two@1x")

# import web fonts
Utils.insertCSS('@import url(https://fonts.googleapis.com/css?family=Open+Sans:600);')

# background layer
bg = new BackgroundLayer
	image: 'images/bg-dark.png'
	
bg.states.add
	loggedin:
		image: 'images/bg-mixcloud--logged-in.png'

# view positioning
view = $.view
view.x = 0
view.y = 142

viewEnd = new Animation
    layer: view
    properties:
        y: -view.height
    delay: 1
    curve: "spring-dho(800, 200, 10, 0.01)"
    
viewEnd.on Events.AnimationEnd, ->
	bg.states.switchInstant('loggedin')

view.states.add
	off:
		y: -view.height
		opacity: 0
view.states.animationOptions =
	curve:"spring(50,15,0)"

view.centerX()

$.btngroup.superLayer = view
$.btngroup.y = 330
$.btngroup.centerX()

# Create the title for the current view
viewHeading = new Layer
	width: view.width
	superLayer: view
	height: 40
	y: $.main.minY - 45
	backgroundColor: bg.backgroundColor
	html: "Choose how to login"

viewHeading.style =
	'font': '22px/16px Open Sans'
	'text-align': 'center'
	
viewHeading.states.add
	passwordHeading:
		html: "Welcome back,"
	userHeading:
		html: "Choose how to login"

inputContainer = new Layer
	superLayer: view
	height: (40 * 2) + 20
	width: view.width

# Amount of inputs we want		
inputAmount = 2

# Generate inputs
for i in [0...inputAmount]
	# Create the input for username and password
	textInputLayer = new Layer 
		x: 37
		y: 60 * i
		width: 258
		height: 40
		superLayer: inputContainer
		borderWidth: 1
		borderColor: "#D3D3D3"
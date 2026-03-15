class_name RandomNameGenerator
## Provides facility for creating a random name for players
##
## Limited right now to just using a liost of hard-coded values, copy of the Breakout Invaders logic

#region [Name List]
# prefix/suffixes for usernames in case player does not enter anything
# for his name we will generate a random one
const PREFIX: Array[String] = [
	"Dark",
	"Zany",
	"Giggle",
	"Bad",
	"Hairy",
	"Frosted",
	"Wobbly",
	"Wacky",
	"Sir",
	"Miss",
	"Dancing",
	"Captain",
	"Ninja",
	"Grumpy"
]

const SUFFIX: Array[String] = [
	"Banana",
	"Zuchini",
	"Jelly",
	"Cupcake",
	"Potato",
	"Noodles",
	"Taco",
	"Penguin",
	"Turtle",
	"Chicken",
	"Wombat",
	"Goose"
]
#endregion


static func pick_one() -> String:
	return PREFIX.pick_random() + " " + SUFFIX.pick_random()

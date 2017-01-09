towns.formspecs = {}
local forms = towns.formspecs
	
forms.town_block_new =
	"size[7,7]" ..
	default.gui_bg ..
	default.gui_bg_img ..
	default.gui_slots ..
	"image[3,2;3,3:towns_town_block.png]"
	"list[]"

forms.town_block_town = 
	"size[12,9]" ..
	default.gui_bg ..

--forms.town_block_upgrade = ""

forms.town_block_contested = ""


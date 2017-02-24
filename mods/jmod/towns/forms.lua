towns.formspecs = {}
local forms = towns.formspecs
	
forms.town_setup =
	"size[6,4]" ..
	towns.gui_bg ..
	towns.gui_bg_img ..
	towns.gui_slots ..
	"image[3,2;3,3:new_town_icon.png]"
	"list[]"

forms.town_home = 
	"size[12,9]" ..
	towns.gui_bg ..

--forms.town_housing = ""
--forms.town_industry = ""
--forms.town_economy = ""
--forms.town_military = ""


--forms.found_town = ""

--forms.capture_town = ""

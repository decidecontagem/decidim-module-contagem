// Images
require.context("../images", true)

// Controllers
import HorizontalMenuController from "./src/controllers/horizontal_menu_controller"

window.Stimulus.register("horizontal-menu", HorizontalMenuController)

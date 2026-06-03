import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle", "menu"]

  connect() {
    this._onResize = this._handleResize.bind(this)
    window.addEventListener("resize", this._onResize)
  }

  disconnect() {
    window.removeEventListener("resize", this._onResize)
  }

  toggle() {
    const isOpen = this.toggleTarget.getAttribute("aria-expanded") === "true"
    this._setOpen(!isOpen)
  }

  close() {
    this._setOpen(false)
  }

  // private

  _setOpen(open) {
    this.toggleTarget.setAttribute("aria-expanded", open)
    this.menuTarget.classList.toggle("hidden", !open)
    this.menuTarget.classList.toggle("show", open)
  }

  _handleResize() {
    if (window.innerWidth >= 1024) {
      this.menuTarget.classList.remove("hidden", "show")
      this.toggleTarget.setAttribute("aria-expanded", "false")
    }
  }
}

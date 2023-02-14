import { Controller } from "@hotwired/stimulus"
import datepicker from 'js-datepicker'

export default class extends Controller {
  static targets = ["links", "template", "invite"]

  connect() {
    let links = this.linksTarget
    let nestedFieldsCount = this.element.querySelectorAll('.nested-fields').length

    if(links && nestedFieldsCount == 0) {
      let content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime()).replace(/DATE_INPUT/g, 'date-input-1')
      links.insertAdjacentHTML('beforebegin', content)
    }

  }

  start_association(event) {
    event.preventDefault()

    let invitationForm = document.querySelector("#invitation-list [data-controller='nested-form']")
    let links = invitationForm.querySelector('[data-nested-form-target="links"]')
    let content = invitationForm.querySelector('[data-nested-form-target="template"]').innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
      .replace(/DATE_INPUT/g, `date-input${document.querySelectorAll('.nested-fields').length}`)
    links.insertAdjacentHTML('beforebegin', content)
  }

  add_association(event) {
    event.preventDefault()

    let content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    let links = this.linksTarget
    
    links.insertAdjacentHTML('beforebegin', content)
  }

  remove_association(event) {
    event.preventDefault()
    
    event.target.closest(".nested-fields").remove()
  }
}

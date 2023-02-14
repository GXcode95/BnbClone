
import { Controller } from "@hotwired/stimulus"
import datepicker from 'js-datepicker'

export default class extends Controller {
  connect() {  
    let form = document.querySelector('form.new_reservation')
    let checkin = form.querySelector('#reservation_checkin')
    let checkout = form.querySelector('#reservation_checkout')
    
    const pickerOut = datepicker(checkout, {
      respectDisabledReadOnly: true,
      minDate: new Date(days[0].date),
      maxDate: new Date(days[days.length - 1].date)
    })
    
    const pickerIn = datepicker(checkin, {
      onSelect: (instance, date) => {
        // reset checkout date to match checkin date
        if (checkout.value && new Date(checkout.value) < date) 
          pickerOut.setDate()
          
        // prepare pickerOut dates
        let lastNextFreeDay = this.getLastNextFreeDay(days, new Date(date))
        let maxDate = new Date(lastNextFreeDay.date)
        pickerOut.setMax(maxDate)
        pickerOut.setMin(date)
        checkout.disabled = false
      },
      disabler: date => days.findIndex(day => day.date === this.parseDateForRuby(date) && !day.taken) == -1
    })

    checkin.addEventListener('change', () => {
      checkout.disabled = true
      pickerIn.setDate()
      pickerOut.setDate()
    })
  }


  getLastNextFreeDay(days, date) {
    let formattedDate = this.parseDateForRuby(date)
    let selected_day_index = days.findIndex(day => day.date === formattedDate)
    let lastNextFreeDay = null
    
    while (lastNextFreeDay == null && selected_day_index < days.length -1) {
      selected_day_index ++
      date.setDate(date.getDate() +1)
      let nextDate = this.parseDateForRuby(date)
    
      if (days[selected_day_index].date != nextDate || days[selected_day_index].taken)
        lastNextFreeDay = days[selected_day_index - 1]
    }
    
    return lastNextFreeDay ? lastNextFreeDay : days[days.length - 1]
  }

  parseDateForRuby(date) {
    let formattedDateDay = date.getDate().toString().length == 1 ? `0${date.getDate()}` : date.getDate()
    let formattedMonth =  date.getMonth().toString().length == 1 ? `0${date.getMonth() + 1}` : date.getMonth() + 1

    return  `${date.getFullYear()}-${formattedMonth}-${formattedDateDay}`
  }
}

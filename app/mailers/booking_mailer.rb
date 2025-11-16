class BookingMailer < ApplicationMailer
    def new_booking_email
      @booking = params[:booking]
  
      mail(to: "lightcornerhouse@gmail.com", subject: "Nova reserva - #{@booking[:casa]}")
    end
  end
  
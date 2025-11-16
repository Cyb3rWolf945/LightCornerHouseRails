class BookingsController < ApplicationController
    def create
      booking_params = params.permit(
        :nome, :email, :casa, :casa_id, :adultos, :criancas,
        :data_inicio, :data_fim, :mensagem
      )
  
      begin
        data_inicio = Date.parse(booking_params[:data_inicio])
        data_fim = Date.parse(booking_params[:data_fim])
      rescue ArgumentError
        flash[:alert] = "Invalid dates provided."
        redirect_back(fallback_location: root_path) and return
      end
  
      # Debug para ver as datas no log
      Rails.logger.debug "data_inicio: #{data_inicio}, data_fim: #{data_fim}"
  
      if data_fim <= data_inicio
        flash[:alert] = "Check-out date must be after check-in date."
        redirect_back(fallback_location: root_path) and return
      end
  
      # Se chegou aqui, datas válidas
      BookingMailer.with(booking: booking_params).new_booking_email.deliver_now
      redirect_back fallback_location: root_path, notice: "Reserva enviada com sucesso! Entraremos em contacto."
    end
  end
  
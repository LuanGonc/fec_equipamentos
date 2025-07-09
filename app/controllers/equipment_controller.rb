class EquipmentController < ApplicationController
  before_action :set_equipment, only: %i[ show edit update destroy ]

  # GET /equipment or /equipment.json
  def index
    @q = Equipment.ransack(params[:q])
    @equipments = @q.result(distinct: true)
  end

  # GET /equipment/1 or /equipment/1.json
  def show
    @equipment = Equipment.find(params[:id])
    @q = Loan.where(equipment_id: @equipment.id).ransack(params[:q]) #aplica o filtor de equipamento primeiro, depois o Ransack fintra dentro disso
    @filtered_loans = @q.result.includes(:collaborator).order(created_at: :desc)
  end

  # GET /equipment/new
  def new
    @equipment = Equipment.new
  end

  # GET /equipment/1/edit
  def edit
  end

  # POST /equipment or /equipment.json
  def create
    @equipment = Equipment.new(equipment_params)

    respond_to do |format|
      if @equipment.save
        format.html { redirect_to @equipment, notice: "Equipment was successfully created." }
        format.json { render :show, status: :created, location: @equipment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment/1 or /equipment/1.json
  def update
    respond_to do |format|
      if @equipment.update(equipment_params)
        format.html { redirect_to @equipment, notice: "Equipment was successfully updated." }
        format.json { render :show, status: :ok, location: @equipment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment/1 or /equipment/1.json
def destroy
  respond_to do |format|
    if @equipment.loans.any?
      format.html { redirect_to equipment_path(@equipment), alert: "Não é possível excluir um equipamento que já foi emprestado." }
      format.json { render json: { error: "Equipamento com empréstimos não pode ser excluído." }, status: :unprocessable_entity }

    elsif @equipment.status != "disponivel"
      format.html { redirect_to equipment_path(@equipment), alert: "Só é possível excluir equipamentos disponíveis." }
      format.json { render json: { error: "Equipamento não disponível para exclusão." }, status: :unprocessable_entity }

    else
      @equipment.destroy!
      format.html { redirect_to equipment_index_path, status: :see_other, notice: "Equipamento apagado com sucesso." }
      format.json { head :no_content }
    end
  end
end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment
      @equipment = Equipment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def equipment_params
      params.require(:equipment).permit(:brand, :model, :patrimony_number, :serial_number, :identifier, :purchase_date, :manufacture_date, :description, :status)
    end
end

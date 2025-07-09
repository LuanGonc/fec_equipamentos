class LoansController < ApplicationController
  before_action :set_loan, only: %i[ show edit update destroy ]

  # GET /loans or /loans.json
  def index
    @q = Loan.ransack(params[:q])
    @loans = @q.result(distinct: true)   
  end

  # GET /loans/1 or /loans/1.json
  def show
  end

  # GET /loans/new
  def new
    @loan = Loan.new
  end

  # GET /loans/1/edit
  def edit
  end

  # POST /loans or /loans.json
def create
  @loan = Loan.new(loan_params)
  @equipment = Equipment.find(@loan.equipment_id)

  case @loan.loan_action
  when "emprestimo"
    if @equipment.status != "disponivel"
      flash[:alert] = "O equipamento não está disponível"
      redirect_to new_loan_path and return
    end

    if @loan.loan_date.blank?
      flash[:alert] = "A data do empréstimo não pode ficar em branco."
      redirect_to new_loan_path and return
    end

    @equipment.update(status: "emprestado")

  when "devolucao"
    if @equipment.status != "emprestado"
      flash[:alert] = "Só é possível devolver um equipamento que está emprestado."
      redirect_to new_loan_path and return
    end

    if @loan.return_date.blank? || @loan.return_reason.blank?
      flash[:alert] = "Data e motivo da devolução são obrigatórios."
      redirect_to new_loan_path and return
    end

    @equipment.update(status: "disponivel")

  when "baixa"
    if @equipment.status != "emprestado"
      flash[:alert] = "Só é possível dar baixa em um equipamento emprestado."
      redirect_to new_loan_path and return
    end

    if @loan.discard_date.blank? || @loan.discard_reason.blank?
      flash[:alert] = "Data e justificativa da baixa são obrigatórias."
      redirect_to new_loan_path and return
    end

    @equipment.update(status: "indisponivel")
  end

  respond_to do |format|
    if @loan.save
      format.html { redirect_to @loan, notice: "Ação realizada com sucesso." }
      format.json { render :show, status: :created, location: @loan }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @loan.errors, status: :unprocessable_entity }
    end
  end
end

  # PATCH/PUT /loans/1 or /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: "Loan was successfully updated." }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1 or /loans/1.json
  def destroy
    @loan.destroy!

    respond_to do |format|
      format.html { redirect_to loans_path, status: :see_other, notice: "Loan was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def loan_params
      params.require(:loan).permit(:equipment_id, :collaborator_id, :loan_action, :loan_date, :return_date, :return_reason, :discard_date, :discard_reason)
    end
end

class LoansController < ApplicationController
  before_action :set_loan, only: %i[show edit update destroy]
  skip_before_action :set_loan, only: %i[new create index]
  # GET /loans or /loans.json
  def index
    @q = Loan.ransack(params[:q])
    @loans = @q.result(distinct: true)
  end

  # GET /loans/1 or /loans/1.json
  def show; end

  # GET /loans/new
  def new
    @loan = Loan.new
  end

  # GET /loans/1/edit
  def edit; end

  # POST /loans or /loans.json
  def create
    @loan = Loan.new(loan_params)
    @equipment = Equipment.find(@loan.equipment_id) if @loan.equipment_id.present?

    case @loan.loan_action
    when 'emprestimo'
      return handle_loan_creation
    when 'devolucao'
      return handle_return_creation
    when 'baixa'
      return handle_write_off_creation
    end

    handle_save
  end
  
  # PATCH/PUT /loans/1 or /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: 'Notebook atualizado com sucesso.' }
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
      format.html { redirect_to loans_path, status: :see_other, notice: 'Empréstimo apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private


  def handle_loan_creation
   
    if @equipment.nil?
      @loan.errors.add(:equipment, "é obrigatório")
      render :new
      return
    end

    
    if @equipment.status != 'disponivel'
      @loan.errors.add(:base, 'O notebook não está disponível.')
      render :new
    else
      handle_save do
        @equipment.update!(status: 'emprestado', loaned_for: @loan.collaborator.name)
        'Notebook emprestado com sucesso.'
      end
    end
  end

  def handle_return_creation
    
    if @equipment.nil?
      @loan.errors.add(:equipment, "é obrigatório")
      render :new
      return
    end

    
    if @equipment.status != 'emprestado'
      @loan.errors.add(:base, 'Só é possível devolver um notebook que está emprestado.')
      render :new
    else
      @last_loan = Loan.where(equipment_id: @loan.equipment_id, loan_action: 'emprestimo')
                      .order(created_at: :desc)
                      .first

      if @last_loan.nil?
        @loan.errors.add(:base, 'Não foi encontrado um empréstimo válido para este equipamento.')
        render :new
      elsif @loan.collaborator_id != @last_loan.collaborator_id
        @loan.errors.add(:base, 'Somente o colaborador que fez o empréstimo pode devolver o notebook.')
        render :new
      else
        handle_save do
          @equipment.update!(status: 'disponivel', loaned_for: "")
          'Notebook devolvido com sucesso.'
        end
      end
    end
  end

  def handle_write_off_creation
    
    if @equipment.nil?
      @loan.errors.add(:equipment, "é obrigatório")
      render :new
      return
    end

    handle_save do
      @equipment.update!(status: 'indisponivel', loaned_for: "")
      'Baixa realizada com sucesso.'
    end
  end
  
  def handle_save(&block)
    if @loan.save
      yield if block_given? 
      notice_message = block_given? ? block.call : 'Operação realizada com sucesso.'
      
      respond_to do |format|
        format.html { redirect_to @loan, notice: notice_message }
        format.json { render :show, status: :created, location: @loan }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  

  # Use callbacks to share common setup or constraints between actions.
  def set_loan
    @loan = Loan.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def loan_params
    params.require(:loan).permit(:equipment_id, :collaborator_id, :loan_action, :loan_date, :return_date,
                                 :return_reason, :discard_date, :discard_reason)
  end
end

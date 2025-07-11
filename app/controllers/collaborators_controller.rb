class CollaboratorsController < ApplicationController
  before_action :set_collaborator, only: %i[show edit update destroy]

  # GET /collaborators or /collaborators.json
  def index
    @q = Collaborator.ransack(params[:q])
    @collaborators = @q.result(distinct: true).page(params[:page]).per(5)
  end

  # GET /collaborators/1 or /collaborators/1.json
  def show
    @collaborator = Collaborator.find(params[:id])
    @q = Loan.where(collaborator_id: @collaborator.id).ransack(params[:q]) # aplica o filtor de Colaborador primeiro, depois o Ransack filtra dentro disso
    @filtered_loans = @q.result.includes(:equipment).order(created_at: :desc)
  end

  # GET /collaborators/new
  def new
    @collaborator = Collaborator.new
  end

  # GET /collaborators/1/edit
  def edit; end

  # POST /collaborators or /collaborators.json
  def create
    @collaborator = Collaborator.new(collaborator_params)

    respond_to do |format|
      if @collaborator.save
        format.html { redirect_to @collaborator, notice: 'Colaborador criado com sucesso.' }
        format.json { render :show, status: :created, location: @collaborator }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /collaborators/1 or /collaborators/1.json
  def update
    respond_to do |format|
      if @collaborator.update(collaborator_params)
        format.html { redirect_to @collaborator, notice: 'Colaborador atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @collaborator }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @collaborator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collaborators/1 or /collaborators/1.json
  def destroy
    @collaborator.destroy!

    respond_to do |format|
      format.html { redirect_to collaborators_path, status: :see_other, notice: 'Colaborador apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_collaborator
    @collaborator = Collaborator.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def collaborator_params
    params.require(:collaborator).permit(:name, :email, :department)
  end
end

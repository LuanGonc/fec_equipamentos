require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  ######
  describe 'GET #new' do
    it 'atribui um novo Loan à variável @loan e renderiza o template' do
      get :new
      expect(assigns(:loan)).to be_a_new(Loan)
      expect(response).to render_template(:new)
    end
  end

  ######
  describe 'POST #create' do

    context 'com parâmetros válidos para empréstimo' do
      let(:equipment) { create(:equipment, status: 'disponivel') }
      let(:collaborator) { create(:collaborator) }
      let(:valid_params) do
        {
          loan: {
            loan_action: 'emprestimo',
            loan_date: Date.today,
            equipment_id: equipment.id,
            collaborator_id: collaborator.id
          }
        }
      end

      it 'cria um novo empréstimo e redireciona para a página de show' do
        expect do
          post :create, params: valid_params
        end.to change(Loan, :count).by(1)

        expect(response).to redirect_to(Loan.last)
        expect(flash[:notice]).to eq('Notebook emprestado com sucesso.')
      end

      it "altera o status do equipamento para 'emprestado'" do
        post :create, params: valid_params
        expect(equipment.reload.status).to eq('emprestado')
      end
    end

    context 'com parâmetros válidos para devolução' do
      let(:equipment) { create(:equipment, status: 'emprestado') }
      let(:collaborator) { create(:collaborator) }

      let(:valid_return_params) do
        {
          loan: {
            loan_action: 'devolucao',
            return_date: Date.today,
            return_reason: 'Retorno por fim de uso',
            equipment_id: equipment.id,
            collaborator_id: collaborator.id
          }
        }
      end

      it 'cria uma devolução e redireciona para a página de show' do
        expect do
          post :create, params: valid_return_params
        end.to change(Loan, :count).by(1)

        expect(response).to redirect_to(Loan.last)
        expect(flash[:notice]).to eq('Notebook emprestado com sucesso.')
      end

      it "altera o status do equipamento para 'disponivel'" do
        post :create, params: valid_return_params
        expect(equipment.reload.status).to eq('disponivel')
      end
    end

    context 'com parâmetros inválidos para empréstimo' do
      let(:equipment) { create(:equipment, status: 'disponivel') }
      let(:collaborator) { create(:collaborator) }

      it "não cria o empréstimo e redireciona para 'new'" do
        expect do
          post :create, params: {
            loan: {
              loan_action: 'emprestimo',
              equipment_id: equipment.id,
              collaborator_id: collaborator.id,
              loan_date: nil
            }
          }
        end.not_to change(Loan, :count)

        expect(response).to redirect_to(new_loan_path)
        expect(flash[:alert]).to eq('A data do empréstimo não pode ficar em branco.')
      end
    end

    context 'com parâmetros inválidos para devolução' do
      let(:equipment) { create(:equipment, status: 'emprestado') }
      let(:collaborator) { create(:collaborator) }

      it "não cria a devolução e redireciona para 'new'" do
        expect do
          post :create, params: {
            loan: {
              loan_action: 'devolucao',
              equipment_id: equipment.id,
              collaborator_id: collaborator.id
              # return_date e return_reason ausentes
            }
          }
        end.not_to change(Loan, :count)

        expect(response).to redirect_to(new_loan_path)
        expect(flash[:alert]).to eq('Data e motivo da devolução são obrigatórios.')
      end
    end

    context 'com parâmetros inválidos para baixa' do
      let(:equipment) { create(:equipment) }
      let(:collaborator) { create(:collaborator) }
      it "não cria a baixa e redireciona para 'new'" do
        expect do
          post :create, params: {
            loan: {
              loan_action: 'baixa',
              equipment_id: equipment.id,
              collaborator_id: collaborator.id
              # discard_date e discard_reason ausentes
            }
          }
        end.not_to change(Loan, :count)

        expect(response).to redirect_to(new_loan_path)
        expect(flash[:alert]).to eq('Data e justificativa da baixa são obrigatórias.')
      end
    end
  end


  ######
  describe "GET #index" do
    before do
      create_list(:loan, 3) #usa a factory
      get :index
    end

    it "atribui todos os empréstimos à variável @loans" do
      expect(assigns(:loans).count).to eq(3)
      expect(assigns(:loans)).to all(be_a(Loan))
    end

    it "renderiza o template index" do
      expect(response).to render_template(:index)
      expect(response).to have_http_status(:ok)
    end
  end
end
